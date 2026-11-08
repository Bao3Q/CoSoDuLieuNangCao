-- Gợi ý: chạy trong schema riêng
CREATE SCHEMA IF NOT EXISTS hoc_vu;
SET search_path TO hoc_vu, public;

-- =====================================================================
-- 1. NGUOI (thực thể cha)
-- =====================================================================
CREATE TABLE nguoi (
    so_nguoi        VARCHAR(15)   CONSTRAINT pk_nguoi PRIMARY KEY,
    ho_ten          VARCHAR(150)  NOT NULL,
    ngay_sinh       DATE,
    gioi_tinh       VARCHAR(10),
    email           VARCHAR(255),
    so_dien_thoai   VARCHAR(20),

    CONSTRAINT uq_nguoi_email UNIQUE (email)
);

-- Ràng buộc giá trị mềm (nếu muốn nghiêm ngặt)
ALTER TABLE nguoi
    ADD CONSTRAINT chk_nguoi_gioi_tinh
    CHECK (gioi_tinh IN ('Nam', 'Nu', 'Khac'));

-- =====================================================================
-- 2. KHOA
-- =====================================================================
CREATE TABLE khoa (
    ma_khoa     VARCHAR(20) CONSTRAINT pk_khoa PRIMARY KEY,
    ten_khoa    VARCHAR(150) NOT NULL,
    van_phong   VARCHAR(100)
);

-- =====================================================================
-- 3. HOC_KY
-- =====================================================================
CREATE TABLE hoc_ky (
    ma_hk       VARCHAR(20) CONSTRAINT pk_hoc_ky PRIMARY KEY,
    ten_hk      VARCHAR(50),
    nam_hoc     INTEGER
);

-- =====================================================================
-- 4. HOC_PHAN
-- =====================================================================
CREATE TABLE hoc_phan (
    ma_hp               VARCHAR(20) CONSTRAINT pk_hoc_phan PRIMARY KEY,
    ten_hp              VARCHAR(150) NOT NULL,
    so_tin_chi          INTEGER,
    so_tiet_ly_thuyet   INTEGER,
    so_tiet_thuc_hanh   INTEGER,

    CONSTRAINT chk_hoc_phan_tin_chi CHECK (so_tin_chi >= 0),
    CONSTRAINT chk_hoc_phan_tiet    CHECK (so_tiet_ly_thuyet >= 0 AND so_tiet_thuc_hanh >= 0)
);

-- =====================================================================
-- 5. GIANG_VIEN (is-a NGUOI, PK đồng thời là FK về nguoi)
-- =====================================================================
CREATE TABLE giang_vien (
    ma_gv     VARCHAR(15) CONSTRAINT pk_giang_vien PRIMARY KEY,
    hoc_vi    VARCHAR(50),
    hoc_ham   VARCHAR(50),
    ma_khoa   VARCHAR(20),

    CONSTRAINT fk_giang_vien_nguoi
        FOREIGN KEY (ma_gv) REFERENCES nguoi (so_nguoi)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_giang_vien_khoa
        FOREIGN KEY (ma_khoa) REFERENCES khoa (ma_khoa)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


-- =====================================================================
-- 6. SINH_VIEN (is-a NGUOI, PK đồng thời là FK về nguoi)
-- =====================================================================
CREATE TABLE sinh_vien (
    ma_sv           VARCHAR(15) CONSTRAINT pk_sinh_vien PRIMARY KEY,
    lop_sinh_hoat   VARCHAR(20),
    nam_nhap_hoc    INTEGER,
    chuyen_nganh    VARCHAR(100),
    gpa_tich_luy    FLOAT DEFAULT 0,

    CONSTRAINT fk_sinh_vien_nguoi
        FOREIGN KEY (ma_sv) REFERENCES nguoi (so_nguoi)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_sinh_vien_gpa CHECK (gpa_tich_luy >= 0 AND gpa_tich_luy <= 4),
    CONSTRAINT chk_sinh_vien_nam CHECK (nam_nhap_hoc >= 1900)
);


-- =====================================================================
-- 7. MÔN TIÊN QUYẾT (liên kết HOC_PHAN với chính nó: yêu cầu / tiên quyết)
--    - ma_hp       : môn đang xét
--    - ma_hp_truoc : môn kiện trước phải học
--    - loai_dieu_kien : tiên quyết / song hành / ...
-- =====================================================================
CREATE TABLE mon_tien_quyet (
    ma_hp           VARCHAR(20) NOT NULL,
    ma_hp_truoc     VARCHAR(20) NOT NULL,
    loai_dieu_kien  VARCHAR(50),

    CONSTRAINT pk_mon_tien_quyet PRIMARY KEY (ma_hp, ma_hp_truoc),

    CONSTRAINT fk_mtq_ma_hp
        FOREIGN KEY (ma_hp) REFERENCES hoc_phan (ma_hp)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_mtq_ma_hp_truoc
        FOREIGN KEY (ma_hp_truoc) REFERENCES hoc_phan (ma_hp)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    -- không tự yêu cầu chính nó
    CONSTRAINT chk_mtq_khac_nhau CHECK (ma_hp <> ma_hp_truoc)
);

-- =====================================================================
-- 8. LOP_HOC_PHAN (mỗi học phần được khai giảng trong một học kỳ)
-- =====================================================================
CREATE TABLE lop_hoc_phan (
    ma_lhp           VARCHAR(20) CONSTRAINT pk_lop_hoc_phan PRIMARY KEY,
    ten_lhp          VARCHAR(150),
    si_so_toi_da     INTEGER,
    si_so_hien_tai   INTEGER DEFAULT 0,
    ma_hp            VARCHAR(20) NOT NULL,
    ma_hk            VARCHAR(20) NOT NULL,
    ma_gv            VARCHAR(15),

    CONSTRAINT fk_lhp_hoc_phan
        FOREIGN KEY (ma_hp) REFERENCES hoc_phan (ma_hp)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_lhp_hoc_ky
        FOREIGN KEY (ma_hk) REFERENCES hoc_ky (ma_hk)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_lhp_giang_vien
        FOREIGN KEY (ma_gv) REFERENCES giang_vien (ma_gv)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT chk_lhp_si_so CHECK (si_so_toi_da > 0 AND si_so_hien_tai >= 0 AND si_so_hien_tai <= si_so_toi_da)
);

CREATE INDEX idx_lhp_hk  ON lop_hoc_phan (ma_hk);
CREATE INDEX idx_lhp_hp  ON lop_hoc_phan (ma_hp);

-- =====================================================================
-- 9. LICHHOC (lịch học của lớp học phần)
-- =====================================================================
CREATE TABLE lichhoc (
    id              INTEGER GENERATED ALWAYS AS IDENTITY,
    ma_lhp          VARCHAR(20) NOT NULL,
    thu_trong_tuan  VARCHAR(10),           -- Thu 2, Thu 3, ...
    tiet_bat_dau    INTEGER,
    tiet_ket_thuc   INTEGER,
    phong_hoc       VARCHAR(50),

    CONSTRAINT pk_lichhoc PRIMARY KEY (id),

    CONSTRAINT fk_lichhoc_lhp
        FOREIGN KEY (ma_lhp) REFERENCES lop_hoc_phan (ma_lhp)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_lichhoc_tiet CHECK (tiet_bat_dau >= 1 AND tiet_ket_thuc >= tiet_bat_dau)
);

-- Vào cùng 1 lớp, không được trùng tiết/phòng trong cặp (thu, tiết)
CREATE UNIQUE INDEX uq_lichhoc_tiet
    ON lichhoc (ma_lhp, thu_trong_tuan, tiet_bat_dau);

-- =====================================================================
-- 10. DANG_KY (sinh viên đăng ký lớp học phần)
-- =====================================================================
CREATE TABLE dang_ky (
    ma_sv        VARCHAR(15) NOT NULL,
    ma_lhp       VARCHAR(20) NOT NULL,
    thoi_gian_dk TIMESTAMP,
    trang_thai   VARCHAR(30),                -- Da dang ky / Da huy / ...

    CONSTRAINT pk_dang_ky PRIMARY KEY (ma_sv, ma_lhp),

    CONSTRAINT fk_dang_ky_sv
        FOREIGN KEY (ma_sv) REFERENCES sinh_vien (ma_sv)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_dang_ky_lhp
        FOREIGN KEY (ma_lhp) REFERENCES lop_hoc_phan (ma_lhp)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_dang_ky_lhp ON dang_ky (ma_lhp);

-- =====================================================================
-- 11. KET_QUA_HOC_TAP (bảng học kết của SV ở từng LHP)
-- =====================================================================
CREATE TABLE ket_qua_hoc_tap (
    ma_sv            VARCHAR(15) NOT NULL,
    ma_lhp           VARCHAR(20) NOT NULL,
    diem_qua_trinh   FLOAT,
    diem_thi         FLOAT,
    diem_tong_ket    FLOAT,
    diem_chu         VARCHAR(3),             -- A, B+, C, D, F, ...

    CONSTRAINT pk_ket_qua_hoc_tap PRIMARY KEY (ma_sv, ma_lhp),

    CONSTRAINT fk_kqht_sv
        FOREIGN KEY (ma_sv) REFERENCES sinh_vien (ma_sv)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_kqht_lhp
        FOREIGN KEY (ma_lhp) REFERENCES lop_hoc_phan (ma_lhp)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_kqht_diem CHECK (
        diem_qua_trinh BETWEEN 0 AND 10
        AND diem_thi BETWEEN 0 AND 10
        AND diem_tong_ket BETWEEN 0 AND 10
    ),
    CONSTRAINT chk_kqht_diem_chu CHECK (
        diem_chu IN ('A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F')
    )
);


-- =====================================================================
-- DỮ LIỆU DEMO (tùy chọn)
-- =====================================================================
INSERT INTO nguoi (so_nguoi, ho_ten, ngay_sinh, gioi_tinh, email, so_dien_thoai)
VALUES
    ('N001', 'Nguyen Van An',  '2003-05-12', 'Nam', 'an@sv.edu.vn',    '0901234567'),
    ('N002', 'Tran Thi Binh',  '2004-01-20', 'Nu',  'binh@sv.edu.vn',  '0902234567'),
    ('N003', 'Le Van Cong',    '1980-08-15', 'Nam', 'cong@gv.edu.vn',  '0903234567');

INSERT INTO khoa (ma_khoa, ten_khoa, van_phong)
VALUES ('CNTT', 'Cong nghe thong tin', 'D3-101');

INSERT INTO hoc_ky (ma_hk, ten_hk, nam_hoc)
VALUES ('20241', 'Hoc ky 1 nam 2024-2025', 2024);

INSERT INTO hoc_phan (ma_hp, ten_hp, so_tin_chi, so_tiet_ly_thuyet, so_tiet_thuc_hanh)
VALUES
    ('CS101',  'Nhap lap lap trinh', 3, 30, 30),
    ('CS201',  'Cau truc du lieu',    3, 40, 20);

INSERT INTO mon_tien_quyet (ma_hp, ma_hp_truoc, loai_dieu_kien)
VALUES ('CS201', 'CS101', 'Tien quyet');

INSERT INTO giang_vien (ma_gv, hoc_vi, hoc_ham, ma_khoa)
VALUES ('N003', 'Tien si', 'Khong', 'CNTT');

INSERT INTO sinh_vien (ma_sv, lop_sinh_hoat, nam_nhap_hoc, chuyen_nganh, gpa_tich_luy)
VALUES
    ('N001', 'SE-K46', 2021, 'Cong nghe phan mem', 3.2),
    ('N002', 'SE-K46', 2021, 'Khoa hoc may tinh',  2.8);

INSERT INTO lop_hoc_phan (ma_lhp, ten_lhp, si_so_toi_da, si_so_hien_tai, ma_hp, ma_hk, ma_gv)
VALUES
    ('LHP001', 'CS101-L01', 60, 2, 'CS101',  '20241', 'N003'),
    ('LHP002', 'CS201-L01', 50, 2, 'CS201',  '20241', 'N003');

INSERT INTO lichhoc (ma_lhp, thu_trong_tuan, tiet_bat_dau, tiet_ket_thuc, phong_hoc)
VALUES
    ('LHP001', 'Thu 2', 1, 2, 'TC-101'),
    ('LHP001', 'Thu 4', 3, 4, 'TC-102'),
    ('LHP002', 'Thu 3', 5, 6, 'TC-201');

INSERT INTO dang_ky (ma_sv, ma_lhp, thoi_gian_dk, trang_thai)
VALUES
    ('N001', 'LHP001', '2024-09-01 08:00:00', 'Da dang ky'),
    ('N002', 'LHP001', '2024-09-01 08:05:00', 'Da dang ky'),
    ('N001', 'LHP002', '2024-09-01 08:10:00', 'Da dang ky');

INSERT INTO ket_qua_hoc_tap (ma_sv, ma_lhp, diem_qua_trinh, diem_thi, diem_tong_ket, diem_chu)
VALUES
    ('N001', 'LHP001', 9.0, 8.5, 8.7, 'A'),
    ('N002', 'LHP001', 8.0, 7.5, 7.7, 'B');
