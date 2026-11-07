# Đồ án 1 – Quản lý trường học

## Timeline thực hiện trong 7 ngày

| Ngày | Công việc cụ thể từng thành viên |
|---|---|
| **Ngày 1** | **M1:** Chốt đặc tả hệ thống quản lý trường học; xác định phạm vi (học sinh, giáo viên, lớp, môn học, đăng ký học, điểm); hoàn thành ERD và bắt đầu chuẩn hóa 3NF/BCNF.<br><br>**M2, M3, M4:** Cùng rà soát ERD, quan hệ và quy tắc nghiệp vụ; thống nhất cấu trúc dữ liệu để bắt đầu triển khai. |
| **Ngày 2–3** | **M2:** Dựng CSDL PostgreSQL; tạo bảng, khóa và ràng buộc; nhập dữ liệu mẫu; viết 10–12 câu SQL (truy vấn danh sách lớp, môn học, kết quả học tập và thống kê).<br><br>**M3:** Viết script transaction cho đăng ký học/ghi danh học sinh; dựng kịch bản tranh chấp dữ liệu khi nhiều người cùng đăng ký hoặc cập nhật.<br><br>**M4:** Thiết kế UML Class theo ODMG; cài đặt ObjectDB; viết 5 câu OQL trên các đối tượng học sinh, lớp, môn học và điểm.<br><br>**M1:** Làm tiếp bài toán chuẩn hóa (bao gồm 4NF nếu phù hợp); tạo khung báo cáo Word và repository GitHub. |
| **Ngày 4–5** | **M2:** Hoàn thiện SQL đệ quy với `WITH RECURSIVE` để duyệt môn học tiên quyết và phát hiện chu trình; bổ sung thủ tục hoặc truy vấn nghiệp vụ cần thiết.<br><br>**M3:** Chạy thử kịch bản tranh chấp đồng thời; thu thập log, so sánh `UPDATE` và mức cô lập `SERIALIZABLE`; ghi lại cách tái hiện và kết quả.<br><br>**M4:** Chạy 5 truy vấn OQL trên ObjectDB; chụp minh chứng và đối chiếu kết quả với mô hình lớp.<br><br>**M1:** Đưa ERD, chuẩn hóa và phần mô tả nghiệp vụ vào báo cáo; bắt đầu ghép các phần code/kết quả của M2–M4. |
| **Ngày 6** | **M1:** Gom kết quả từ M2, M3, M4 vào báo cáo; tổng hợp bảng phân công công việc.<br><br>**M2, M3, M4:** Rà soát lại bài làm của nhau trong báo cáo; chạy `EXPLAIN ANALYZE` cho các truy vấn chính; lý giải kế hoạch thực thi và cân nhắc chỉ mục SQL phù hợp. |
| **Ngày 7** | **M1:** Hoàn thiện báo cáo Word (20–30 trang); làm slide thuyết trình; đẩy đầy đủ code và script lên GitHub.<br><br>**Cả nhóm:** Một thành viên khác chạy lại từ đầu (reproduce) bộ DDL, dữ liệu mẫu, SQL, OQL và transaction theo hướng dẫn; kiểm tra demo chạy được và chuẩn bị trả lời câu hỏi. |

## Sản phẩm cần bàn giao

- Báo cáo mô tả yêu cầu, ERD, chuẩn hóa, thiết kế CSDL và các chức năng chính.
- Script PostgreSQL tạo cấu trúc, ràng buộc và dữ liệu mẫu; bộ truy vấn SQL và kịch bản transaction.
- Mô hình UML Class ODMG, dữ liệu ObjectDB và các truy vấn OQL (nếu thuộc yêu cầu đồ án).
- Kết quả kiểm thử, minh chứng truy vấn và hướng dẫn chạy lại dự án.
- Slide thuyết trình và repository GitHub có thể tái hiện theo hướng dẫn.