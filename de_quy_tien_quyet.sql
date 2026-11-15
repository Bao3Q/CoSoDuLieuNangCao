-- =====================================================================
-- TRUY VẤN ĐỆ QUY (WITH RECURSIVE) - PostgreSQL
-- Duyệt cây môn tiên quyết nhiều cấp & phát hiện chu trình lỗi (A -> B -> C -> A)
-- =====================================================================

SET search_path TO hoc_vu, public;

WITH RECURSIVE cay_tien_quyet AS (
    -- 1. Phần cơ sở (Anchor Member): Chọn điểm xuất phát
    SELECT 
        ma_hp, 
        ma_hp_truoc, 
        loai_dieu_kien,
        1 AS cap_do,
        ARRAY[ma_hp] AS duong_di,
        FALSE AS co_chu_trinh
    FROM mon_tien_quyet
    WHERE ma_hp = 'IT301'  -- Thay đổi mã học phần tại đây nếu muốn kiểm tra môn khác

    UNION ALL

    -- 2. Phần đệ quy (Recursive Member): Nối tiếp tìm các môn đứng trước của môn trước đó
    SELECT 
        mtq.ma_hp, 
        mtq.ma_hp_truoc, 
        mtq.loai_dieu_kien,
        cq.cap_do + 1,
        cq.duong_di || mtq.ma_hp,
        -- Kiểm tra nếu môn trước đó đã xuất hiện trong mảng đường đi hiện tại -> Phát hiện chu trình lỗi
        mtq.ma_hp_truoc = ANY(cq.duong_di) AS co_chu_trinh
    FROM mon_tien_quyet mtq
    JOIN cay_tien_quyet cq ON mtq.ma_hp = cq.ma_hp_truoc
    -- Dừng ngay nhánh đệ quy nếu phát hiện chu trình hoặc vượt quá độ sâu an toàn
    WHERE NOT cq.co_chu_trinh AND cq.cap_do < 10
)
SELECT DISTINCT 
    ma_hp, 
    ma_hp_truoc, 
    loai_dieu_kien,
    cap_do, 
    duong_di,
    co_chu_trinh,
    CASE 
        WHEN co_chu_trinh = TRUE THEN 'CẢNH BÁO: Phát hiện chu trình lỗi vòng lặp tiên quyết!'
        ELSE 'Hợp lệ'
    END AS trang_thai_kiem_tra
FROM cay_tien_quyet;
