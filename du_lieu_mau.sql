-- =====================================================================
-- DỮ LIỆU MẪU - QUẢN LÝ HỌC VỤ (PostgreSQL)
-- Chạy SAU khi đã chạy quan_ly_hoc_vu.sql (tạo schema + bảng)
-- File này tự động xóa dữ liệu cũ (TRUNCATE) nên chạy lại nhiều lần được.
-- =====================================================================
SET search_path TO hoc_vu, public;

TRUNCATE TABLE
    ket_qua_hoc_tap,
    dang_ky,
    lichhoc,
    lop_hoc_phan,
    mon_tien_quyet,
    sinh_vien,
    giang_vien,
    hoc_phan,
    hoc_ky,
    khoa,
    nguoi
    RESTART IDENTITY CASCADE;

-- =====================================================================
-- 1. NGUOI  (16 sinh viên N101..N116 + 8 giảng viên N201..N208)
-- =====================================================================
INSERT INTO nguoi (ma_nguoi, ho_ten, ngay_sinh, gioi_tinh, email, so_dien_thoai) VALUES
    -- Sinh viên
    ('N101', 'Nguyen Van An',      '2003-05-12', 'Nam', 'an@sv.edu.vn',       '0901234567'),
    ('N102', 'Tran Thi Binh',      '2004-01-20', 'Nu',  'binh@sv.edu.vn',     '0902234567'),
    ('N103', 'Le Van Cuong',       '2003-11-02', 'Nam', 'cuong@sv.edu.vn',    '0903234567'),
    ('N104', 'Pham Thi Dung',      '2004-03-15', 'Nu',  'dung@sv.edu.vn',     '0904234567'),
    ('N105', 'Hoang Van Em',       '2003-07-21', 'Nam', 'em@sv.edu.vn',       '0905234567'),
    ('N106', 'Vu Thi Phuong',      '2004-09-10', 'Nu',  'phuong@sv.edu.vn',   '0906234567'),
    ('N107', 'Dang Van Giang',     '2003-02-18', 'Nam', 'giang@sv.edu.vn',    '0907234567'),
    ('N108', 'Bui Thi Ha',         '2004-12-05', 'Nu',  'ha@sv.edu.vn',       '0908234567'),
    ('N109', 'Do Van Hung',        '2003-06-30', 'Nam', 'hung@sv.edu.vn',     '0909234567'),
    ('N110', 'Ngo Thi Lan',        '2004-04-22', 'Nu',  'lan@sv.edu.vn',      '0910234567'),
    ('N111', 'Nguyen Duc Kien',    '2003-10-09', 'Nam', 'kien@sv.edu.vn',     '0911234567'),
    ('N112', 'Tran Thi Mai',       '2004-08-17', 'Nu',  'mai@sv.edu.vn',      '0912234567'),
    ('N113', 'Le Hoang Nam',       '2002-01-25', 'Nam', 'nam@sv.edu.vn',      '0913234567'),
    ('N114', 'Phan Thi Oanh',      '2003-03-14', 'Nu',  'oanh@sv.edu.vn',     '0914234567'),
    ('N115', 'Truong Van Phuc',    '2003-09-28', 'Nam', 'phuc@sv.edu.vn',     '0915234567'),
    ('N116', 'Ly Thi Quynh',       '2004-05-06', 'Nu',  'quynh@sv.edu.vn',    '0916234567'),
    -- Giảng viên
    ('N201', 'Le Van Cong',        '1980-08-15', 'Nam', 'cong@gv.edu.vn',     '0920234567'),
    ('N202', 'Tran Quang Duong',   '1975-04-11', 'Nam', 'duong@gv.edu.vn',    '0921234567'),
    ('N203', 'Nguyen Thi Hanh',    '1982-11-20', 'Nu',  'hanh@gv.edu.vn',     '0922234567'),
    ('N204', 'Pham Minh Khoa',     '1968-02-03', 'Nam', 'khoa@gv.edu.vn',     '0923234567'),
    ('N205', 'Hoang Thi My Linh',  '1988-06-17', 'Nu',  'linh@gv.edu.vn',     '0924234567'),
    ('N206', 'Vu Dinh Manh',       '1979-09-25', 'Nam', 'manh@gv.edu.vn',     '0925234567'),
    ('N207', 'Dang Thi Ngoc',      '1990-12-01', 'Nu',  'ngoc@gv.edu.vn',     '0926234567'),
    ('N208', 'Bui Van Quang',      '1985-07-14', 'Nam', 'quang@gv.edu.vn',    '0927234567');

-- =====================================================================
-- 2. KHOA
-- =====================================================================
INSERT INTO khoa (ma_khoa, ten_khoa, van_phong) VALUES
    ('CNTT', 'Cong nghe thong tin',  'D3-101'),
    ('KT',   'Kinh te',              'B1-201'),
    ('DT',   'Dien tu vien thong',   'D3-301'),
    ('NN',   'Ngon ngu hoc ung dung','B2-102'),
    ('CK',   'Co khi che tao',       'D1-105');

-- =====================================================================
-- 3. HOC_KY
-- =====================================================================
INSERT INTO hoc_ky (ma_hk, ten_hk, nam_hoc) VALUES
    ('20231', 'Hoc ky 1 nam 2023-2024', 2023),
    ('20232', 'Hoc ky 2 nam 2023-2024', 2023),
    ('20241', 'Hoc ky 1 nam 2024-2025', 2024),
    ('20242', 'Hoc ky 2 nam 2024-2025', 2024);

-- =====================================================================
-- 4. HOC_PHAN  (có chuỗi tiên quyết IT101 -> IT201 -> IT202 -> IT301/IT302)
-- =====================================================================
INSERT INTO hoc_phan (ma_hp, ten_hp, so_tin_chi, so_tiet_ly_thuyet, so_tiet_thuc_hanh) VALUES
    ('IT101', 'Nhap mon lap trinh',              3, 30, 30),
    ('IT102', 'Toan roi rac',                    3, 45,  0),
    ('IT201', 'Cau truc du lieu va giai thuat',  3, 40, 20),
    ('IT202', 'Co so du lieu',                   4, 45, 30),
    ('IT203', 'He dieu hanh',                    3, 40, 15),
    ('IT301', 'Quan tri he co so du lieu',       3, 45, 15),
    ('IT302', 'Khai pha du lieu',                3, 40, 20),
    ('MA101', 'Dai so tuyen tinh',               3, 45,  0),
    ('MA202', 'Xac suat thong ke',               3, 45,  0),
    ('KT101', 'Kinh te vi mo',                   3, 45,  0);

-- Môn tiên quyết / song hành
INSERT INTO mon_tien_quyet (ma_hp, ma_hp_truoc, loai_dieu_kien) VALUES
    ('IT201', 'IT101', 'Tien quyet'),
    ('IT201', 'IT102', 'Tien quyet'),
    ('IT202', 'IT201', 'Tien quyet'),
    ('IT203', 'IT201', 'Tien quyet'),
    ('IT301', 'IT202', 'Tien quyet'),
    ('IT302', 'IT202', 'Tien quyet'),
    ('IT302', 'MA202', 'Song hanh'),
    ('MA202', 'MA101', 'Tien quyet'),
    ('IT102', 'MA101', 'Song hanh');

-- =====================================================================
-- 5. GIANG_VIEN
-- =====================================================================
INSERT INTO giang_vien (ma_gv, hoc_vi, hoc_ham, ma_khoa) VALUES
    ('N201', 'Tien si',  'Khong', 'CNTT'),
    ('N202', 'Thac si',  'Khong', 'CNTT'),
    ('N203', 'Tien si',  'Khong', 'KT'),
    ('N204', 'PGS',      'Giao su phu', 'CNTT'),
    ('N205', 'Tien si',  'Khong', 'NN'),
    ('N206', 'Tien si',  'Khong', 'DT'),
    ('N207', 'Thac si',  'Khong', 'KT'),
    ('N208', 'Tien si',  'Khong', 'DT');

-- =====================================================================
-- 6. SINH_VIEN
-- =====================================================================
INSERT INTO sinh_vien (ma_sv, lop_sinh_hoat, nam_nhap_hoc, chuyen_nganh, gpa_tich_luy) VALUES
    ('N101', 'SE-K46', 2021, 'Cong nghe phan mem', 3.20),
    ('N102', 'SE-K46', 2021, 'Khoa hoc may tinh',  2.85),
    ('N103', 'SE-K46', 2021, 'Khoa hoc may tinh',  3.45),
    ('N104', 'SE-K46', 2021, 'Cong nghe phan mem', 2.10),
    ('N105', 'SE-K46', 2021, 'An toan thong tin',  1.95),
    ('N106', 'AT-K46', 2021, 'An toan thong tin',  3.60),
    ('N107', 'AT-K46', 2022, 'An toan thong tin',  2.40),
    ('N108', 'AT-K46', 2022, 'Khoa hoc may tinh',  3.15),
    ('N109', 'KT-K47', 2022, 'Kinh te quoc te',    2.75),
    ('N110', 'KT-K47', 2022, 'Kinh te quoc te',    3.30),
    ('N111', 'KT-K47', 2022, 'Ke toan',            1.80),
    ('N112', 'KT-K47', 2022, 'Ke toan',            2.55),
    ('N113', 'DT-K45', 2020, 'Vien thong',         2.35),
    ('N114', 'DT-K45', 2020, 'Vien thong',         2.90),
    ('N115', 'DT-K45', 2020, 'Dien tu',            2.60),
    ('N116', 'DT-K45', 2020, 'Dien tu',            3.70);

-- =====================================================================
-- 7. LOP_HOC_PHAN  (3 học kỳ quá khứ có điểm + học kỳ hiện tại đang đăng ký)
--    LHP401 ĐÃ ĐẦY CHỖ (6/6) -> dùng để tái hiện tranh chấp đăng ký
-- =====================================================================
INSERT INTO lop_hoc_phan (ma_lhp, ten_lhp, si_so_toi_da, si_so_hien_tai, ma_hp, ma_hk, ma_gv) VALUES
    -- HK1 2023-2024
    ('LHP101', 'IT101-L01', 60, 8, 'IT101', '20231', 'N202'),
    ('LHP102', 'MA101-L01', 60, 6, 'MA101', '20231', 'N204'),
    -- HK2 2023-2024
    ('LHP201', 'IT201-L01', 50, 8, 'IT201', '20232', 'N202'),
    ('LHP202', 'IT102-L01', 50, 4, 'IT102', '20232', 'N204'),
    -- HK1 2024-2025
    ('LHP301', 'IT202-L01', 50, 8, 'IT202', '20241', 'N201'),
    ('LHP302', 'IT203-L01', 45, 4, 'IT203', '20241', 'N206'),
    ('LHP303', 'KT101-L01', 70, 4, 'KT101', '20241', 'N203'),
    -- HK2 2024-2025 (hiện tại)
    ('LHP401', 'IT301-L01',  6, 6, 'IT301', '20242', 'N201'),
    ('LHP402', 'IT302-L01', 40, 5, 'IT302', '20242', 'N206'),
    ('LHP403', 'MA202-L01', 50, 5, 'MA202', '20242', 'N204'),
    ('LHP404', 'IT101-L02', 60, 8, 'IT101', '20242', 'N202');

-- =====================================================================
-- 8. LICHHOC
-- =====================================================================
INSERT INTO lichhoc (ma_lhp, thu_trong_tuan, tiet_bat_dau, tiet_ket_thuc, phong_hoc) VALUES
    ('LHP101', 'Thu 2', 1, 3, 'TC-101'),
    ('LHP101', 'Thu 4', 1, 3, 'TC-102'),
    ('LHP102', 'Thu 3', 7, 9, 'TC-205'),
    ('LHP102', 'Thu 5', 7, 9, 'TC-206'),
    ('LHP201', 'Thu 2', 4, 6, 'TC-103'),
    ('LHP201', 'Thu 4', 4, 6, 'TC-103'),
    ('LHP202', 'Thu 5', 1, 3, 'TC-104'),
    ('LHP202', 'Thu 7', 1, 3, 'TC-104'),
    ('LHP301', 'Thu 2', 6, 8, 'TC-201'),
    ('LHP301', 'Thu 4', 6, 8, 'TC-201'),
    ('LHP302', 'Thu 3', 1, 3, 'TC-105'),
    ('LHP302', 'Thu 5', 1, 3, 'TC-105'),
    ('LHP303', 'Thu 6', 4, 6, 'B1-301'),
    ('LHP401', 'Thu 2', 8, 10, 'TC-301'),
    ('LHP401', 'Thu 4', 8, 10, 'TC-301'),
    ('LHP402', 'Thu 3', 4, 6, 'TC-202'),
    ('LHP402', 'Thu 5', 4, 6, 'TC-202'),
    ('LHP403', 'Thu 6', 1, 4, 'B1-302'),
    ('LHP404', 'Thu 2', 1, 3, 'TC-101'),
    ('LHP404', 'Thu 4', 1, 3, 'TC-101');

-- =====================================================================
-- 9. DANG_KY  (số 'Da dang ky' khớp si_so_hien_tai của từng LHP)
-- =====================================================================
INSERT INTO dang_ky (ma_sv, ma_lhp, thoi_gian_dk, trang_thai) VALUES
    -- LHP101 (8)
    ('N101', 'LHP101', '2023-09-05 08:00:00', 'Da dang ky'),
    ('N102', 'LHP101', '2023-09-05 08:05:00', 'Da dang ky'),
    ('N103', 'LHP101', '2023-09-05 08:10:00', 'Da dang ky'),
    ('N104', 'LHP101', '2023-09-05 08:15:00', 'Da dang ky'),
    ('N105', 'LHP101', '2023-09-05 08:20:00', 'Da dang ky'),
    ('N106', 'LHP101', '2023-09-05 08:25:00', 'Da dang ky'),
    ('N107', 'LHP101', '2023-09-05 08:30:00', 'Da dang ky'),
    ('N108', 'LHP101', '2023-09-05 08:35:00', 'Da dang ky'),
    -- LHP102 (6)
    ('N101', 'LHP102', '2023-09-05 09:00:00', 'Da dang ky'),
    ('N102', 'LHP102', '2023-09-05 09:05:00', 'Da dang ky'),
    ('N103', 'LHP102', '2023-09-05 09:10:00', 'Da dang ky'),
    ('N106', 'LHP102', '2023-09-05 09:15:00', 'Da dang ky'),
    ('N109', 'LHP102', '2023-09-05 09:20:00', 'Da dang ky'),
    ('N113', 'LHP102', '2023-09-05 09:25:00', 'Da dang ky'),
    -- LHP201 (8)
    ('N101', 'LHP201', '2024-02-01 08:00:00', 'Da dang ky'),
    ('N102', 'LHP201', '2024-02-01 08:05:00', 'Da dang ky'),
    ('N103', 'LHP201', '2024-02-01 08:10:00', 'Da dang ky'),
    ('N104', 'LHP201', '2024-02-01 08:15:00', 'Da dang ky'),
    ('N105', 'LHP201', '2024-02-01 08:20:00', 'Da dang ky'),
    ('N106', 'LHP201', '2024-02-01 08:25:00', 'Da dang ky'),
    ('N107', 'LHP201', '2024-02-01 08:30:00', 'Da dang ky'),
    ('N108', 'LHP201', '2024-02-01 08:35:00', 'Da dang ky'),
    -- LHP202 (4)
    ('N101', 'LHP202', '2024-02-01 09:00:00', 'Da dang ky'),
    ('N106', 'LHP202', '2024-02-01 09:05:00', 'Da dang ky'),
    ('N109', 'LHP202', '2024-02-01 09:10:00', 'Da dang ky'),
    ('N113', 'LHP202', '2024-02-01 09:15:00', 'Da dang ky'),
    -- LHP301 (8)
    ('N101', 'LHP301', '2024-09-03 08:00:00', 'Da dang ky'),
    ('N102', 'LHP301', '2024-09-03 08:05:00', 'Da dang ky'),
    ('N103', 'LHP301', '2024-09-03 08:10:00', 'Da dang ky'),
    ('N104', 'LHP301', '2024-09-03 08:15:00', 'Da dang ky'),
    ('N105', 'LHP301', '2024-09-03 08:20:00', 'Da dang ky'),
    ('N106', 'LHP301', '2024-09-03 08:25:00', 'Da dang ky'),
    ('N107', 'LHP301', '2024-09-03 08:30:00', 'Da dang ky'),
    ('N108', 'LHP301', '2024-09-03 08:35:00', 'Da dang ky'),
    -- LHP302 (4)
    ('N101', 'LHP302', '2024-09-03 09:00:00', 'Da dang ky'),
    ('N102', 'LHP302', '2024-09-03 09:05:00', 'Da dang ky'),
    ('N103', 'LHP302', '2024-09-03 09:10:00', 'Da dang ky'),
    ('N107', 'LHP302', '2024-09-03 09:15:00', 'Da dang ky'),
    -- LHP303 (4)
    ('N109', 'LHP303', '2024-09-04 08:00:00', 'Da dang ky'),
    ('N110', 'LHP303', '2024-09-04 08:05:00', 'Da dang ky'),
    ('N111', 'LHP303', '2024-09-04 08:10:00', 'Da dang ky'),
    ('N112', 'LHP303', '2024-09-04 08:15:00', 'Da dang ky'),
    -- LHP401 (6/6 - ĐẦY)
    ('N101', 'LHP401', '2025-01-06 08:00:00', 'Da dang ky'),
    ('N102', 'LHP401', '2025-01-06 08:05:00', 'Da dang ky'),
    ('N103', 'LHP401', '2025-01-06 08:10:00', 'Da dang ky'),
    ('N104', 'LHP401', '2025-01-06 08:15:00', 'Da dang ky'),
    ('N105', 'LHP401', '2025-01-06 08:20:00', 'Da dang ky'),
    ('N106', 'LHP401', '2025-01-06 08:25:00', 'Da dang ky'),
    -- LHP402 (5 đăng ký + 1 hủy)
    ('N101', 'LHP402', '2025-01-07 08:00:00', 'Da dang ky'),
    ('N102', 'LHP402', '2025-01-07 08:05:00', 'Da dang ky'),
    ('N103', 'LHP402', '2025-01-07 08:10:00', 'Da dang ky'),
    ('N104', 'LHP402', '2025-01-07 08:15:00', 'Da dang ky'),
    ('N105', 'LHP402', '2025-01-07 08:20:00', 'Da huy'),
    ('N106', 'LHP402', '2025-01-07 08:25:00', 'Da dang ky'),
    -- LHP403 (5)
    ('N101', 'LHP403', '2025-01-06 09:00:00', 'Da dang ky'),
    ('N102', 'LHP403', '2025-01-06 09:05:00', 'Da dang ky'),
    ('N103', 'LHP403', '2025-01-06 09:10:00', 'Da dang ky'),
    ('N109', 'LHP403', '2025-01-06 09:15:00', 'Da dang ky'),
    ('N110', 'LHP403', '2025-01-06 09:20:00', 'Da dang ky'),
    -- LHP404 (8)
    ('N109', 'LHP404', '2025-01-08 08:00:00', 'Da dang ky'),
    ('N110', 'LHP404', '2025-01-08 08:05:00', 'Da dang ky'),
    ('N111', 'LHP404', '2025-01-08 08:10:00', 'Da dang ky'),
    ('N112', 'LHP404', '2025-01-08 08:15:00', 'Da dang ky'),
    ('N113', 'LHP404', '2025-01-08 08:20:00', 'Da dang ky'),
    ('N114', 'LHP404', '2025-01-08 08:25:00', 'Da dang ky'),
    ('N115', 'LHP404', '2025-01-08 08:30:00', 'Da dang ky'),
    ('N116', 'LHP404', '2025-01-08 08:35:00', 'Da dang ky');

-- =====================================================================
-- 10. KET_QUA_HOC_TAP  (các học kỳ đã kết thúc)
-- =====================================================================
INSERT INTO ket_qua_hoc_tap (ma_sv, ma_lhp, diem_qua_trinh, diem_thi, diem_tong_ket, diem_chu) VALUES
    -- LHP101 - IT101 (HK1 2023-2024)
    ('N101', 'LHP101', 8.5,  9.0, 8.7, 'A'),
    ('N102', 'LHP101', 7.5,  8.0, 7.8, 'B'),
    ('N103', 'LHP101', 9.5,  9.0, 9.2, 'A+'),
    ('N104', 'LHP101', 7.0,  6.7, 6.9, 'C+'),
    ('N105', 'LHP101', 5.5,  5.2, 5.4, 'D'),
    ('N106', 'LHP101', 8.0,  8.4, 8.2, 'B+'),
    ('N107', 'LHP101', 6.0,  6.5, 6.2, 'C'),
    ('N108', 'LHP101', 9.0,  8.7, 8.9, 'A'),
    -- LHP102 - MA101 (HK1 2023-2024)
    ('N101', 'LHP102', 7.0,  8.0, 7.5, 'B'),
    ('N102', 'LHP102', 7.0,  6.5, 6.8, 'C+'),
    ('N103', 'LHP102', 9.0,  9.0, 9.0, 'A'),
    ('N106', 'LHP102', 7.5,  7.0, 7.2, 'B'),
    ('N109', 'LHP102', 6.0,  5.7, 5.9, 'D+'),
    ('N113', 'LHP102', 4.5,  4.5, 4.5, 'F'),
    -- LHP201 - IT201 (HK2 2023-2024)
    ('N101', 'LHP201', 8.5,  9.3, 8.9, 'A'),
    ('N102', 'LHP201', 7.0,  7.8, 7.4, 'B'),
    ('N103', 'LHP201', 9.5,  9.6, 9.5, 'A+'),
    ('N104', 'LHP201', 6.5,  5.5, 6.0, 'C'),
    ('N105', 'LHP201', 5.0,  5.5, 5.2, 'D'),
    ('N106', 'LHP201', 7.0,  7.0, 7.0, 'B'),
    ('N107', 'LHP201', 6.5,  6.2, 6.4, 'C+'),
    ('N108', 'LHP201', 8.0,  8.6, 8.3, 'B+'),
    -- LHP202 - IT102 (HK2 2023-2024)
    ('N101', 'LHP202', 7.5,  8.3, 7.9, 'B'),
    ('N106', 'LHP202', 7.5,  8.0, 7.7, 'B'),
    ('N109', 'LHP202', 7.0,  6.2, 6.6, 'C+'),
    ('N113', 'LHP202', 6.5,  6.5, 6.5, 'C+'),
    -- LHP301 - IT202 (HK1 2024-2025)
    ('N101', 'LHP301', 8.5,  9.1, 8.8, 'A'),
    ('N102', 'LHP301', 7.5,  7.7, 7.6, 'B+'),
    ('N103', 'LHP301', 9.5,  9.0, 9.3, 'A+'),
    ('N104', 'LHP301', 7.0,  6.3, 6.7, 'C+'),
    ('N105', 'LHP301', 5.5,  6.2, 5.8, 'D+'),
    ('N106', 'LHP301', 8.0,  8.0, 8.0, 'B+'),
    ('N107', 'LHP301', 6.0,  6.7, 6.3, 'C'),
    ('N108', 'LHP301', 8.5,  8.2, 8.4, 'B+'),
    -- LHP302 - IT203 (HK1 2024-2025)
    ('N101', 'LHP302', 8.0,  8.2, 8.1, 'B+'),
    ('N102', 'LHP302', 7.0,  7.0, 7.0, 'B'),
    ('N103', 'LHP302', 9.0,  9.2, 9.1, 'A'),
    ('N107', 'LHP302', 5.5,  6.4, 5.9, 'D+'),
    -- LHP303 - KT101 (HK1 2024-2025)
    ('N109', 'LHP303', 7.5,  8.1, 7.8, 'B'),
    ('N110', 'LHP303', 8.5,  8.5, 8.5, 'A'),
    ('N111', 'LHP303', 5.5,  5.5, 5.5, 'D+'),
    ('N112', 'LHP303', 7.0,  6.7, 6.9, 'C+');

-- =====================================================================
-- KIỂM TRA NHANH (chạy riêng nếu muốn)
-- =====================================================================
-- SELECT ma_lhp, si_so_toi_da, si_so_hien_tai FROM lop_hoc_phan WHERE si_so_hien_tai = si_so_toi_da;
-- SELECT * FROM sinh_vien ORDER BY gpa_tich_luy DESC;
-- Chuỗi tiên quyết đệ quy:
-- WITH RECURSIVE chuoi(ma_hp, cap) AS (
--     SELECT ma_hp, 0 FROM hoc_phan WHERE ma_hp = 'IT301'
--     UNION ALL
--     SELECT mtq.ma_hp_truoc, chuoi.cap + 1
--     FROM chuoi JOIN mon_tien_quyet mtq ON mtq.ma_hp = chuoi.ma_hp
-- ) SELECT * FROM chuoi ORDER BY cap DESC;
