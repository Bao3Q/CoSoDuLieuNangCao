-- M3: Giao dich dang ky hoc phan va tranh chap dong thoi (PostgreSQL)
-- File doc lap cho phan viec M3. Khong sua quan_ly_hoc_vu.sql / du_lieu_mau.sql.
-- Chay tren database demo co schema hoc_vu va du_lieu_mau.sql.
-- LHP401 (IT301) trong seed du 6/6; N107 va N108 da hoc IT202, chua dang ky LHP401.
-- Ca dang ky kiem tra tien quyet + trung lich; schema chua dinh nghia gioi han tin chi.
--
-- SQL mot session khong tu tao ra duoc cac session dong thoi. Dung runner
-- m3_concurrency.py de chay 2 worker dong thoi va thong ke retry/toc do.
-- Chay file nay: psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f m3_dang_ky.sql

SET search_path TO hoc_vu, public;

-- 0. Kiem tra fixture truoc khi chay. Phai khong co dang_ky LHP401 cho N107/N108.
SELECT l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te
FROM lop_hoc_phan l
LEFT JOIN dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da;

SELECT ma_sv, ma_lhp, trang_thai
FROM dang_ky
WHERE ma_lhp = 'LHP401' AND ma_sv IN ('N107', 'N108');

DO $preflight$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM hoc_vu.lop_hoc_phan WHERE ma_lhp = 'LHP401') THEN
        RAISE EXCEPTION 'Khong tim thay LHP401; hay nap schema va du lieu mau truoc';
    END IF;
    IF EXISTS (
        SELECT 1 FROM hoc_vu.dang_ky
        WHERE ma_lhp = 'LHP401' AND ma_sv IN ('N107', 'N108')
    ) THEN
        RAISE EXCEPTION 'N107/N108 da co dong dang_ky LHP401; hay dung database sach';
    END IF;
END
$preflight$;

-- 1. Chuan bi mot cho trong cho cac vi du SQL thu cong.
-- Chay mot lan tren database demo. Dem lai so dang ky hoat dong lam si_so_hien_tai,
-- sau do dat suc chua = si so + 1. Khong chay dong nay trong luc worker dang chay.
UPDATE hoc_vu.lop_hoc_phan l
SET si_so_hien_tai = x.so_dang_ky,
    si_so_toi_da = x.so_dang_ky + 1
FROM (
    SELECT count(*)::int AS so_dang_ky
    FROM hoc_vu.dang_ky
    WHERE ma_lhp = 'LHP401' AND trang_thai = 'Da dang ky'
) AS x
WHERE l.ma_lhp = 'LHP401';

-- 2. Giao dich rollback khi loi giua chung.
-- DO block co exception handler: cac thay doi trong block bi rollback khi loi
-- co chu y, sau do truy van ben ngoai block van chay duoc.
DO $rollback_demo$
DECLARE
    v_si_so     integer;
    v_toi_da    integer;
    v_error     text;
BEGIN
    SELECT si_so_hien_tai, si_so_toi_da
      INTO v_si_so, v_toi_da
    FROM hoc_vu.lop_hoc_phan
    WHERE ma_lhp = 'LHP401'
    FOR UPDATE;

    IF v_si_so >= v_toi_da THEN
        RAISE EXCEPTION 'LHP401 da het cho';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM hoc_vu.lop_hoc_phan target
        JOIN hoc_vu.mon_tien_quyet req ON req.ma_hp = target.ma_hp
        WHERE target.ma_lhp = 'LHP401'
          AND req.loai_dieu_kien = 'Tien quyet'
          AND NOT EXISTS (
              SELECT 1
              FROM hoc_vu.ket_qua_hoc_tap kq
              JOIN hoc_vu.lop_hoc_phan old_lhp ON old_lhp.ma_lhp = kq.ma_lhp
              WHERE kq.ma_sv = 'N107'
                AND old_lhp.ma_hp = req.ma_hp_truoc
                AND kq.diem_tong_ket >= 5
          )
    ) THEN
        RAISE EXCEPTION 'Sinh vien chua dat mon tien quyet';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM hoc_vu.lop_hoc_phan target
        JOIN hoc_vu.lichhoc target_time ON target_time.ma_lhp = target.ma_lhp
        JOIN hoc_vu.dang_ky dk ON dk.ma_sv = 'N107'
                                AND dk.trang_thai = 'Da dang ky'
                                AND dk.ma_lhp <> target.ma_lhp
        JOIN hoc_vu.lop_hoc_phan enrolled
          ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = target.ma_hk
        JOIN hoc_vu.lichhoc enrolled_time ON enrolled_time.ma_lhp = enrolled.ma_lhp
        WHERE target.ma_lhp = 'LHP401'
          AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
          AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
          AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
    ) THEN
        RAISE EXCEPTION 'Sinh vien bi trung lich hoc';
    END IF;

    IF EXISTS (
        SELECT 1 FROM hoc_vu.dang_ky
        WHERE ma_sv = 'N107' AND ma_lhp = 'LHP401'
    ) THEN
        RAISE EXCEPTION 'Sinh vien da co dong dang ky lop nay';
    END IF;

    UPDATE hoc_vu.lop_hoc_phan
    SET si_so_hien_tai = si_so_hien_tai + 1
    WHERE ma_lhp = 'LHP401';

    INSERT INTO hoc_vu.dang_ky (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
    VALUES ('N107', 'LHP401', clock_timestamp(), 'Da dang ky');

    -- Loi mo phong xay ra sau khi da cap nhat si so va insert dang ky.
    RAISE EXCEPTION 'LOI_MO_PHONG_DE_KIEM_TRA_ROLLBACK';
EXCEPTION
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS v_error = MESSAGE_TEXT;
        IF v_error <> 'LOI_MO_PHONG_DE_KIEM_TRA_ROLLBACK' THEN
            RAISE;
        END IF;
        RAISE NOTICE 'Da bat loi mo phong va rollback cac thay doi trong block';
END
$rollback_demo$;

-- Ky vong: si_so_hien_tai van bang so dang ky hoat dong; N107 chua co dang_ky.
SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te,
       count(*) FILTER (WHERE dk.ma_sv = 'N107') AS dong_cua_N107
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- 3. Dang ky thanh cong, commit ca cap nhat si so va dong dang_ky.
-- Chay khi LHP401 con mot cho va N107 chua co dong dang_ky.
BEGIN;
DO $success_demo$
DECLARE
    v_si_so  integer;
    v_toi_da integer;
BEGIN
    SELECT si_so_hien_tai, si_so_toi_da
      INTO v_si_so, v_toi_da
    FROM hoc_vu.lop_hoc_phan
    WHERE ma_lhp = 'LHP401'
    FOR UPDATE;

    IF v_si_so >= v_toi_da THEN
        RAISE EXCEPTION 'LHP401 da het cho';
    END IF;
    IF EXISTS (
        SELECT 1
        FROM hoc_vu.lop_hoc_phan target
        JOIN hoc_vu.mon_tien_quyet req ON req.ma_hp = target.ma_hp
        WHERE target.ma_lhp = 'LHP401'
          AND req.loai_dieu_kien = 'Tien quyet'
          AND NOT EXISTS (
              SELECT 1
              FROM hoc_vu.ket_qua_hoc_tap kq
              JOIN hoc_vu.lop_hoc_phan old_lhp ON old_lhp.ma_lhp = kq.ma_lhp
              WHERE kq.ma_sv = 'N107'
                AND old_lhp.ma_hp = req.ma_hp_truoc
                AND kq.diem_tong_ket >= 5
          )
    ) THEN
        RAISE EXCEPTION 'Sinh vien chua dat mon tien quyet';
    END IF;
    IF EXISTS (
        SELECT 1
        FROM hoc_vu.lop_hoc_phan target
        JOIN hoc_vu.lichhoc target_time ON target_time.ma_lhp = target.ma_lhp
        JOIN hoc_vu.dang_ky dk ON dk.ma_sv = 'N107'
                                AND dk.trang_thai = 'Da dang ky'
                                AND dk.ma_lhp <> target.ma_lhp
        JOIN hoc_vu.lop_hoc_phan enrolled
          ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = target.ma_hk
        JOIN hoc_vu.lichhoc enrolled_time ON enrolled_time.ma_lhp = enrolled.ma_lhp
        WHERE target.ma_lhp = 'LHP401'
          AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
          AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
          AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
    ) THEN
        RAISE EXCEPTION 'Sinh vien bi trung lich hoc';
    END IF;
    IF EXISTS (
        SELECT 1 FROM hoc_vu.dang_ky
        WHERE ma_sv = 'N107' AND ma_lhp = 'LHP401'
    ) THEN
        RAISE EXCEPTION 'Sinh vien da dang ky lop nay';
    END IF;

    UPDATE hoc_vu.lop_hoc_phan
    SET si_so_hien_tai = si_so_hien_tai + 1
    WHERE ma_lhp = 'LHP401';

    INSERT INTO hoc_vu.dang_ky (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
    VALUES ('N107', 'LHP401', clock_timestamp(), 'Da dang ky');
END
$success_demo$;
COMMIT;

-- Ky vong sau commit: si_so_hien_tai = so dang ky hoat dong.
SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- 3b. Thu dang ky lai cung sinh vien sau khi da commit.
-- Ky vong: logic tu choi dang ky trung; khong them dong moi va khong tang si so.
DO $duplicate_demo$
DECLARE
    v_error text;
BEGIN
    BEGIN
        PERFORM 1
        FROM hoc_vu.lop_hoc_phan
        WHERE ma_lhp = 'LHP401'
        FOR UPDATE;

        IF EXISTS (
            SELECT 1 FROM hoc_vu.dang_ky
            WHERE ma_sv = 'N107' AND ma_lhp = 'LHP401'
        ) THEN
            RAISE EXCEPTION 'DUPLICATE_REJECTED_AS_EXPECTED';
        END IF;

        RAISE EXCEPTION 'DUPLICATE_TEST_SETUP_INVALID';
    EXCEPTION
        WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS v_error = MESSAGE_TEXT;
            IF v_error <> 'DUPLICATE_REJECTED_AS_EXPECTED' THEN
                RAISE;
            END IF;
            RAISE NOTICE 'Dang ky trung bi tu choi; khong ghi them dong';
    END;
END
$duplicate_demo$;

SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te,
       count(*) FILTER (WHERE dk.ma_sv = 'N107') AS dong_cua_N107
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- 4. Truy van doc phuc vu EXPLAIN ANALYZE tren duong dang ky.
-- EXPLAIN ANALYZE thuc su chay SELECT; truy van nay khong sua du lieu.
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da,
       EXISTS (
           SELECT 1 FROM hoc_vu.dang_ky d
           WHERE d.ma_sv = 'N107' AND d.ma_lhp = l.ma_lhp
             AND d.trang_thai = 'Da dang ky'
       ) AS da_dang_ky,
       NOT EXISTS (
           SELECT 1 FROM hoc_vu.mon_tien_quyet req
           WHERE req.ma_hp = l.ma_hp AND req.loai_dieu_kien = 'Tien quyet'
             AND NOT EXISTS (
                 SELECT 1 FROM hoc_vu.ket_qua_hoc_tap kq
                 JOIN hoc_vu.lop_hoc_phan old_lhp ON old_lhp.ma_lhp = kq.ma_lhp
                 WHERE kq.ma_sv = 'N107' AND old_lhp.ma_hp = req.ma_hp_truoc
                   AND kq.diem_tong_ket >= 5
             )
       ) AS du_tien_quyet,
       NOT EXISTS (
           SELECT 1
           FROM hoc_vu.lichhoc target_time
           JOIN hoc_vu.dang_ky dk ON dk.ma_sv = 'N107'
                                   AND dk.trang_thai = 'Da dang ky'
                                   AND dk.ma_lhp <> l.ma_lhp
           JOIN hoc_vu.lop_hoc_phan enrolled
             ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = l.ma_hk
           JOIN hoc_vu.lichhoc enrolled_time ON enrolled_time.ma_lhp = enrolled.ma_lhp
           WHERE target_time.ma_lhp = l.ma_lhp
             AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
             AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
             AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
       ) AS khong_trung_lich
FROM hoc_vu.lop_hoc_phan l
WHERE l.ma_lhp = 'LHP401';

-- 5. Don fixture sau cac vi du SQL: xoa dung dong test cua N107/N108, dem lai si so.
-- Seed cua do an co suc chua ban dau la 6; khong dung cleanup nay neu nhom da doi fixture.
DELETE FROM hoc_vu.dang_ky
WHERE ma_lhp = 'LHP401' AND ma_sv IN ('N107', 'N108');

UPDATE hoc_vu.lop_hoc_phan l
SET si_so_hien_tai = (
        SELECT count(*)::int FROM hoc_vu.dang_ky d
        WHERE d.ma_lhp = l.ma_lhp AND d.trang_thai = 'Da dang ky'
    ),
    si_so_toi_da = 6
WHERE l.ma_lhp = 'LHP401';

SELECT l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da,
       count(*) FILTER (WHERE d.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky d ON d.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da;
