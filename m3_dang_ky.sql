-- Dinh nghia thu tuc sp_dang_ky_hoc_phan (READ COMMITTED + FOR UPDATE, Bang 6-3)
-- va chay cac kich ban minh chung giong muc 6.6 cua bao cao:
--   Kich ban 1  (6.6.2): giao dich thanh cong - 1 dong DANG_KY moi, si so tang 1.
--   Kich ban 1b: dang ky trung bi tu choi, khong ghi them dong.
--   Kich ban 2  (6.6.3): loi giua chung (thieu tien quyet) va rollback - ca thao
--               tac ghi truoc loi deu bi huy, khong con dang ky mo coi / si so lech.
--   Kich ban 3  (6.6.4): tranh chap giua hai phien tranh cho cuoi - SQL khong
--               tu tao ra duoc session dong thoi, dung runner m3_concurrency.py
--               hoac file m3_minh_chung_dong_thoi.sql; trong file nay chi chay
--               EXPLAIN phuc vu minh chung plan truy van.

SET search_path TO hoc_vu, public;

-- ---------------------------------------------------------------------
-- 0. Kiem tra fixture truoc khi chay.
-- Phai khong co dang_ky LHP401 cho N107/N108 va N110 phai CHUA dat IT202
-- (neu runner m3_concurrency.py dang de lai fixture thi hay chay cleanup cua no truoc).
-- ---------------------------------------------------------------------
SELECT l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te
FROM lop_hoc_phan l
LEFT JOIN dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.ma_lhp, l.si_so_hien_tai, l.si_so_toi_da;

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
    IF EXISTS (
        SELECT 1
        FROM hoc_vu.ket_qua_hoc_tap kq
        JOIN hoc_vu.lop_hoc_phan l ON l.ma_lhp = kq.ma_lhp
        WHERE kq.ma_sv = 'N110' AND l.ma_hp = 'IT202' AND kq.diem_tong_ket >= 5
    ) THEN
        RAISE EXCEPTION 'N110 da dat IT202; kich ban 2 can SV thieu tien quyet';
    END IF;
END
$preflight$;

-- ---------------------------------------------------------------------
-- 1. Thu tuc dang ky hoc phan: cau hinh "READ COMMITTED + FOR UPDATE"
--    (dong chon trong Bang 6-3). Khoa dong lop TRUOC khi kiem tra va ghi
--    de chan lost update: phien sau cho phien truoc commit, doc lai si so
--    moi roi moi quyet dinh.
-- ---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE hoc_vu.sp_dang_ky_hoc_phan(p_ma_sv varchar, p_ma_lhp varchar)
LANGUAGE plpgsql
AS $sp$
DECLARE
    v_si_so  integer;
    v_toi_da integer;
    v_ma_hp  varchar;
BEGIN
    -- Khoa dong lop (FOR UPDATE) de hai phien tranh cho khong cung doc - cung ghi.
    SELECT si_so_hien_tai, si_so_toi_da, ma_hp
      INTO v_si_so, v_toi_da, v_ma_hp
    FROM hoc_vu.lop_hoc_phan
    WHERE ma_lhp = p_ma_lhp
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Khong tim thay lop hoc phan %', p_ma_lhp;
    END IF;

    -- Trung dang ky: SV da co dong dang_ky cho lop nay.
    IF EXISTS (
        SELECT 1 FROM hoc_vu.dang_ky
        WHERE ma_sv = p_ma_sv AND ma_lhp = p_ma_lhp
    ) THEN
        RAISE EXCEPTION 'Sinh vien da co dong dang ky lop nay';
    END IF;

    -- Tien quyet: moi mon yeu cau loai 'Tien quyet' phai dat (diem tong ket >= 5).
    IF EXISTS (
        SELECT 1
        FROM hoc_vu.mon_tien_quyet req
        WHERE req.ma_hp = v_ma_hp
          AND req.loai_dieu_kien = 'Tien quyet'
          AND NOT EXISTS (
              SELECT 1
              FROM hoc_vu.ket_qua_hoc_tap kq
              JOIN hoc_vu.lop_hoc_phan old_lhp ON old_lhp.ma_lhp = kq.ma_lhp
              WHERE kq.ma_sv = p_ma_sv
                AND old_lhp.ma_hp = req.ma_hp_truoc
                AND kq.diem_tong_ket >= 5
          )
    ) THEN
        RAISE EXCEPTION 'Sinh vien chua dat mon tien quyet';
    END IF;

    -- Trung lich: giao voi lop da dang ky 'Da dang ky' trong CUNG hoc ky.
    IF EXISTS (
        SELECT 1
        FROM hoc_vu.lop_hoc_phan target
        JOIN hoc_vu.lichhoc target_time ON target_time.ma_lhp = target.ma_lhp
        JOIN hoc_vu.dang_ky dk ON dk.ma_sv = p_ma_sv
                                AND dk.trang_thai = 'Da dang ky'
                                AND dk.ma_lhp <> target.ma_lhp
        JOIN hoc_vu.lop_hoc_phan enrolled
          ON enrolled.ma_lhp = dk.ma_lhp AND enrolled.ma_hk = target.ma_hk
        JOIN hoc_vu.lichhoc enrolled_time ON enrolled_time.ma_lhp = enrolled.ma_lhp
        WHERE target.ma_lhp = p_ma_lhp
          AND enrolled_time.thu_trong_tuan = target_time.thu_trong_tuan
          AND enrolled_time.tiet_bat_dau <= target_time.tiet_ket_thuc
          AND target_time.tiet_bat_dau <= enrolled_time.tiet_ket_thuc
    ) THEN
        RAISE EXCEPTION 'Sinh vien bi trung lich hoc';
    END IF;

    -- Kiem tra cho trong SAU KHI da giu khoa dong: doc gia tri moi nhat.
    IF v_si_so >= v_toi_da THEN
        RAISE EXCEPTION 'Lop hoc phan da het cho';
    END IF;

    -- Ghi: cap nhat si so va chen dong dang_ky trong CUNG giao dich.
    UPDATE hoc_vu.lop_hoc_phan
    SET si_so_hien_tai = si_so_hien_tai + 1
    WHERE ma_lhp = p_ma_lhp;

    INSERT INTO hoc_vu.dang_ky (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
    VALUES (p_ma_sv, p_ma_lhp, clock_timestamp(), 'Da dang ky');
END
$sp$;

-- ---------------------------------------------------------------------
-- 2. Mo dung 1 cho cho cac kich ban thu cong.
-- Dem lai so dang ky hoat dong lam si_so_hien_tai, dat suc chua = si so + 1.
-- Khong chay dong nay trong luc runner dang chay.
-- ---------------------------------------------------------------------
UPDATE hoc_vu.lop_hoc_phan l
SET si_so_hien_tai = x.so_dang_ky,
    si_so_toi_da   = x.so_dang_ky + 1
FROM (
    SELECT count(*)::int AS so_dang_ky
    FROM hoc_vu.dang_ky
    WHERE ma_lhp = 'LHP401' AND trang_thai = 'Da dang ky'
) AS x
WHERE l.ma_lhp = 'LHP401';

-- ---------------------------------------------------------------------
-- 3. KICH BAN 1 (6.6.2) - Giao dich thanh cong.
-- ---------------------------------------------------------------------
BEGIN;
CALL hoc_vu.sp_dang_ky_hoc_phan('N107', 'LHP401');
COMMIT;

-- Ky vong sau commit: 1 dong DANG_KY moi cho N107, si_so_hien_tai = so dang ky thuc te.
SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te,
       count(*) FILTER (WHERE dk.ma_sv = 'N107')            AS dong_cua_N107
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- ---------------------------------------------------------------------
-- 4. KICH BAN 1b - Dang ky trung bi tu choi.
-- GOi thu tuc lan nua cho cung SV: block trong bat loi ky vong, khong ghi
-- them dong, si so khong doi.
-- ---------------------------------------------------------------------
DO $duplicate_demo$
DECLARE
    v_error text;
BEGIN
    BEGIN
        CALL hoc_vu.sp_dang_ky_hoc_phan('N107', 'LHP401');
        RAISE EXCEPTION 'TRUNG_DANG_KY_KHONG_XAY_RA - THIET LAP SAI';
    EXCEPTION
        WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS v_error = MESSAGE_TEXT;
            IF v_error <> 'Sinh vien da co dong dang ky lop nay' THEN
                RAISE;
            END IF;
            RAISE NOTICE 'Kich ban 1b: dang ky trung bi tu choi - %', v_error;
    END;
END
$duplicate_demo$;

-- Ky vong: van dung 1 dong cua N107, si so khong tang.
SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te,
       count(*) FILTER (WHERE dk.ma_sv = 'N107')            AS dong_cua_N107
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- ---------------------------------------------------------------------
-- 5. Nha 1 cho de KICH BAN 2 bao dung loi "thieu tien quyet" chu khong
--    phai "het cho": xoa dong thu cua N107 va dem lai si so.
-- ---------------------------------------------------------------------
DELETE FROM hoc_vu.dang_ky
WHERE ma_lhp = 'LHP401' AND ma_sv = 'N107';

UPDATE hoc_vu.lop_hoc_phan l
SET si_so_hien_tai = (
        SELECT count(*)::int FROM hoc_vu.dang_ky d
        WHERE d.ma_lhp = l.ma_lhp AND d.trang_thai = 'Da dang ky'
    )
WHERE l.ma_lhp = 'LHP401';

-- ---------------------------------------------------------------------
-- 6. KICH BAN 2 (6.6.3) - Loi giua chung va rollback.
-- Giao dich gom mot thao tac ghi truoc (UPDATE chuyen_nganh) roi CALL bao
-- loi thieu tien quyet. Block trong mo phong dung BEGIN; UPDATE; CALL;
-- ROLLBACK: khi CALL RAISE EXCEPTION, moi thay doi tu dau block duoc huy -
-- khong con dong dang ky mo coi hay si so lech.
-- ---------------------------------------------------------------------
DO $rollback_demo$
DECLARE
    v_error text;
BEGIN
    BEGIN
        -- Thao tac ghi truoc loi trong cung giao dich.
        UPDATE hoc_vu.sinh_vien
        SET chuyen_nganh = 'Cong nghe phan mem'
        WHERE ma_sv = 'N110';

        CALL hoc_vu.sp_dang_ky_hoc_phan('N110', 'LHP401');  -- loi ky vong: thieu tien quyet
        RAISE EXCEPTION 'CALL_KHONG_BAO_LOI - THIET LAP SAI';
    EXCEPTION
        WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS v_error = MESSAGE_TEXT;
            IF v_error <> 'Sinh vien chua dat mon tien quyet' THEN
                RAISE;
            END IF;
            RAISE NOTICE 'Kich ban 2: CALL bao loi nhu ky vong - %; moi thay doi truoc do bi huy', v_error;
    END;
END
$rollback_demo$;

-- Ky vong: chuyen_nganh N110 ve gia tri seed ('Kinh te quoc te'), khong co
-- dang_ky N110-LHP401, si_so_hien_tai giu nguyen bang so dang ky thuc te.
SELECT sv.ma_sv, sv.chuyen_nganh
FROM hoc_vu.sinh_vien sv
WHERE sv.ma_sv = 'N110';

SELECT l.si_so_hien_tai,
       count(*) FILTER (WHERE dk.trang_thai = 'Da dang ky') AS so_dang_ky_thuc_te,
       count(*) FILTER (WHERE dk.ma_sv = 'N110')            AS dong_cua_N110
FROM hoc_vu.lop_hoc_phan l
LEFT JOIN hoc_vu.dang_ky dk ON dk.ma_lhp = l.ma_lhp
WHERE l.ma_lhp = 'LHP401'
GROUP BY l.si_so_hien_tai;

-- ---------------------------------------------------------------------
-- 7. EXPLAIN ANALYZE tren duong kiem tra cua thu tuc dang ky.
-- EXPLAIN ANALYZE thuc su chay SELECT; truy van nay khong sua du lieu.
-- ---------------------------------------------------------------------
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

-- ---------------------------------------------------------------------
-- 8. Don fixture sau cac kich ban: xoa dung dong test cua N107/N108,
-- dem lai si so va tra suc chua ve 6 nhu seed.
-- ---------------------------------------------------------------------
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
