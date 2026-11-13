"""Run the M3 one-seat registration race against the PostgreSQL demo database.

Requires psycopg 3. Uses ten distinct students to race for one seat in LHP401.
It creates temporary IT202 prerequisite records for N109-N116, refuses conflicting
test fixtures, then restores LHP401/LHP301 and removes only its own fixture rows.

Install: python -m pip install "psycopg[binary]"
PowerShell (optional connection settings): $env:PGDATABASE = "csdl_nc"
                                         $env:PGUSER = "postgres"
                                         python m3_concurrency.py --rounds 10
Without DATABASE_URL the runner prompts for the database password without echoing it.
"""

from __future__ import annotations

import argparse
import json
import os
import statistics
import sys
import threading
import time
from getpass import getpass
from concurrent.futures import ThreadPoolExecutor

try:
    import psycopg
except ImportError:
    print("Missing dependency. Install with: python -m pip install 'psycopg[binary]'")
    raise SystemExit(2)


SECTION = "LHP401"
PREREQUISITE_SECTION = "LHP301"
STUDENTS = tuple(f"N{i:03d}" for i in range(107, 117))
SYNTHETIC_PREREQUISITE_STUDENTS = tuple(f"N{i:03d}" for i in range(109, 117))
TRANSIENT_SQLSTATES = {"40001", "40P01"}  # serialization_failure, deadlock_detected
MAX_RETRIES = 5


def connect(dsn: str):
    return psycopg.connect(dsn)


def active_count(conn) -> int:
    row = conn.execute(
        """SELECT count(*)::int
             FROM hoc_vu.dang_ky
            WHERE ma_lhp = %s AND trang_thai = 'Da dang ky'""",
        (SECTION,),
    ).fetchone()
    return row[0]


def clear_test_rows_and_open_last_seat(dsn: str) -> None:
    with connect(dsn) as conn:
        conn.execute(
            "DELETE FROM hoc_vu.dang_ky WHERE ma_lhp = %s AND ma_sv = ANY(%s)",
            (SECTION, list(STUDENTS)),
        )
        count = active_count(conn)
        conn.execute(
            """UPDATE hoc_vu.lop_hoc_phan
                  SET si_so_hien_tai = %s, si_so_toi_da = %s
                WHERE ma_lhp = %s""",
            (count, count + 1, SECTION),
        )


def register(dsn: str, student: str, mode: str, barrier: threading.Barrier):
    started = time.perf_counter()
    retries = 0

    for attempt in range(MAX_RETRIES + 1):
        conn = connect(dsn)
        try:
            conn.autocommit = True
            if mode == "serializable":
                # Fix isolation before the first data statement/snapshot is taken.
                conn.execute("BEGIN ISOLATION LEVEL SERIALIZABLE")
            else:
                conn.execute("BEGIN")

            if attempt == 0 and mode == "for_update":
                # Force both sessions to start the attempt together. For the unsafe
                # case, synchronization happens after both have read the stale value.
                barrier.wait(timeout=15)

            if mode == "for_update":
                row = conn.execute(
                    """SELECT si_so_hien_tai, si_so_toi_da
                         FROM hoc_vu.lop_hoc_phan
                        WHERE ma_lhp = %s
                        FOR UPDATE""",
                    (SECTION,),
                ).fetchone()
            else:
                row = conn.execute(
                    """SELECT si_so_hien_tai, si_so_toi_da
                         FROM hoc_vu.lop_hoc_phan
                        WHERE ma_lhp = %s""",
                    (SECTION,),
                ).fetchone()

            if attempt == 0 and mode != "for_update":
                # Both unsafe/serializable transactions now hold a snapshot/read
                # of the same initial row before either can update it.
                barrier.wait(timeout=15)

            current, capacity = row
            rejection = registration_rejection(conn, student)
            if rejection:
                conn.execute("ROLLBACK")
                return {"status": "rejected", "reason": rejection,
                        "retries": retries,
                        "latency_ms": (time.perf_counter() - started) * 1000}

            if mode == "unsafe":
                # Both workers read the old current value, then write old+1. With
                # one seat left, both inserts can commit while the counter advances
                # only once: a lost update plus an overbooking discrepancy.
                if current >= capacity:
                    conn.execute("ROLLBACK")
                    return {"status": "sold_out", "retries": retries,
                            "latency_ms": (time.perf_counter() - started) * 1000}
                time.sleep(0.03)
                conn.execute(
                    "UPDATE hoc_vu.lop_hoc_phan SET si_so_hien_tai = %s WHERE ma_lhp = %s",
                    (current + 1, SECTION),
                )
            else:
                # In the locked/serializable variants, the transaction sees the
                # latest row version and does an atomic increment after the check.
                if current >= capacity:
                    conn.execute("ROLLBACK")
                    return {"status": "rejected", "reason": "class_full", "retries": retries,
                            "latency_ms": (time.perf_counter() - started) * 1000}
                conn.execute(
                    """UPDATE hoc_vu.lop_hoc_phan
                          SET si_so_hien_tai = si_so_hien_tai + 1
                        WHERE ma_lhp = %s""",
                    (SECTION,),
                )

            conn.execute(
                """INSERT INTO hoc_vu.dang_ky
                       (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
                     VALUES (%s, %s, clock_timestamp(), 'Da dang ky')""",
                (student, SECTION),
            )
            conn.execute("COMMIT")
            return {"status": "success", "retries": retries,
                    "latency_ms": (time.perf_counter() - started) * 1000}
        except threading.BrokenBarrierError:
            try:
                conn.execute("ROLLBACK")
            except Exception:
                pass
            return {"status": "error", "retries": retries,
                    "latency_ms": (time.perf_counter() - started) * 1000,
                    "error": "worker barrier timed out"}
        except psycopg.Error as exc:
            try:
                conn.execute("ROLLBACK")
            except Exception:
                pass
            if exc.sqlstate in TRANSIENT_SQLSTATES and attempt < MAX_RETRIES:
                retries += 1
                # Small exponential delay prevents immediate repeated collisions.
                time.sleep(0.005 * (2 ** min(retries, 5)))
                continue
            return {"status": "error", "retries": retries,
                    "latency_ms": (time.perf_counter() - started) * 1000,
                    "error": f"{exc.sqlstate}: {exc}"}
        finally:
            conn.close()

    return {"status": "error", "retries": retries,
            "latency_ms": (time.perf_counter() - started) * 1000,
            "error": "retry limit exceeded"}


def registration_rejection(conn, student: str) -> str | None:
    if conn.execute(
        "SELECT 1 FROM hoc_vu.dang_ky WHERE ma_sv = %s AND ma_lhp = %s",
        (student, SECTION),
    ).fetchone():
        return "already_registered"

    missing_prerequisite = conn.execute(
        """SELECT EXISTS (
                 SELECT 1
                   FROM hoc_vu.lop_hoc_phan target
                   JOIN hoc_vu.mon_tien_quyet req ON req.ma_hp = target.ma_hp
                  WHERE target.ma_lhp = %s
                    AND req.loai_dieu_kien = 'Tien quyet'
                    AND NOT EXISTS (
                        SELECT 1
                          FROM hoc_vu.ket_qua_hoc_tap kq
                          JOIN hoc_vu.lop_hoc_phan old_lhp ON old_lhp.ma_lhp = kq.ma_lhp
                         WHERE kq.ma_sv = %s
                           AND old_lhp.ma_hp = req.ma_hp_truoc
                           AND kq.diem_tong_ket >= 5
                    )
             )""",
        (SECTION, student),
    ).fetchone()[0]
    if missing_prerequisite:
        return "missing_prerequisite"

    schedule_conflict = conn.execute(
        """SELECT EXISTS (
                 SELECT 1
                   FROM hoc_vu.lop_hoc_phan target
                   JOIN hoc_vu.lichhoc target_time ON target_time.ma_lhp = target.ma_lhp
                   JOIN hoc_vu.dang_ky dk ON dk.ma_sv = %s
                                           AND dk.trang_thai = 'Da dang ky'
                                           AND dk.ma_lhp <> target.ma_lhp
                   JOIN hoc_vu.lop_hoc_phan enrolled
                     ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = target.ma_hk
                   JOIN hoc_vu.lichhoc enrolled_time ON enrolled_time.ma_lhp = enrolled.ma_lhp
                  WHERE target.ma_lhp = %s
                    AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
                    AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
                    AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
             )""",
        (student, SECTION),
    ).fetchone()[0]
    if schedule_conflict:
        return "schedule_conflict"
    return None


def inspect_state(dsn: str):
    with connect(dsn) as conn:
        row = conn.execute(
            """SELECT l.si_so_hien_tai, l.si_so_toi_da,
                      count(*) FILTER (WHERE d.trang_thai = 'Da dang ky')::int
                 FROM hoc_vu.lop_hoc_phan l
                 LEFT JOIN hoc_vu.dang_ky d ON d.ma_lhp = l.ma_lhp
                WHERE l.ma_lhp = %s
                GROUP BY l.si_so_hien_tai, l.si_so_toi_da""",
            (SECTION,),
        ).fetchone()
    return {"counter": row[0], "capacity": row[1], "registered": row[2],
            "overbooked": row[2] > row[1], "counter_mismatch": row[0] != row[2]}


def explain_analyze(dsn: str):
    sql = """EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
             SELECT l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da,
                    EXISTS (SELECT 1 FROM hoc_vu.dang_ky d
                             WHERE d.ma_sv = 'N107' AND d.ma_lhp = l.ma_lhp
                               AND d.trang_thai = 'Da dang ky') AS da_dang_ky,
                    NOT EXISTS (
                        SELECT 1
                          FROM hoc_vu.mon_tien_quyet req
                         WHERE req.ma_hp = l.ma_hp
                           AND req.loai_dieu_kien = 'Tien quyet'
                           AND NOT EXISTS (
                               SELECT 1
                                 FROM hoc_vu.ket_qua_hoc_tap kq
                                 JOIN hoc_vu.lop_hoc_phan old_lhp
                                   ON old_lhp.ma_lhp = kq.ma_lhp
                                WHERE kq.ma_sv = 'N107'
                                  AND old_lhp.ma_hp = req.ma_hp_truoc
                                  AND kq.diem_tong_ket >= 5
                           )
                    ) AS du_tien_quyet,
                    NOT EXISTS (
                        SELECT 1
                          FROM hoc_vu.lichhoc target_time
                          JOIN hoc_vu.dang_ky dk
                            ON dk.ma_sv = 'N107' AND dk.trang_thai = 'Da dang ky'
                           AND dk.ma_lhp <> l.ma_lhp
                          JOIN hoc_vu.lop_hoc_phan enrolled
                            ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = l.ma_hk
                          JOIN hoc_vu.lichhoc enrolled_time
                            ON enrolled_time.ma_lhp = enrolled.ma_lhp
                         WHERE target_time.ma_lhp = l.ma_lhp
                           AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
                           AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
                           AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
                    ) AS khong_trung_lich
               FROM hoc_vu.lop_hoc_phan l
              WHERE l.ma_lhp = 'LHP401'"""
    with connect(dsn) as conn:
        payload = conn.execute(sql).fetchone()[0]
    if isinstance(payload, str):
        payload = json.loads(payload)
    plan = payload[0]
    print(f"EXPLAIN ANALYZE execution time: {plan['Execution Time']:.3f} ms")
    print(f"EXPLAIN ANALYZE planning time:  {plan['Planning Time']:.3f} ms")


def summarize(label: str, results: list[dict], state: dict):
    latencies = [item["latency_ms"] for item in results]
    successes = sum(item["status"] == "success" for item in results)
    retries = sum(item["retries"] for item in results)
    errors = sum(item["status"] == "error" for item in results)
    total = len(results)
    print(
        f"{label:12} success={successes}/{total} ({successes / total:.1%})  "
        f"retry={retries} errors={errors}  "
        f"latency_avg={statistics.mean(latencies):.2f}ms "
        f"p95={sorted(latencies)[max(0, int(len(latencies) * .95) - 1)]:.2f}ms  "
        f"db(counter/registered/capacity)="
        f"{state['counter']}/{state['registered']}/{state['capacity']}  "
        f"overbooked={state['overbooked']} mismatch={state['counter_mismatch']}"
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--rounds", type=int, default=10,
                        help="ten concurrent registrations per round (default: 10)")
    args = parser.parse_args()
    if args.rounds < 1:
        parser.error("--rounds must be at least 1")
    dsn = os.environ.get("DATABASE_URL")
    if not dsn:
        # Keep the password out of shell history and command-line arguments.
        dsn = psycopg.conninfo.make_conninfo(
            host=os.environ.get("PGHOST", "localhost"),
            port=os.environ.get("PGPORT", "5432"),
            dbname=os.environ.get("PGDATABASE", "postgres"),
            user=os.environ.get("PGUSER", "postgres"),
            password=getpass("PostgreSQL password (blank if not required): "),
        )

    with connect(dsn) as conn:
        originals = conn.execute(
            "SELECT si_so_hien_tai, si_so_toi_da FROM hoc_vu.lop_hoc_phan WHERE ma_lhp = %s",
            (SECTION,),
        ).fetchone()
        if originals is None:
            print(f"{SECTION} not found; load the project schema and seed data first.")
            return 2
        occupied = conn.execute(
            "SELECT ma_sv FROM hoc_vu.dang_ky WHERE ma_lhp = %s AND ma_sv = ANY(%s)",
            (SECTION, list(STUDENTS)),
        ).fetchall()
        if occupied:
            print("Refusing to run: test student(s) already have a LHP401 row: "
                  + ", ".join(row[0] for row in occupied))
            return 2
        source_originals = conn.execute(
            "SELECT si_so_hien_tai, si_so_toi_da FROM hoc_vu.lop_hoc_phan WHERE ma_lhp = %s",
            (PREREQUISITE_SECTION,),
        ).fetchone()
        if source_originals is None:
            print(f"{PREREQUISITE_SECTION} not found; seed data is incomplete.")
            return 2
        synthetic_rows = conn.execute(
            """SELECT ma_sv, 'registration' AS kind
                 FROM hoc_vu.dang_ky
                WHERE ma_lhp = %s AND ma_sv = ANY(%s)
                UNION ALL
               SELECT ma_sv, 'result' AS kind
                 FROM hoc_vu.ket_qua_hoc_tap
                WHERE ma_lhp = %s AND ma_sv = ANY(%s)""",
            (PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS),
             PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS)),
        ).fetchall()
        if synthetic_rows:
            print("Refusing to modify existing IT202 test history for: "
                  + ", ".join(sorted({row[0] for row in synthetic_rows})))
            return 2

    original_current, original_capacity = originals
    source_original_current, source_original_capacity = source_originals
    all_results = {mode: [] for mode in ("unsafe", "for_update", "serializable")}
    overbooked_rounds = {mode: 0 for mode in all_results}
    last_states = {}
    fixture_active = False
    try:
        with connect(dsn) as conn:
            conn.execute(
                """INSERT INTO hoc_vu.dang_ky
                       (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
                     SELECT ma_sv, %s, clock_timestamp(), 'Da dang ky'
                       FROM unnest(%s::varchar[]) AS candidates(ma_sv)""",
                (PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS)),
            )
            conn.execute(
                """INSERT INTO hoc_vu.ket_qua_hoc_tap
                       (ma_sv, ma_lhp, diem_qua_trinh, diem_thi, diem_tong_ket, diem_chu)
                     SELECT ma_sv, %s, 8.0, 8.0, 8.0, 'B'
                       FROM unnest(%s::varchar[]) AS candidates(ma_sv)""",
                (PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS)),
            )
            conn.execute(
                """UPDATE hoc_vu.lop_hoc_phan
                      SET si_so_hien_tai = si_so_hien_tai + %s
                    WHERE ma_lhp = %s""",
                (len(SYNTHETIC_PREREQUISITE_STUDENTS), PREREQUISITE_SECTION),
            )
        fixture_active = True

        for mode in all_results:
            for _ in range(args.rounds):
                clear_test_rows_and_open_last_seat(dsn)
                barrier = threading.Barrier(len(STUDENTS))
                with ThreadPoolExecutor(max_workers=len(STUDENTS)) as pool:
                    futures = [
                        pool.submit(register, dsn, student, mode, barrier)
                        for student in STUDENTS
                    ]
                    results = [future.result() for future in futures]
                state = inspect_state(dsn)
                last_states[mode] = state
                all_results[mode].extend(results)
                overbooked_rounds[mode] += int(state["overbooked"])
                # Delete only test rows and prepare a clean one-seat state for the
                # next repetition; preserve every project's other registration.
                clear_test_rows_and_open_last_seat(dsn)

        for mode, results in all_results.items():
            summarize(mode, results, last_states[mode])
            print(f"             overbooked rounds={overbooked_rounds[mode]}/{args.rounds}")

        # Explicitly race two requests for the same student. The first commits;
        # the second must be rejected as a duplicate, leaving exactly one row.
        clear_test_rows_and_open_last_seat(dsn)
        duplicate_barrier = threading.Barrier(2)
        with ThreadPoolExecutor(max_workers=2) as pool:
            duplicate_results = [
                future.result()
                for future in [
                    pool.submit(register, dsn, "N107", "for_update", duplicate_barrier)
                    for _ in range(2)
                ]
            ]
        duplicate_state = inspect_state(dsn)
        with connect(dsn) as conn:
            duplicate_rows = conn.execute(
                "SELECT count(*)::int FROM hoc_vu.dang_ky WHERE ma_sv = 'N107' AND ma_lhp = %s",
                (SECTION,),
            ).fetchone()[0]
        duplicate_successes = sum(result["status"] == "success" for result in duplicate_results)
        duplicate_rejections = sum(
            result.get("reason") == "already_registered" for result in duplicate_results
        )
        print(
            f"duplicate race success={duplicate_successes}/2 "
            f"duplicate_rejected={duplicate_rejections}/2 "
            f"N107_rows={duplicate_rows} "
            f"counter/registered/capacity={duplicate_state['counter']}/"
            f"{duplicate_state['registered']}/{duplicate_state['capacity']}"
        )
        if duplicate_successes != 1 or duplicate_rejections != 1 or duplicate_rows != 1:
            raise RuntimeError("same-student duplicate registration check failed")

        explain_analyze(dsn)
    finally:
        # Restore exact starting counters and remove only controlled test fixtures.
        with connect(dsn) as conn:
            conn.execute(
                "DELETE FROM hoc_vu.dang_ky WHERE ma_lhp = %s AND ma_sv = ANY(%s)",
                (SECTION, list(STUDENTS)),
            )
            conn.execute(
                """UPDATE hoc_vu.lop_hoc_phan
                      SET si_so_hien_tai = %s, si_so_toi_da = %s
                    WHERE ma_lhp = %s""",
                (original_current, original_capacity, SECTION),
            )
            if fixture_active:
                conn.execute(
                    "DELETE FROM hoc_vu.ket_qua_hoc_tap WHERE ma_lhp = %s AND ma_sv = ANY(%s)",
                    (PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS)),
                )
                conn.execute(
                    "DELETE FROM hoc_vu.dang_ky WHERE ma_lhp = %s AND ma_sv = ANY(%s)",
                    (PREREQUISITE_SECTION, list(SYNTHETIC_PREREQUISITE_STUDENTS)),
                )
                conn.execute(
                    """UPDATE hoc_vu.lop_hoc_phan
                          SET si_so_hien_tai = %s, si_so_toi_da = %s
                        WHERE ma_lhp = %s""",
                    (source_original_current, source_original_capacity,
                     PREREQUISITE_SECTION),
                )
    return 0


if __name__ == "__main__":
    sys.exit(main())
