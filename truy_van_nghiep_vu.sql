-- =====================================================================
-- 11 TRUY VẤN NGHIỆP VỤ NÂNG CAO (PostgreSQL)
-- Hệ thống đăng ký học phần và kiểm tra điều kiện tiên quyết
-- =====================================================================

SET search_path TO hoc_vu, public;

-- ---------------------------------------------------------------------
-- 1. Inner Join đa bảng: Liệt kê chi tiết sinh viên đăng ký lớp học phần
-- ---------------------------------------------------------------------
SELECT sv.ma_sv, n.ho_ten AS ten_sinh_vien, lhp.ma_lhp, lhp.ten_lhp, 
       hp.ten_hp, gv_n.ho_ten AS ten_giang_vien, dk.trang_thai
FROM dang_ky dk
JOIN sinh_vien sv ON dk.ma_sv = sv.ma_sv
JOIN nguoi n ON sv.ma_sv = n.ma_nguoi
JOIN lop_hoc_phan lhp ON dk.ma_lhp = lhp.ma_lhp
JOIN hoc_phan hp ON lhp.ma_hp = hp.ma_hp
LEFT JOIN giang_vien gv ON lhp.ma_gv = gv.ma_gv
LEFT JOIN nguoi gv_n ON gv.ma_gv = gv_n.ma_nguoi;

-- ---------------------------------------------------------------------
-- 2. Aggregate, GROUP BY & HAVING: Thống kê sĩ số thực tế các lớp học phần
-- ---------------------------------------------------------------------
SELECT lhp.ma_lhp, lhp.ten_lhp, lhp.si_so_toi_da, 
       COUNT(dk.ma_sv) AS so_luong_dang_ky_thuc_te
FROM lop_hoc_phan lhp
LEFT JOIN dang_ky dk ON lhp.ma_lhp = dk.ma_lhp AND dk.trang_thai = 'Da dang ky'
GROUP BY lhp.ma_lhp, lhp.ten_lhp, lhp.si_so_toi_da
HAVING COUNT(dk.ma_sv) >= 5;

-- ---------------------------------------------------------------------
-- 3. Subquery (Không tương quan): Lọc các học phần nặng (số tín chỉ > TB)
-- ---------------------------------------------------------------------
SELECT ma_hp, ten_hp, so_tin_chi
FROM hoc_phan
WHERE so_tin_chi > (
    SELECT AVG(so_tin_chi) FROM hoc_phan
)
ORDER BY so_tin_chi DESC;

-- ---------------------------------------------------------------------
-- 4. Subquery (Tương quan): Tìm sinh viên có điểm tổng kết cao nhất mỗi lớp
-- ---------------------------------------------------------------------
SELECT kq.ma_lhp, sv.ma_sv, n.ho_ten AS ten_sinh_vien, kq.diem_tong_ket
FROM ket_qua_hoc_tap kq
JOIN sinh_vien sv ON kq.ma_sv = sv.ma_sv
JOIN nguoi n ON sv.ma_sv = n.ma_nguoi
WHERE kq.diem_tong_ket = (
    SELECT MAX(kq_sub.diem_tong_ket)
    FROM ket_qua_hoc_tap kq_sub
    WHERE kq_sub.ma_lhp = kq.ma_lhp
);

-- ---------------------------------------------------------------------
-- 5. Window Function (RANK): Xếp hạng điểm số sinh viên trong lớp học phần
-- ---------------------------------------------------------------------
SELECT kq.ma_lhp, n.ho_ten AS ten_sinh_vien, kq.diem_tong_ket,
       RANK() OVER (PARTITION BY kq.ma_lhp ORDER BY kq.diem_tong_ket DESC) AS xep_hang_trong_lop
FROM ket_qua_hoc_tap kq
JOIN sinh_vien sv ON kq.ma_sv = sv.ma_sv
JOIN nguoi n ON sv.ma_sv = n.ma_nguoi;

-- ---------------------------------------------------------------------
-- 6. Window Function (AVG OVER Partition): So sánh điểm cá nhân với TB
-- ---------------------------------------------------------------------
SELECT kq.ma_sv, n.ho_ten, kq.ma_lhp, kq.diem_tong_ket,
       ROUND(AVG(kq.diem_tong_ket) OVER (PARTITION BY kq.ma_sv)::numeric, 2) AS diem_tb_ca_nhan
FROM ket_qua_hoc_tap kq
JOIN sinh_vien sv ON kq.ma_sv = sv.ma_sv
JOIN nguoi n ON sv.ma_sv = n.ma_nguoi;

-- ---------------------------------------------------------------------
-- 7. Common Table Expressions (CTE): Lọc danh sách SV học lực giỏi
-- ---------------------------------------------------------------------
WITH sinh_vien_gioi AS (
    SELECT ma_sv, lop_sinh_hoat, gpa_tich_luy
    FROM sinh_vien
    WHERE gpa_tich_luy >= 3.0
)
SELECT svg.ma_sv, n.ho_ten, n.email, svg.lop_sinh_hoat, svg.gpa_tich_luy
FROM sinh_vien_gioi svg
JOIN nguoi n ON svg.ma_sv = n.ma_nguoi
ORDER BY svg.gpa_tich_luy DESC;

-- ---------------------------------------------------------------------
-- 8. Conditional Aggregation (Pivot đơn giản): Thống kê phổ điểm chữ
-- ---------------------------------------------------------------------
SELECT sv.ma_sv, n.ho_ten,
       COUNT(CASE WHEN kq.diem_chu IN ('A+', 'A') THEN 1 END) AS so_luong_diem_a,
       COUNT(CASE WHEN kq.diem_chu IN ('B+', 'B') THEN 1 END) AS so_luong_diem_b,
       COUNT(CASE WHEN kq.diem_chu IN ('C+', 'C') THEN 1 END) AS so_luong_diem_c,
       COUNT(CASE WHEN kq.diem_chu IN ('D+', 'D') THEN 1 END) AS so_luong_diem_d,
       COUNT(CASE WHEN kq.diem_chu = 'F' THEN 1 END) AS so_luong_diem_f
FROM sinh_vien sv
JOIN nguoi n ON sv.ma_sv = n.ma_nguoi
LEFT JOIN ket_qua_hoc_tap kq ON sv.ma_sv = kq.ma_sv
GROUP BY sv.ma_sv, n.ho_ten;

-- ---------------------------------------------------------------------
-- 9. NOT EXISTS: Tìm các học phần chưa từng được mở lớp giảng dạy
-- ---------------------------------------------------------------------
SELECT hp.ma_hp, hp.ten_hp, hp.so_tin_chi
FROM hoc_phan hp
WHERE NOT EXISTS (
    SELECT 1 
    FROM lop_hoc_phan lhp 
    WHERE lhp.ma_hp = hp.ma_hp
);

-- ---------------------------------------------------------------------
-- 10. EXISTS: Tìm các giảng viên từng dạy SV đạt kết quả xuất sắc (>= 9.0)
-- ---------------------------------------------------------------------
SELECT gv.ma_gv, n.ho_ten AS ten_giang_vien, gv.hoc_vi
FROM giang_vien gv
JOIN nguoi n ON gv.ma_gv = n.ma_nguoi
WHERE EXISTS (
    SELECT 1 
    FROM lop_hoc_phan lhp
    JOIN ket_qua_hoc_tap kq ON lhp.ma_lhp = kq.ma_lhp
    WHERE lhp.ma_gv = gv.ma_gv AND kq.diem_tong_ket >= 9.0
);

-- ---------------------------------------------------------------------
-- 11. SQL động (Dynamic SQL trong PL/pgSQL): Tìm kiếm SV linh hoạt
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION tim_kiem_sinh_vien_dong(col_name TEXT, search_val TEXT)
RETURNS TABLE (ma_sv VARCHAR, ho_ten VARCHAR, chuyen_nganh VARCHAR, gpa FLOAT) AS $$
BEGIN
    RETURN QUERY EXECUTE format(
        'SELECT sv.ma_sv, n.ho_ten, sv.chuyen_nganh, sv.gpa_tich_luy ' ||
        'FROM sinh_vien sv JOIN nguoi n ON sv.ma_sv = n.ma_nguoi ' ||
        'WHERE sv.%I ILIKE %L', 
        col_name, '%' || search_val || '%'
    );
END;
$$ LANGUAGE plpgsql;

-- Ví dụ cách gọi hàm Dynamic SQL:
-- SELECT * FROM tim_kiem_sinh_vien_dong('chuyen_nganh', 'phan mem');
