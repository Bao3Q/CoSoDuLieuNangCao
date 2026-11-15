-- =====================================================================
-- TRUY VẤN NGHIỆP VỤ (Q1 - Q10) - PostgreSQL
-- Hệ thống đăng ký học phần và kiểm tra điều kiện tiên quyết
-- Mỗi truy vấn kèm phát biểu nghiệp vụ; kết quả chạy trên dữ liệu mẫu
-- được ghi minh chứng ở Chương 7.
-- =====================================================================

SET search_path TO hoc_vu, public;

-- ---------------------------------------------------------------------
-- 6.1.1. Q1 — Truy vết toàn bộ chuỗi tiên quyết (trực tiếp và gián tiếp)
-- Phát biểu nghiệp vụ: Cho biết toàn bộ các môn tiên quyết (trực tiếp
-- và gián tiếp) của một học phần, kèm mức độ gần/xa của từng môn.
-- ---------------------------------------------------------------------
WITH RECURSIVE chuoi_tien_quyet AS (
    SELECT ma_hp, ma_hp_truoc, 1 AS cap
    FROM   hoc_vu.mon_tien_quyet
    WHERE  ma_hp = 'IT301'
    UNION ALL
    SELECT c.ma_hp, m.ma_hp_truoc, c.cap + 1
    FROM   chuoi_tien_quyet c
    JOIN   hoc_vu.mon_tien_quyet m ON m.ma_hp = c.ma_hp_truoc
)
SELECT ma_hp_truoc AS mon_tien_quyet, MIN(cap) AS muc_gan_nhat
FROM   chuoi_tien_quyet
GROUP  BY ma_hp_truoc
ORDER  BY muc_gan_nhat;

-- ---------------------------------------------------------------------
-- 6.1.2. Q2 — Phát hiện chu trình trong đồ thị tiên quyết (NR5)
-- Phát biểu nghiệp vụ: Phát hiện ràng buộc tiên quyết bị nhập vòng
-- (A cần B, B lại cần A). Mảng da_di_qua đóng vai trò bộ nhớ đường đi:
-- nếu một học phần quay về đúng đỉnh xuất phát, truy vấn trả về danh
-- sách môn nằm trên chu trình — đầu vào cần xử lý khi phòng đào tạo
-- nhập nhầm ràng buộc.
-- ---------------------------------------------------------------------
WITH RECURSIVE duong_di AS (
    SELECT ma_hp, ma_hp_truoc,
           ARRAY[ma_hp, ma_hp_truoc]::varchar[] AS da_di_qua
    FROM   hoc_vu.mon_tien_quyet
    UNION ALL
    SELECT d.ma_hp, m.ma_hp_truoc, d.da_di_qua || m.ma_hp_truoc
    FROM   duong_di d
    JOIN   hoc_vu.mon_tien_quyet m ON m.ma_hp = d.ma_hp_truoc
    WHERE  NOT m.ma_hp_truoc = ANY(d.da_di_qua)   -- dừng khi gặp đỉnh đã đi qua
)
SELECT DISTINCT ma_hp AS mon_ro_chu_trinh
FROM   duong_di
WHERE  ma_hp_truoc = da_di_qua[1];

-- ---------------------------------------------------------------------
-- 6.1.3. Q3 — Sinh viên đủ điều kiện đăng ký một học phần (phép chia
-- bằng NOT EXISTS)
-- Phát biểu nghiệp vụ: Liệt kê sinh viên đã đạt toàn bộ các môn tiên
-- quyết của học phần 'IT301', do đó đủ điều kiện đăng ký học phần này.
-- ---------------------------------------------------------------------
SELECT sv.ma_sv, n.ho_ten
FROM   hoc_vu.sinh_vien sv
JOIN   hoc_vu.nguoi n ON n.ma_nguoi = sv.ma_sv
WHERE  NOT EXISTS (          -- không tồn tại môn tiên quyết nào
    SELECT 1 FROM hoc_vu.mon_tien_quyet mtq
    WHERE  mtq.ma_hp = 'IT301'
      AND  NOT EXISTS (     -- mà sinh viên chưa đạt môn đó
          SELECT 1
          FROM   hoc_vu.ket_qua_hoc_tap kq
          JOIN   hoc_vu.lop_hoc_phan lhp ON lhp.ma_lhp = kq.ma_lhp
          WHERE  kq.ma_sv = sv.ma_sv
            AND  lhp.ma_hp = mtq.ma_hp_truoc
            AND  kq.diem_chu <> 'F'
      )
);

-- ---------------------------------------------------------------------
-- 6.1.4. Q4 — Lớp học phần còn chỗ trong học kỳ
-- Phát biểu nghiệp vụ: Liệt kê các lớp học phần còn nhận đăng ký trong
-- học kỳ '20241', sắp xếp theo số chỗ còn lại giảm dần.
-- ---------------------------------------------------------------------
SELECT lhp.ma_lhp, hp.ten_hp, lhp.si_so_toi_da, lhp.si_so_hien_tai,
       lhp.si_so_toi_da - lhp.si_so_hien_tai AS con_lai
FROM   hoc_vu.lop_hoc_phan lhp
JOIN   hoc_vu.hoc_phan hp ON hp.ma_hp = lhp.ma_hp
WHERE  lhp.ma_hk = '20241'
  AND  lhp.si_so_hien_tai < lhp.si_so_toi_da
ORDER  BY con_lai DESC;

-- ---------------------------------------------------------------------
-- 6.1.5. Q5 — Học phần có ít nhất 5 sinh viên đạt điểm A
-- (GROUP BY / HAVING)
-- Phát biểu nghiệp vụ: Thống kê các học phần mà ít nhất 5 sinh viên
-- đạt loại A/A+ — chỉ dấu học phần dễ đạt kết quả cao hoặc chất lượng
-- giảng dạy tốt.
-- ---------------------------------------------------------------------
SELECT hp.ma_hp, hp.ten_hp, COUNT(*) AS so_sv_dat_A
FROM   hoc_vu.ket_qua_hoc_tap kq
JOIN   hoc_vu.lop_hoc_phan lhp ON lhp.ma_lhp = kq.ma_lhp
JOIN   hoc_vu.hoc_phan hp      ON hp.ma_hp   = lhp.ma_hp
WHERE  kq.diem_chu IN ('A+', 'A')
GROUP  BY hp.ma_hp, hp.ten_hp
HAVING COUNT(*) >= 5
ORDER  BY so_sv_dat_A DESC;

-- ---------------------------------------------------------------------
-- 6.1.6. Q6 — Học phần chưa được mở lớp lần nào (OUTER JOIN)
-- Phát biểu nghiệp vụ: Tìm học phần chưa từng được mở lớp giảng dạy
-- — cơ sở để phòng đào tạo rà soát danh mục học phần.
-- ---------------------------------------------------------------------
SELECT hp.ma_hp, hp.ten_hp, hp.so_tin_chi
FROM   hoc_vu.hoc_phan hp
LEFT JOIN hoc_vu.lop_hoc_phan lhp ON lhp.ma_hp = hp.ma_hp
WHERE  lhp.ma_lhp IS NULL;

-- ---------------------------------------------------------------------
-- 6.1.7. Q7 — Xếp hạng sinh viên theo GPA trong từng chuyên ngành
-- (hàm cửa sổ)
-- Phát biểu nghiệp vụ: Xếp hạng học lực của sinh viên trong nội bộ
-- từng chuyên ngành, dùng cho danh sách khen thưởng học bổng.
-- ---------------------------------------------------------------------
SELECT n.ho_ten, sv.chuyen_nganh, sv.gpa_tich_luy,
       RANK() OVER (PARTITION BY sv.chuyen_nganh
                    ORDER BY sv.gpa_tich_luy DESC) AS xep_hang
FROM   hoc_vu.sinh_vien sv
JOIN   hoc_vu.nguoi n ON n.ma_nguoi = sv.ma_sv
ORDER  BY sv.chuyen_nganh, xep_hang;

-- ---------------------------------------------------------------------
-- 6.1.8. Q8 — Tổng hợp kết quả học tập theo học phần và học kỳ
-- Phát biểu nghiệp vụ: Thống kê sĩ số, điểm trung bình và số sinh viên
-- rớt của từng học phần theo học kỳ — báo cáo chất lượng đào tạo.
-- ---------------------------------------------------------------------
SELECT hk.ten_hk, hp.ma_hp, hp.ten_hp,
       COUNT(*)                                  AS so_sv_hoc,
       ROUND(AVG(kq.diem_tong_ket)::numeric, 2)  AS diem_tb,
       SUM(CASE WHEN kq.diem_chu = 'F' THEN 1 ELSE 0 END) AS so_sv_rot
FROM   hoc_vu.ket_qua_hoc_tap kq
JOIN   hoc_vu.lop_hoc_phan lhp ON lhp.ma_lhp = kq.ma_lhp
JOIN   hoc_vu.hoc_phan hp      ON hp.ma_hp   = lhp.ma_hp
JOIN   hoc_vu.hoc_ky hk        ON hk.ma_hk   = lhp.ma_hk
GROUP  BY hk.ten_hk, hp.ma_hp, hp.ten_hp
ORDER  BY hk.ten_hk, hp.ma_hp;

-- ---------------------------------------------------------------------
-- 6.1.9. Q9 — Sinh viên đã học tất cả học phần do một giảng viên dạy
-- (phép chia bằng NOT EXISTS)
-- Phát biểu nghiệp vụ: Tìm sinh viên đã hoàn thành mọi lớp học phần do
-- giảng viên 'N201' phụ trách — phục vụ tra cứu theo giảng viên hướng
-- dẫn / cố vấn học tập.
-- ---------------------------------------------------------------------
SELECT sv.ma_sv, n.ho_ten
FROM   hoc_vu.sinh_vien sv JOIN hoc_vu.nguoi n ON n.ma_nguoi = sv.ma_sv
WHERE  NOT EXISTS (
    SELECT 1
    FROM   hoc_vu.lop_hoc_phan lhp
    WHERE  lhp.ma_gv = 'N201'
      AND  NOT EXISTS (
          SELECT 1 FROM hoc_vu.ket_qua_hoc_tap kq
          WHERE  kq.ma_sv = sv.ma_sv AND kq.ma_lhp = lhp.ma_lhp
      )
);

-- ---------------------------------------------------------------------
-- 6.1.10. Q10 — Cây danh mục các lớp học phần đang mở theo học phần gốc
-- (WITH RECURSIVE)
-- Phát biểu nghiệp vụ: Duyệt cây môn học bắt đầu từ 'IT101': liệt kê
-- các lớp học phần của môn gốc và các lớp của các môn phụ thuộc theo
-- thứ bậc (cap tăng dần theo độ sâu của cây tiên quyết).
-- ---------------------------------------------------------------------
WITH RECURSIVE lop_theo_hp AS (
    SELECT ma_hp, ma_lhp, ten_lhp, 0 AS cap
    FROM   hoc_vu.lop_hoc_phan
    WHERE  ma_hp = 'IT101'
    UNION ALL
    SELECT hp.ma_hp, l.ma_lhp, l.ten_lhp, c.cap + 1
    FROM   lop_theo_hp c
    JOIN   hoc_vu.mon_tien_quyet mtq ON mtq.ma_hp_truoc = c.ma_hp
    JOIN   hoc_vu.hoc_phan hp         ON hp.ma_hp = mtq.ma_hp
    JOIN   hoc_vu.lop_hoc_phan l     ON l.ma_hp = hp.ma_hp
)
SELECT ma_hp, ma_lhp, ten_lhp, cap
FROM   lop_theo_hp
ORDER  BY cap, ma_lhp;
