## Mỗi nhóm đều phải đáp ứng các chuẩn đầu ra yêu cầu chung như sau:

- Phân tích và thi¿t k¿: mô t£ nghiÇp vå, quy t¯c dï liÇu, s¡ —Ó EER có chuyên biÇt hóa/tổng quát hóa, lược đồ quan hệ và từ điển dữ liệu.

- Chu©n hóa: xác Ënh phå thuÙc hàm të quy t¯c nghiÇp vå; trình bày bao óng, khóa, phç tối tiểu trên một lược đồ tiêu biểu; giải thích lựa chọn 3NF/BCNF, tính nối không mất mát và bảo toàn phụ thuộc. Phân tích 4NF khi có phụ thuộc đa trị phù hợp.

- SQL nâng cao: kho£ng 10112 truy v¥n/nghiÇp vå, có truy v¥n con, k¿t nÑi, k¿t gÙp, ràng buộc, thủ tục/hàm, SQL động và đệ quy. Có ví dụ nhỏ về SQL nhúng nếu triển khai đầy đủ mục 5.6.

- CSDL h°Ûng Ñi t°ãng: thi¿t k¿ mÙt phân hÇ gÓm kho£ng 46 lÛp, có Ënh danh Ñi tượng, kế thừa, tập hợp, quan hệ và phương thức; viết tối thiểu 5 truy vấn OQL kèm kết quả mong đợi.

- Transaction: có kËch b£n thành công, l×i giïa chëng và c¡nh tranh giïa ít nh¥t hai phiên giao dịch.

- Thñc nghiÇm: cung c¥p dï liÇu, script và k¿t qu£ có thÃ ch¡y l¡i; phân biÇt rõ k¿t qu£ -o thực tế với phân tích lý thuyết.

Có thể thống nhất dùng PostgreSQL cho phần quan hệ. Với phần đối tượng, cần phân biệt OQL trong nội dung môn học với JPQL/JDOQL của công cụ triển khai. ObjectDB hỗ trợ JPQL/JDOQL; nếu sử dụng, sinh viên vẫn cần trình bày riêng phần OQL và ánh xạ sang ngôn ngữ thực thi. objectdb.com. Nhóm sinh viên tự nghiên cứu về PostgreSQL cho phần quan hệ. Với phần đối tượng, tự nghiên cứu phân biệt OQL trong nội dung môn học với JPQL/JDOQL của công cụ triển khai. [URL 🔗](https://www.objectdb.com/database/features?utm_source=chatgpt.com)

## Gợi ý tổ chức nghiên cứu và báo cáo cuối khóa

Có thể tổ chức 1–5 sinh viên/nhóm, mỗi nhóm chọn một đề tài. Tiến độ nên đi cùng lịch 12 tuần của đề cương:

## Thời gian Công việc và kết quả cần nộp

Tuần 1–2 Chọn đề tài; xác định câu hỏi nghiên cứu, phạm vi, tài liệu và phân công Tuần 3 Nộp đặc tả nghiệp vụ, EER và các ràng buộc Tuần 4–5 Nộp phân tích phụ thuộc hàm, khóa, chuẩn hóa và lược đồ quan hệ Tuần 6–8 Hoàn thành CSDL quan hệ, SQL nâng cao, dữ liệu và kiểm thử ban đầu Tuần 9–10 Hoàn thành thiết kế đối tượng, OQL và phần thực nghiệm tương ứng Tuần 11 Hoàn thành kiểm thử transaction, thực nghiệm so sánh và phân tích kết quả

Tuần 12 Nộp báo cáo, trình diễn và bảo vệ


Bộ sản phẩm đề xuất: báo cáo khoảng 20–30 trang không tính phụ lục; slide; mã nguồn và script dựng CSDL; dữ liệu mẫu hoặc chương trình sinh dữ liệu; bộ SQL/OQL; nhật ký thực nghiệm và hướng dẫn chạy lại. Phần trình bày có thể gồm 15 phút báo cáo, 5 phút demo và 10 phút phản biện.

Báo cáo nên theo trình tự: bài toán và câu hỏi nghiên cứu → cơ sở lý thuyết → thiết kế → hiện thực → thực nghiệm → thảo luận kết quả và hạn chế. Mỗi kết luận cần gắn với lập luận, ví dụ dữ liệu hoặc kết quả đo.

Có thể chấm riêng điểm đồ án theo thang 10 như sau; điểm này sau đó được tính theo trọng số 50% của đề cương:

## Tiêu chí Điểm

Phân tích yêu cầu và thiết kế EER

1,5

Phụ thuộc hàm, chuẩn hóa và thiết kế quan hệ 2,0

SQL nâng cao và thiết kế vật lý Thiết kế CSDL hướng đối tượng và OQL

2,0 1,5

Transaction, thực nghiệm và phân tích kết quả 2,0 Báo cáo, khả năng tái lập và bảo vệ cá nhân 1,0

Tổng

10,0

## Quy định chung cho các đồ án

## Sản phẩm nộp:

- 1. Báo cáo viết.

- 2. Mã nguồn hoặc script CSDL (DDL, dữ liệu mẫu, truy vấn, thủ tục) đưa lên GitHub.

- 3. Slide thuyết trình.

- 4. Biên bản phân công và làm việc nhóm (dùng cho CLO7).

## Cấu trúc báo cáo gợi ý:

- 1. Giới thiệu và mục tiêu.

- 2. Phân tích yêu cầu.

- 3. Thiết kế mức quan niệm (EER).

- 4. Thiết kế mức logic và chuẩn hóa.

- 5. Thiết kế mức vật lý.

- 6. Phần chuyên sâu của đề tài.

- 7. Kiểm thử và đánh giá.

- 8. Kết luận và hướng phát triển.

- 9. Tài liệu tham khảo.


## 1. Đồ án 1: Thiết kế CSDL hệ thống đăng ký học phần và kiểm tra điều kiện tiên quyết

## 1. Đồ án 1: Thiết kế CSDL hệ thống đăng ký học phần và kiểm tra điều kiện tiên quyết

Mục tiêu: Xây dựng CSDL phục vụ mở lớp, đăng ký/hủy học phần, kiểm tra điều kiện học tập và kiểm soát sĩ số.

Câu hỏi nghiên cứu: Làm thế nào biểu diễn quan hệ tiên quyết nhiều cấp và bảo đảm lớp không vượt sĩ số khi nhiều sinh viên đăng ký đồng thời?

- 4. Nghiên cứu SQL nâng cao. Viết truy vấn tìm toàn bộ môn tiên quyết trực tiếp/gián tiếp, phát hiện chu trình tiên quyết, tìm sinh viên đủ điều kiện và tổng hợp kết quả học tập.


- Database System Concepts  bÙ bài gi£ng cça tác gi£: Íc ph§n thi¿t k¿ ER, thi¿t k¿ quan hệ, SQL nâng cao và transaction. slides [URL 🔗](https://www.db-book.com/slides-dir/?utm_source=chatgpt.com)

- PostgreSQL ‑ WITH và truy v¥n ‑Ç quy: tham kh£o duyÇt quan hÇ nhiÁu c¥p và phát hiện chu trình. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/queries-with.html?utm_source=chatgpt.com)

- PostgreSQL  Explicit Locking: nghiên céu c¡ ch¿ khóa phåc vå ng ký Óng thÝi. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/explicit-locking.html?utm_source=chatgpt.com)

2. Đồ án 2: Thiết kế và đánh giá CSDL quản lý bán hàng, tồn kho tại nhiều kho

- 2. Đồ án 2: Thiết kế và đánh giá CSDL quản lý bán hàng, tồn kho tại nhiều kho

Mục tiêu: Thiết kế CSDL quản lý đơn hàng, nhập/xuất/chuyển kho, bảo đảm số lượng tồn và trạng thái đơn hàng nhất quán.

## Câu hỏi nghiên cứu: Chuẩn hóa và tổ chức transaction ảnh hưởng như thế nào đến tính đúng đắn và hiệu quả của nghiệp vụ bán hàng?

Phạm vi gợi ý: Sản phẩm, danh mục, nhà cung cấp, khách hàng, kho, tồn kho, đơn hàng, chi tiết đơn, phiếu nhập/xuất và chuyển kho. Các kho là đơn vị nghiệp vụ trong một CSDL tập trung.

## Các bước nghiên cứu

- 1. Xác định quy tắc nghiệp vụ. Làm rõ tồn thực tế, lượng đã giữ cho đơn hàng và lượng có thể bán; quy định việc hủy đơn và hoàn kho.

- 2. Phân tích dữ liệu ban đầu. Xây dựng một bảng bán hàng tổng hợp còn dư thừa; chỉ ra bất thường khi thêm, sửa và xóa dữ liệu.

- 3. Chuẩn hóa có lập luận. Tìm khóa, phủ tối tiểu và phân rã về 3NF/BCNF. Giải thích vì sao giá bán tại thời điểm đặt hàng cần được lưu riêng với giá hiện tại của sản phẩm.

- 4. Hiện thực SQL. Tạo thủ tục đặt/hủy đơn, truy vấn doanh thu, sản phẩm sắp hết hàng, nhà cung cấp đáp ứng nhiều mặt hàng; dùng đệ quy cho cây danh mục và SQL động cho báo cáo có bộ lọc.

- 5. Nghiên cứu transaction. Gộp việc tạo đơn, tạo chi tiết và cập nhật tồn thành một giao dịch. Cố ý gây lỗi sau một bước để kiểm chứng rollback; cho hai phiên đồng thời mua lượng hàng cuối.

- 6. Đánh giá và thiết kế đối tượng. Đo một số truy vấn trước/sau khi thêm chỉ mục trên cùng dữ liệu; xây dựng phân hệ đối tượng DonHang–ChiTietDonHang–SanPham, kèm OQL.

Minh chứng cần có khi báo cáo: Không phát sinh tồn âm trái quy tắc; lỗi giữa chừng không để lại đơn hàng thiếu chi tiết; có phân tích kế hoạch thực thi trước/sau tối ưu.

## Tài liệu tham khảo


- Fundamentals of Database Systems  Elmasri và Navathe: Íc Ch°¡ng 1415 vÁ chu©n hóa và Chương 20–22 về giao dịch, đồng thời và phục hồi. Đây là trang nhà xuất bản, sách có thể cần quyền truy cập. pearson.com [URL 🔗](https://www.pearson.com/en-us/subject-catalog/p/redirected-product/P200000003546/9780133970777?utm_source=chatgpt.com)

- PostgreSQL ‑ PL/pgSQL Basic Statements: tham kh£o thñc thi SQL trong hàm/thç tåc và SQL động. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/plpgsql-statements.html?utm_source=chatgpt.com)

- PostgreSQL  Using EXPLAIN: Íc và ánh giá k¿ ho¡ch thñc thi truy v¥n. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/using-explain.html?utm_source=chatgpt.com)

3. Đồ án: Thiết kế CSDL thư viện học liệu đa phương tiện

## 3. Đồ án: Thiết kế CSDL thư viện học liệu đa phương tiện

## Mục tiêu: Quản lý thống nhất sách, luận văn, video bài giảng và tài liệu điện tử; nghiên cứu kế

thừa và dữ liệu đa trị.

## Câu hỏi nghiên cứu: Cách biểu diễn các loại học liệu và các thuộc tính đa trị ảnh hưởng thế nào

đến dư thừa dữ liệu, truy vấn và khả năng mở rộng?

## Phạm vi gợi ý: Học liệu, tác giả, chủ đề, bản sao, tệp tài nguyên, bạn đọc, phiếu mượn và quyền truy cập học liệu.

## Các bước nghiên cứu

- 1. Khảo sát đặc điểm học liệu. Xác định thuộc tính dùng chung và riêng: ISBN của sách, người hướng dẫn của luận văn, thời lượng của video.

- 2. Xây dựng EER. Thiết kế lớp cha HocLieu và các lớp con; nêu rõ điều kiện chuyên biệt hóa toàn phần/bộ phận, rời nhau/chồng lấp.

- 3. Nghiên cứu phụ thuộc đa trị. Xét quan hệ HocLieu–TacGia–ChuDe. Nếu tập tác giả và tập chủ đề độc lập theo nghiệp vụ, phân tích phụ thuộc đa trị và phân rã về 4NF; giải thích vì sao giả định độc lập là cần thiết.

- 4. So sánh cách ánh xạ kế thừa. Thử thiết kế một bảng chung và thiết kế bảng cha–bảng con; đánh giá giá trị NULL, ràng buộc và truy vấn trên từng phương án.

- 5. Hiện thực truy vấn và giao dịch. Tìm học liệu thuộc nhiều chủ đề, thống kê lượt mượn, duyệt cây chủ đề; kiểm thử hai người cùng mượn bản sao cuối cùng.

- 6. Thiết kế CSDL đối tượng. Mô hình hóa kế thừa, tập tác giả và tập chủ đề; viết OQL duyệt quan hệ đối tượng và so sánh cách diễn đạt với SQL.

Ví dụ dữ liệu chứng minh dư thừa trước phân rã 4NF; kết quả

nối khôi phục đúng thông tin; bảng so sánh hai cách ánh xạ kế thừa.

## Minh chứng cần có khi báo cáo:

## Tài liệu tham khảo


- Fundamentals of Database Systems: Íc Ch°¡ng 4 vÁ EER, Ch°¡ng 12 vÁ CSDL Ñi tượng và Chương 15 về thuật toán thiết kế, các phụ thuộc nâng cao. pearson.com [URL 🔗](https://www.pearson.com/en-us/subject-catalog/p/redirected-product/P200000003546/9780133970777?utm_source=chatgpt.com)

- Database System Concepts  bài gi£ng: sí dång ph§n Relational Database Design Ã nghiên cứu phụ thuộc và chuẩn hóa. slides [URL 🔗](https://www.db-book.com/slides-dir/?utm_source=chatgpt.com)

- ObjectDB ‐ Developer s Guide: tham kh£o n¿u nhóm triÃn khai thêm b£n m«u l°u đối tượng. ObjectDB [URL 🔗](https://www.objectdb.com/java/jpa?utm_source=chatgpt.com)

4. Đồ án: Thiết kế CSDL đặt phòng và nghiên cứu kiểm soát giao dịch đồng thời

## 4. Đồ án: Thiết kế CSDL đặt phòng và nghiên cứu kiểm soát giao dịch đồng thời

Mục tiêu: Xây dựng CSDL đặt phòng theo khoảng thời gian và đánh giá các cách ngăn đặt trùng.

## Câu hỏi nghiên cứu: Cơ chế nào bảo đảm một phòng không có hai đặt chỗ hiệu lực chồng lấn khi nhiều người đặt đồng thời?

## Phạm vi gợi ý: Khách hàng, phòng, loại phòng, đặt chỗ, khách lưu trú, dịch vụ và thanh toán mô

phỏng.

## Các bước nghiên cứu

- 1. Đặc tả quy tắc thời gian. Thống nhất khoảng lưu trú dạng [ngày nhận, ngày trả); xác định trạng thái đặt chỗ nào chiếm phòng và điều kiện hủy.

- 2. Thiết kế EER và chuẩn hóa. Phân biệt đặt chỗ với lượt lưu trú thực tế; mô hình hóa khách cá nhân/khách tổ chức và các quan hệ sử dụng dịch vụ.

- 3. Xây dựng SQL nghiệp vụ. Tìm phòng trống theo khoảng ngày, tính chi phí, thống kê công suất phòng và doanh thu; bổ sung truy vấn đệ quy trên cơ cấu cơ sở–tòa–tầng.

- 4. Tạo kịch bản tranh chấp. Cho hai phiên cùng kiểm tra một phòng đang trống rồi cùng đặt; lưu thứ tự đọc/ghi và kết quả để giải thích nguyên nhân.

- 5. So sánh giải pháp. Thử khóa bản ghi phòng trước khi kiểm tra, mức cô lập SERIALIZABLE, hoặc ràng buộc loại trừ khoảng thời gian nếu dùng PostgreSQL. Đánh giá cả tính đúng đắn, thời gian chờ và việc thử lại.

- 6. Kiểm thử lỗi và thiết kế đối tượng. Gây lỗi khi đặt phòng kèm thanh toán mô phỏng để kiểm chứng tính nguyên tử; thiết kế Phong, DatCho, KhachHang, DichVu và truy vấn OQL.

## Minh chứng cần có khi báo cáo: Kịch bản đặt trùng có thể tái hiện; giải pháp ngăn được lỗi đó;

kết quả đo ở nhiều mức đồng thời và giải thích các giao dịch bị hủy/thử lại.

Khi dùng PostgreSQL, cần đối chiếu hành vi thực tế với tài liệu: READ UNCOMMITTED hoạt động

như

[postgresql.org](https://www.postgresql.org/docs/current/transaction-iso.html?utm_source=chatgpt.com)

READ COMMITTED,

nên không đặt yêu cầu thực nghiệm phải tạo được dirty read trên hệ này.


## Tài liệu tham khảo

- PostgreSQL ‑ Transaction Isolation: nghiên céu các méc cô l­p và hiÇn t°ãng b¥t thường. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/transaction-iso.html?utm_source=chatgpt.com)

- PostgreSQL ‒ Explicit Locking: nghiên céu khóa và deadlock. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/explicit-locking.html?utm_source=chatgpt.com)

- PostgreSQL  Constraints: tham kh£o ràng buÙc toàn v¹n, ·c biÇt exclusion constraints. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/ddl-constraints.html?utm_source=chatgpt.com)

5. Đồ án: So sánh CSDL quan hệ và CSDL hướng đối tượng trong quản lý cấu trúc sản phẩm

5. Đồ án: So sánh CSDL quan hệ và CSDL hướng đối tượng trong quản lý cấu trúc sản phẩm

Mục tiêu: Biểu diễn sản phẩm gồm nhiều cụm và linh kiện; so sánh hai mô hình CSDL trên

cùng bài toán.

Câu hỏi nghiên cứu: Với cấu trúc sản phẩm nhiều cấp, mô hình nào thuận tiện hơn cho biểu diễn, truy vấn và thay đổi cấu trúc? Kết quả có thay đổi theo độ sâu và số lượng thành phần

không?

Phạm vi gợi ý: Sản phẩm, cụm lắp ráp, linh kiện cơ khí/điện tử, quan hệ cấu thành, số lượng

linh kiện và phiên bản thiết kế.

## Các bước nghiên cứu

- 1. Xác định ngữ nghĩa cấu trúc. Cho phép một linh kiện xuất hiện trong nhiều cụm; quy định số lượng trên mỗi quan hệ cấu thành; ngăn chu trình.

- 2. Thiết kế mô hình quan hệ. Xây dựng bảng thành phần, loại thành phần, quan hệ cấu thành và phiên bản; phân tích khóa, phụ thuộc hàm và chuẩn hóa.

- 3. Thiết kế mô hình đối tượng. Xây dựng lớp ThanhPhan, CumLapRap, LinhKienCoKhi, LinhKienDienTu; thể hiện kế thừa, định danh và tham chiếu đến các thành phần dùng chung.

- 4. Thiết kế bộ truy vấn tương đương. Tìm tất cả linh kiện của sản phẩm, tổng lượng cần dùng, chi phí cấu thành và sản phẩm bị ảnh hưởng khi một linh kiện thay đổi. Viết SQL và OQL trên cùng ngữ nghĩa.

- 5. Hiện thực hai bản mẫu. Dùng PostgreSQL cho quan hệ và một hệ CSDL đối tượng phù hợp, chẳng hạn ObjectDB. Nếu chạy JPQL/JDOQL, ghi rõ phần chuyển đổi từ OQL và giới hạn tương đương.

- 6. Thực nghiệm và kết luận. Thay đổi số nút, độ sâu, mức dùng chung linh kiện; đo thời gian truy vấn/cập nhật. Kiểm tra transaction khi sửa nhiều thành phần của một phiên bản và giải thích phạm vi áp dụng của kết quả.

Minh chứng cần có khi báo cáo: Hai mô hình, bộ truy vấn đối chiếu cho cùng kết quả, dữ liệu thực nghiệm và bảng so sánh về khả năng biểu diễn, độ phức tạp triển khai, hiệu năng.


Không nên kết luận một mô hình “luôn tốt hơn”; kết luận cần gắn với dữ liệu, cấu hình và loại thao tác đã thử.

## Tài liệu tham khảo

- Fundamentals of Database Systems: dùng Ch°¡ng 12 làm nÁn t£ng nghiên céu mô hình đối tượng và đối tượng–quan hệ. pearson.com [URL 🔗](https://www.pearson.com/en-us/subject-catalog/p/redirected-product/P200000003546/9780133970777?utm_source=chatgpt.com)

- PostgreSQL - Recursive Queries: có ví då truy v¥n các bÙ ph­n c¥u thành và tính tÕng sÑ lượng. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/queries-with.html?utm_source=chatgpt.com)

- ObjectDB  Developers Guide: h°Ûng d«n Ënh ngh)a, l°u trï và truy v¥n Ñi t°ãng. ObjectDB [URL 🔗](https://www.objectdb.com/java/jpa?utm_source=chatgpt.com)

- Apache JDO  JDOQL: tài liÇu ngôn ngï Ã tham kh£o khi chÍn h°Ûng triÃn khai JDO. db.apache.org [URL 🔗](https://db.apache.org/jdo/jdoql.html?utm_source=chatgpt.com)

## Tài liệu nền dùng chung:

- Elmasri & Navathe, cương). Fundamentals of Database Systems, b£n 7 (tài liÇu chính cça —Á

- Silberschatz, Korth, Sudarshan, Database System Concepts, b£n 7. Slide và bài t­p có t¡i https://www.db-book.com/ [URL 🔗](https://www.db-book.com/)

- Connolly & Begg, Database Systems, b£n 6. Các ch°¡ng 16118 trình bày ph°¡ng pháp thiết kế quan niệm, logic và vật lý.

- Tài liÇu PostgreSQL: https://www.postgresql.org/docs/current/

- Khóa CMU 15-445/645 Database Systems (bài gi£ng và video miÅn phí): https://15445.courses.cs.cmu.edu/ [URL 🔗](https://15445.courses.cs.cmu.edu/)

- Công cå v½ mô hình: https://app.diagrams.net/, https://dbdiagram.io/, MySQL Workbench (https://www.mysql.com/products/workbench/) [URL 🔗](https://www.mysql.com/products/workbench/)

Đồ án 6. Thiết kế CSDL quản lý bệnh viện bằng mô hình EER và chuẩn hóa

## Đồ án 6. Thiết kế CSDL quản lý bệnh viện bằng mô hình EER và chuẩn hóa

Bài toán:

dưỡng và kỹ thuật viên. Bệnh nhân chia thành nội trú và ngoại trú. Hệ thống cần quản lý lượt khám, đơn thuốc, xét nghiệm, giường bệnh, viện phí và bảo hiểm y tế.

Bệnh viện có nhiều khoa và phòng. Nhân viên được chuyên biệt hóa thành bác sĩ, điều

## Yêu cầu chính:


- Xây dñng mô hình EER –§y –ç. Mô hình ph£i có chuyên biÇt hóa và tÕng quát hóa vÛi các ràng buộc disjoint/overlap và total/partial, tập thực thể yếu, mối kết hợp bậc 3 (ví dụ bác sĩ – bệnh nhân – thuốc), thuộc tính đa trị và thuộc tính phức hợp.

- Ánh x¡ mô hình EER sang l°ãc Ó quan hÇ. So sánh các ph°¡ng án ánh x¡ quan hÇ cha  con (tách bảng, gộp bảng, bảng chung có cột phân loại).

- Xác –Ënh t­p phå thuÙc hàm. Tìm khóa, tìm phç tÑi tiÃu, chu©n hóa –¿n BCNF và xét thêm 4NF nếu có phụ thuộc đa trị.

- Thi¿t k¿ méc v­t lý: chÍn kiÃu dï liÇu, chÉ måc, ràng buÙc. Cài ‑·t trên PostgreSQL ho·c SQL Server với khoảng 10.000 bản ghi mẫu.

## Các bước nghiên cứu gợi ý:

- 1. Tuần 3–4. Phỏng vấn hoặc khảo sát nghiệp vụ, có thể tham khảo quy trình khám chữa bệnh thực tế. Viết bản đặc tả yêu cầu gồm danh sách thực thể, nghiệp vụ và báo cáo cần có.

- 2. Tuần 4–5. Vẽ mô hình EER và giải thích từng ràng buộc chuyên biệt hóa.

- 3. Tuần 5–6. chi tiết thuật toán tìm bao đóng và kiểm tra tính bảo toàn thông tin (lossless join). Ánh xạ sang mô hình quan hệ, liệt kê phụ thuộc hàm và chuẩn hóa. Trình bày

- 4. Tuần 7–8. Thiết kế vật lý, sinh dữ liệu mẫu, viết 15–20 truy vấn nghiệp vụ.

- 5. Tuần 9–11. Kiểm thử, đo hiệu năng trước và sau khi thêm chỉ mục, hoàn thiện báo cáo.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 314 (ER/EER), 9 (ánh x¡ ER sang quan hÇ), 14115 (phå thuộc hàm, chuẩn hóa).

- P. Chen (1976), The Entity-Relationship Model: https://dl.acm.org/doi/10.1145/320434.320440 [URL 🔗](https://dl.acm.org/doi/10.1145/320434.320440)

- W. Kent, A Simple Guide to Five Normal Forms: https://www.bkent.net/Doc/simple5.htm [URL 🔗](https://www.bkent.net/Doc/simple5.htm)

- Ràng buÙc trong PostgreSQL: https://www.postgresql.org/docs/current/ddl- constraints.html [URL 🔗](https://www.postgresql.org/docs/current/ddl-constraints.html)

- ChÉ måc và tÑi °u truy v¥n: https://use-the-index-luke.com/ [URL 🔗](https://use-the-index-luke.com/)

7. Đồ án 7. CSDL thương mại điện tử và lập trình SQL nâng cao

## 7. Đồ án 7. CSDL thương mại điện tử và lập trình SQL nâng cao

Bài toán: Một sàn thương mại điện tử có khách hàng, người bán, sản phẩm với nhiều biến thể (màu, size), danh mục phân cấp nhiều tầng, giỏ hàng, đơn hàng, khuyến mãi, đánh giá và kho hàng.

## Yêu cầu chính:


- Thi¿t k¿ và chu©n hóa CSDL, tóm t¯t ng¯n gÍn các b°Ûc thi¿t k¿.

- Truy v¥n con và truy v¥n k¿t gÙp: vi¿t ít nh¥t 20 truy v¥n phéc t¡p, gÓm truy v¥n con tương quan, EXISTS/NOT EXISTS, phép chia (ví dụ khách hàng đã mua tất cả sản phẩm của một thương hiệu), GROUP BY/HAVING, OUTER JOIN và hàm cửa sổ. So sánh các cách viết khác nhau cho cùng một yêu cầu bằng EXPLAIN ANALYZE.

- Ràng buÙc: dùng CHECK, ràng buÙc toàn v¹n phéc t¡p cài -·t b±ng TRIGGER (ví då không bán vượt tồn kho), và ASSERTION ở mức lý thuyết.

- Thç tåc và hàm: -·t hàng, tính khuy¿n mãi, x¿p h¡ng ng°Ýi bán.

- SQL Ùng: Injection và cách phòng tránh. chéc nng tìm ki¿m s£n ph©m vÛi bÙ lÍc tùy chÍn. Phân tích nguy c¡ SQL

- SQL nhúng: con trỏ (cursor). mÙt ch°¡ng trình nhÏ b±ng C (ECPG), Java (JDBC) ho·c Python có dùng

- Ç quy SQL: nhánh danh mục. duyÇt cây danh måc b±ng WITH RECURSIVE, tính tÕng doanh thu theo

## Các bước nghiên cứu gợi ý:

- 1. Khảo sát mô hình dữ liệu của một vài sàn thương mại điện tử, thiết kế lược đồ.

- 2. Sinh dữ liệu mẫu lớn (100.000 đơn hàng trở lên) bằng Python Faker hoặc generate_series.

- 3. Viết truy vấn theo nhóm kỹ thuật. Mỗi truy vấn cần có phát biểu nghiệp vụ, câu SQL, kết quả và phân tích kế hoạch thực thi.

- 4. Cài đặt trigger, thủ tục và hàm, kèm test case cho cả trường hợp hợp lệ và vi phạm.

- 5. Viết chương trình SQL nhúng và SQL động, sau đó đánh giá hiệu năng và bảo mật.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 7 (SQL nâng cao, trigger, view), ch°¡ng 10 (l­p trình CSDL: SQL nhúng, SQL động, thủ tục lưu trữ).

- Silberschatz, ch°¡ng 5 (Advanced SQL).

- Truy v¥n -Ç quy WITH RECURSIVE: https://www.postgresql.org/docs/current/queries- with.html [URL 🔗](https://www.postgresql.org/docs/current/queries-with.html)

- [PL/pgSQL: https://www.postgresql.org/docs/current/plpgsql.html](https://www.postgresql.org/docs/current/plpgsql.html)

- [Trigger: https://www.postgresql.org/docs/current/triggers.html](https://www.postgresql.org/docs/current/triggers.html)

- ECPG (SQL nhúng trong C): https://www.postgresql.org/docs/current/ecpg.html [URL 🔗](https://www.postgresql.org/docs/current/ecpg.html)

- [EXPLAIN: https://www.postgresql.org/docs/current/using-explain.html](https://www.postgresql.org/docs/current/using-explain.html)

- Phòng chÑng SQL Injection (OWASP): https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.h tml [URL 🔗](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)


- 8. Đồ án 8. Transaction và điều khiển đồng thời trong hệ thống đặt vé hoặc ngân hàng

- 8. Đồ án 8. Transaction và điều khiển đồng thời trong hệ thống đặt vé hoặc ngân hàng

Bài toán: Hệ thống đặt vé máy bay hoặc xem phim, trong đó nhiều người dùng tranh chấp cùng một ghế. Có thể chọn thay bằng hệ thống chuyển khoản ngân hàng.

## Yêu cầu chính:

- Thi¿t k¿ CSDL cho bài toán —ã chÍn.

- Trình bày lý thuy¿t transaction: các tr¡ng thái, tính ch¥t ACID, lËch thao tác (schedule), tính khả tuần tự (serializability), khóa hai pha (2PL), deadlock, MVCC và khôi phục dữ liệu bằng log.

- Thñc nghiÇm: tái hiÇn các b¥t th°Ýng dirty read, non-repeatable read, phantom, lost update và write skew ở từng mức cô lập (READ COMMITTED, REPEATABLE READ, SERIALIZABLE) trên PostgreSQL và MySQL, rồi lập bảng so sánh.

- Vi¿t ch°¡ng trình mô phÏng kho£ng 100 ng°Ýi dùng Óng thÝi cùng ·t vé. o t÷ lÇ l×i, số lần deadlock và thông lượng với các chiến lược khác nhau (SELECT … FOR UPDATE, khóa lạc quan bằng cột version, mức SERIALIZABLE kết hợp thử lại).

- Minh hÍa quá trình phåc hÓi: rollback, savepoint, và sñ cÑ giïa chëng giao dËch.

## Các bước nghiên cứu gợi ý:

- 1. Đọc lý thuyết về transaction và điều khiển đồng thời, tóm tắt thành chương cơ sở lý thuyết.

- 2. Thiết kế CSDL và viết thủ tục đặt vé hoặc chuyển tiền.

- 3. Mở hai hoặc ba phiên làm việc song song trong psql hoặc MySQL để tái hiện từng bất thường. Ghi lại từng bước kèm ảnh chụp màn hình.

- 4. Viết chương trình đa luồng (Python, Java hoặc Go) để kiểm thử tải.

- 5. Phân tích kết quả và đề xuất chiến lược phù hợp cho từng tình huống nghiệp vụ.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 2022 (xí lý giao dËch, iÁu khiÃn Óng thÝi, phåc hÓi).

- Silberschatz, ch°¡ng 17219.

- Méc cô l­p trong PostgreSQL: https://www.postgresql.org/docs/current/transaction- iso.html [URL 🔗](https://www.postgresql.org/docs/current/transaction-iso.html)

- Méc cô l­p trong MySQL InnoDB: https://dev.mysql.com/doc/refman/8.0/en/innodb- transaction-isolation-levels.html [URL 🔗](https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html)

- Berenson et al., A Critique of ANSI SQL Isolation Levels: https://www.microsoft.com/en- us/research/publication/a-critique-of-ansi-sql-isolation-levels/ [URL 🔗](https://www.microsoft.com/en-us/research/publication/a-critique-of-ansi-sql-isolation-levels/)


- Hermitage, bÙ thí nghiÇm méc cô l­p cça nhiÁu hÇ qu£n trË CSDL: https://github.com/ept/hermitage [URL 🔗](https://github.com/ept/hermitage)

- Ports & Grittner, Serializable Snapshot Isolation in PostgreSQL (VLDB 2012): https://drkp.net/papers/ssi-vldb12.pdf [URL 🔗](https://drkp.net/papers/ssi-vldb12.pdf)

- Jepsen, các mô hình nh¥t quán: https://jepsen.io/consistency [URL 🔗](https://jepsen.io/consistency)

9. Đồ án 9. Thiết kế CSDL hướng đối tượng cho hệ thống bảo tàng hoặc thư viện số

- 9. Đồ án 9. Thiết kế CSDL hướng đối tượng cho hệ thống bảo tàng hoặc thư viện số

Bài toán: Hệ thống quản lý hiện vật và tài liệu số. Mỗi đối tượng có cấu trúc phức tạp: hiện vật gồm nhiều thành phần, có tác giả, niên đại, nhiều ảnh và video, và nằm trong phân cấp lớp như Hiện vật → Tranh, Tượng, Tài liệu cổ.

## Yêu cầu chính:

- Mô hình hóa b±ng UML Class Diagram và –·c t£ l°ãc –Ó theo chu©n ODMG (ODL). Lược đồ cần có lớp, thuộc tính, phương thức, kiểu tập hợp (set, bag, list, array), mối quan hệ nghịch đảo (inverse relationship), thừa kế và extent.

- Vi¿t 1015 truy v¥n OQL và biÃu diÅn mÙt sÑ truy v¥n b±ng ¡i sÑ Ñi t°ãng.

- Cài ·t, chÍn mÙt trong các cách sau:

- o Mô hình đối tượng – quan hệ trên PostgreSQL (CREATE TYPE, kế thừa bảng, mảng, JSONB) hoặc Oracle Object Types.

- o Hệ quản trị CSDL hướng đối tượng như ObjectDB (JPA/JDO) hoặc ZODB (Python).

- So sánh cùng bài toán giïa thi¿t k¿ quan hÇ thu§n và thi¿t k¿ h°Ûng Ñi t°ãng vÁ Ù phéc tạp lược đồ, truy vấn, hiệu năng và vấn đề lệch pha trở kháng (impedance mismatch).

## Các bước nghiên cứu gợi ý:

- 1. Nghiên cứu mô hình đối tượng ODMG: định danh đối tượng (OID), kiểu, lớp, thừa kế.

- 2. Thiết kế sơ đồ lớp và viết lược đồ ODL.

- 3. Viết truy vấn OQL trên giấy, sau đó chuyển sang cú pháp của hệ thống cài đặt (JPQL cho ObjectDB, SQL đối tượng – quan hệ cho PostgreSQL hoặc Oracle).

- 4. Cài đặt, nạp dữ liệu và chạy truy vấn.

- 5. Làm song song một phiên bản quan hệ để so sánh và đánh giá.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 12 (CSDL Ñi t°ãng và Ñi t°ãng  quan hÇ, ODMG, ODL, OQL).

- Connolly & Begg, các ch°¡ng vÁ CSDL h°Ûng Ñi t°ãng và Ñi t°ãng  quan hÇ.

- Silberschatz, ch°¡ng 8 (Complex Data Types).


- Atkinson et al., The Object-Oriented Database System Manifesto (1989). Có thÃ tìm tên bài trên Google Scholar.

- K¿ thëa b£ng trong PostgreSQL: https://www.postgresql.org/docs/current/ddl- inherit.html [URL 🔗](https://www.postgresql.org/docs/current/ddl-inherit.html)

- KiÃu phéc hãp trong PostgreSQL: https://www.postgresql.org/docs/current/rowtypes.html [URL 🔗](https://www.postgresql.org/docs/current/rowtypes.html)

- ObjectDB (JPA): https://www.objectdb.com/ [URL 🔗](https://www.objectdb.com/)

- ZODB (Python): https://zodb.org/ [URL 🔗](https://zodb.org/)

- Oracle Object-Relational Developer's Guide: https://docs.oracle.com/en/database/oracle/oracle-database/19/adobj/ [URL 🔗](https://docs.oracle.com/en/database/oracle/oracle-database/19/adobj/)

10. Đồ án 10. Xây dựng công cụ hỗ trợ phân tích phụ thuộc hàm và chuẩn hóa, áp dụng cho CSDL quản lý đào tạo

## 10. Đồ án 10. Xây dựng công cụ hỗ trợ phân tích phụ thuộc hàm và chuẩn hóa, áp dụng cho CSDL quản lý đào tạo

Bài toán: Xây dựng phần mềm (web hoặc desktop) nhận đầu vào là lược đồ quan hệ và tập phụ thuộc hàm, sau đó tự động tính toán các kết quả của lý thuyết thiết kế CSDL. Nhóm dùng chính công cụ này để thiết kế CSDL quản lý đào tạo của một trường đại học (sinh viên, học phần, lớp học phần, đăng ký, điểm, giảng viên, phòng học).

## Chức năng tối thiểu của công cụ:

- Tính bao óng cça t­p thuÙc tính và kiÃm tra mÙt phå thuÙc hàm có °ãc suy ra të t­p ã cho hay không.

- KiÃm tra hai t­p phå thuÙc hàm có t°¡ng -°¡ng không, và tìm phç tÑi tiÃu.

- Tìm t¥t c£ khóa và siêu khóa (thu­t toán dña trên t­p thuÙc tính nguÓn, -ích và trung gian).

- Xác ‑Ënh d¡ng chu©n cao nh¥t cça l°ãc ‑Ó (1NF, 2NF, 3NF, BCNF).

- Phân rã vÁ 3NF b±ng thu­t toán tÕng hãp (b£o toàn phå thuÙc và thông tin) và vÁ BCNF, kèm kiểm tra lossless join bằng phương pháp bảng (chase).

- HiÃn thË tëng b°Ûc gi£i ‒Ã dùng nh° công cå hÍc t­p.

## Các bước nghiên cứu gợi ý:

- 1. Tổng hợp lý thuyết: hệ tiên đề Armstrong, các thuật toán bao đóng, phủ tối tiểu, tìm khóa, phân rã. Viết mã giả cho từng thuật toán.

- 2. Phân tích độ phức tạp, đặc biệt là bài toán tìm tất cả khóa có độ phức tạp hàm mũ, và đề xuất cách tối ưu.

- 3. Lập trình bằng Python, Java hoặc JavaScript, có giao diện nhập liệu và kiểm thử đơn vị bằng các bài tập trong giáo trình.

- 4. Áp dụng công cụ vào bài toán quản lý đào tạo: thu thập phụ thuộc hàm từ quy chế đào tạo, chuẩn hóa, cài đặt CSDL và viết truy vấn.


- 5. Đánh giá độ chính xác bằng cách so sánh với lời giải tay, và đánh giá thời gian chạy khi số thuộc tính tăng.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 14 (c¡ sß lý thuy¿t cça phå thuÙc hàm và chu©n hóa) và chương 15 (các thuật toán thiết kế quan hệ, phụ thuộc đa trị, 4NF).

- Silberschatz, ch°¡ng 7 (Relational Database Design).

- E.F. Codd (1970), A Relational Model of Data for Large Shared Data Banks: https://dl.acm.org/doi/10.1145/362384.362685 [URL 🔗](https://dl.acm.org/doi/10.1145/362384.362685)

- W. Kent, A Simple Guide to Five Normal Forms: https://www.bkent.net/Doc/simple5.htm [URL 🔗](https://www.bkent.net/Doc/simple5.htm)

- Bài gi£ng CMU 15-445 vÁ Normal Forms/Database Design: https://15445.courses.cs.cmu.edu/ [URL 🔗](https://15445.courses.cs.cmu.edu/)

## 11. Đồ án 11: Thiết kế CSDL quản lý đề tài nghiên cứu khoa học và quá trình nghiệm thu

## 11. Đồ án 11: Thiết kế CSDL quản lý đề tài nghiên cứu khoa học và quá trình nghiệm thu

Mục tiêu: Xây dựng CSDL quản lý vòng đời đề tài từ đăng ký, xét duyệt, triển khai đến nghiệm thu; bảo đảm nhất quán giữa thành viên, nhiệm vụ, sản phẩm và kết quả đánh giá.

Câu hỏi nghiên cứu: Làm thế nào biểu diễn một người tham gia nhiều vai trò và kiểm soát các ràng buộc liên quan đến nhiều bảng?

Phạm vi dữ liệu: Nhà nghiên cứu, đơn vị, đề tài, thành viên, nhiệm vụ, mốc tiến độ, sản phẩm khoa học, hội đồng và phiếu đánh giá.

## Các bước gợi ý nghiên cứu

- 1. Phân tích nghiệp vụ và giả định. Xác định vai trò chủ nhiệm, thành viên, phản biện; quy định điều kiện nghiệm thu và các trường hợp xung đột vai trò. Những quy tắc này cần được nêu rõ trong đặc tả.

- 2. Thiết kế EER. Mô hình hóa sản phẩm khoa học thành bài báo, phần mềm, báo cáo chuyên đề. Biểu diễn vai trò của một người theo từng đề tài hoặc hội đồng, tránh coi vai trò luôn là thuộc tính cố định của người.

- 3. Phân tích phụ thuộc hàm và chuẩn hóa. Xuất phát từ bảng tổng hợp đề tài–thành viên– sản phẩm; tìm khóa, phủ tối tiểu và phân rã về 3NF/BCNF.

- 4. Xây dựng SQL nâng cao. Truy vấn đề tài trễ hạn, thành viên tham gia nhiều đề tài, đề tài hoàn thành đủ sản phẩm; dùng SQL đệ quy để tổng hợp theo cây đơn vị hoặc nhiệm vụ.


- 5. Hiện thực ràng buộc và transaction. Thiết kế giao dịch nghiệm thu gồm ghi nhận đánh giá, kết luận và cập nhật trạng thái. Kiểm thử hai người cùng sửa kết quả hoặc cập nhật tiến độ trong lúc nghiệm thu.

- 6. Thiết kế mô hình đối tượng và đánh giá. Xây dựng các lớp DeTai, NhiemVu, SanPhamKhoaHoc và các lớp con; viết OQL truy xuất sản phẩm, thành viên và nhiệm vụ chưa hoàn thành.

Sản phẩm nghiên cứu cần trình bày: EER, phân tích chuẩn hóa, bảng đối chiếu quy tắc nghiệp vụ với cơ chế thực thi, và kịch bản chứng minh không thể nghiệm thu một đề tài chưa đủ điều kiện theo đặc tả.

## Tài liệu tham khảo

- Database System Concepts  bài gi£ng chính théc: Íc Ch°¡ng 67 vÁ thi¿t k¿ dï liÇu và Chương 17–18 về transaction, kiểm soát đồng thời. slides [URL 🔗](https://www.db-book.com/slides-dir/?utm_source=chatgpt.com)

- PostgreSQL ‒ Constraints: nghiên céu khóa, ràng buÙc duy nh¥t, khóa ngo¡i và giÛi h¡n của CHECK đối với dữ liệu ngoài dòng hiện tại. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/ddl-constraints.html?utm_source=chatgpt.com)

12. Đồ án 12: Thiết kế CSDL ngân hàng câu hỏi và tổ chức thi trực tuyến có quản lý phiên bản

## 12. Đồ án 12: Thiết kế CSDL ngân hàng câu hỏi và tổ chức thi trực tuyến có quản lý phiên bản

Mục tiêu: Quản lý nhiều loại câu hỏi, tạo đề thi, lưu bài làm và bảo đảm kết quả thi có thể kiểm tra lại sau khi ngân hàng câu hỏi được chỉnh sửa.

Câu hỏi nghiên cứu:

thời xử lý đúng các yêu cầu lưu bài/nộp bài xảy ra đồng thời?

Phạm vi dữ liệu: Môn học, chủ đề, câu hỏi, phiên bản câu hỏi, phương án trả lời, đề thi, câu hỏi trong đề, lượt thi, bài làm và kết quả chấm.

Làm thế nào bảo toàn nội dung đề và quy tắc chấm tại thời điểm thi, đồng

## Các bước gợi ý nghiên cứu

- 1. Đặc tả các loại câu hỏi. Chọn phạm vi vừa phải: một đáp án, nhiều đáp án và tự luận. Làm rõ cách tính điểm, số lần thi và trạng thái bài làm.

- 2. Thiết kế EER và mô hình đối tượng. Xây dựng lớp cha CauHoi và các lớp con; mô tả thuộc tính, phương thức chấm điểm phù hợp với từng loại. Tự luận có thể chấm thủ công.

- 3. Nghiên cứu quản lý phiên bản. So sánh hai cách: đề thi tham chiếu phiên bản câu hỏi bất biến, hoặc lưu bản chụp nội dung. Đánh giá khả năng truy vết, dư thừa và độ phức tạp cập nhật.


- 4. Chuẩn hóa và xây dựng SQL. Phân tích khóa của phiên bản, lượt thi và câu trả lời; viết truy vấn thống kê tỷ lệ trả lời đúng, phân bố điểm và lựa chọn câu hỏi theo chủ đề/mức độ.

- 5. Thiết kế transaction nộp bài. Gộp việc chốt câu trả lời, chuyển trạng thái và ghi kết quả trong một giao dịch. Kiểm thử yêu cầu nộp lặp, hai cửa sổ cùng nộp và lưu tự động cạnh tranh với nộp bài.

- 6. Thực nghiệm và OQL. Sửa câu hỏi sau một kỳ thi rồi kiểm tra khả năng tái hiện đề cũ; viết OQL truy vấn câu hỏi theo lớp con và bài làm theo lượt thi.

Sản phẩm nghiên cứu cần trình bày: Cơ chế tái hiện chính xác đề đã thi; minh chứng bài đã nộp không bị lưu tự động ghi đè; một lượt thi không bị chấm hoặc ghi nhận kết quả trùng.

## Tài liệu tham khảo

- Database System Concepts  Object-Based Databases: tham kh£o mô hình Ñi t°ãng, k¿ thừa và dữ liệu phức hợp. db-book.com [URL 🔗](https://www.db-book.com/slides-dir/PDF-dir/ch29.pdf?utm_source=chatgpt.com)

- PostgreSQL  Transaction Isolation: nghiên céu tính cô l­p khi l°u bài và nÙp bài Óng thời. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/transaction-iso.html?utm_source=chatgpt.com)

- PostgreSQL - PL/pgSQL Basic Statements: tham kh£o xây dñng xí lý nghiÇp vå và SQL động. postgresql.org [URL 🔗](https://www.postgresql.org/docs/18/plpgsql-statements.html?utm_source=chatgpt.com)

13. Đồ án 13: Thiết kế CSDL theo dõi vận chuyển và bàn giao bưu kiện

## 13. Đồ án 13: Thiết kế CSDL theo dõi vận chuyển và bàn giao bưu kiện

Mục tiêu:

định trạng thái hiện tại nhất quán.

Câu hỏi nghiên cứu: Nên tính trạng thái hiện tại từ lịch sử hay lưu riêng? Làm thế nào xử lý sự kiện gửi trùng, đến muộn và cập nhật đồng thời?

Phạm vi dữ liệu: Bưu kiện, người gửi/nhận, bưu cục, điểm trung chuyển, tuyến, chuyến vận chuyển, nhân viên, lần bàn giao và sự kiện trạng thái.

Quản lý hành trình bưu kiện qua các điểm trung chuyển, lưu lịch sử bàn giao và xác

## Các bước gợi ý nghiên cứu

- 1. Xác định vòng đời bưu kiện. Mô tả các trạng thái như tiếp nhận, trung chuyển, đang giao, giao thành công, hoàn trả; lập bảng chuyển trạng thái hợp lệ.

- 2. Thiết kế EER và chuẩn hóa. Phân biệt bưu kiện, chuyến vận chuyển và lần bàn giao; quy định định danh duy nhất cho sự kiện.

- 3. Thiết kế lịch sử dữ liệu. Lưu riêng thời điểm sự kiện xảy ra và thời điểm hệ thống nhận sự kiện. So sánh phương án suy ra trạng thái từ lịch sử với phương án lưu thêm trạng thái hiện tại.


- 4. Xây dựng SQL nâng cao. Truy vấn hành trình, thời gian lưu tại từng điểm, bưu kiện chậm và tỷ lệ giao thành công. Dùng SQL đệ quy tìm các điểm có thể đến trong mạng tuyến nhỏ.

- 5. Thiết kế transaction bàn giao. Ghi nhận bàn giao và cập nhật trạng thái nguyên tử; kiểm thử hai nhân viên đồng thời bàn giao cùng bưu kiện và việc nhận lại cùng một sự kiện.

- 6. Thực nghiệm và mô hình đối tượng. Sinh các luồng sự kiện đúng thứ tự, đến muộn, gửi trùng; kiểm tra kết quả cuối. Thiết kế lớp SuKienVanChuyen với các lớp con và truy vấn OQL tương ứng.

Sản phẩm nghiên cứu cần trình bày: Lịch sử hành trình có thể truy vết; quy tắc xử lý sự kiện đến muộn; kết quả so sánh hai cách tổ chức trạng thái trên cùng bộ dữ liệu.

## Tài liệu tham khảo

- PostgreSQL — WITH và Recursive Queries: tham kh£o truy v¥n quan hÇ nhiÁu c¥p và phát hiện chu trình. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/queries-with.html?utm_source=chatgpt.com)

- PostgreSQL - Transaction Isolation: nghiên céu các c­p nh­t c¡nh tranh. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/transaction-iso.html?utm_source=chatgpt.com)

- PostgreSQL  Using EXPLAIN: ánh giá truy v¥n lËch sí và tác Ùng cça chÉ måc. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/using-explain.html?utm_source=chatgpt.com)

14. Đồ án 14: Thiết kế CSDL hồ sơ khám bệnh và kết quả xét nghiệm có lịch sử chỉnh sửa

## 14. Đồ án 14: Thiết kế CSDL hồ sơ khám bệnh và kết quả xét nghiệm có lịch sử chỉnh sửa

Mục tiêu: Quản lý thông tin các lần khám, chỉ định và kết quả xét nghiệm; biểu diễn nhiều loại kết quả và truy vết thay đổi. Sử dụng dữ liệu giả lập cho đồ án.

Câu hỏi nghiên cứu: Làm thế nào thiết kế dữ liệu vừa hỗ trợ nhiều kiểu kết quả xét nghiệm, vừa kiểm soát được kiểu dữ liệu và bảo toàn lịch sử chỉnh sửa?

Phạm vi dữ liệu: Người bệnh, nhân viên y tế, khoa, lần khám, chỉ định, loại xét nghiệm, kết quả và phiên bản chỉnh sửa. Giới hạn ở quản lý dữ liệu, không xây dựng chức năng tư vấn chẩn đoán.

## Các bước gợi ý nghiên cứu

- 1. Khảo sát cấu trúc thông tin. Phân biệt hồ sơ người bệnh, lần khám, chỉ định và kết quả. Chọn một số dạng kết quả: số, văn bản và tham chiếu tệp.

- 2. Thiết kế EER. Mô hình hóa KetQuaXetNghiem và các lớp con; xác định quy tắc bắt buộc về kiểu giá trị, đơn vị và liên kết với chỉ định.


- 3. So sánh cách lưu dữ liệu. Đánh giá bảng chuyên biệt theo loại kết quả với mô hình thực thể–thuộc tính–giá trị (EAV). So sánh khả năng áp dụng ràng buộc, mở rộng và độ phức tạp truy vấn.

- 4. Chuẩn hóa và viết SQL. Truy vấn lịch sử khám, kết quả mới nhất đã xác nhận, chỉ định chưa có kết quả và thống kê theo khoa/thời gian.

- 5. Thiết kế transaction và phiên bản. Thực hiện việc thêm phiên bản kết quả, ghi người sửa/lý do và cập nhật trạng thái xác nhận trong một giao dịch; kiểm thử hai người cùng chỉnh sửa.

- 6. Thiết kế đối tượng và thực nghiệm. Viết OQL trên các lớp kết quả; thử thêm một loại xét nghiệm mới để đánh giá mức thay đổi lược đồ và truy vấn.

Sản phẩm nghiên cứu cần trình bày: Bảng so sánh các cách biểu diễn kết quả; khả năng xem lại phiên bản cũ; minh chứng cập nhật đồng thời không âm thầm làm mất thay đổi.

## Tài liệu tham khảo

- Database System Concepts – bÙ bài gi£ng: –Íc Ch°¡ng 7 vÁ thi¿t k¿ quan hÇ, Ch°¡ng 8 về kiểu dữ liệu phức hợp và Chương 29 về CSDL đối tượng. slides [URL 🔗](https://www.db-book.com/slides-dir/?utm_source=chatgpt.com)

- PostgreSQL ‐ Constraints: tham kh£o kiÃm soát miÁn giá trË và liên k¿t giïa các b£ng. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/ddl-constraints.html?utm_source=chatgpt.com)

- PostgreSQL  Transaction Isolation: phåc vå thñc nghiÇm chÉnh sía Óng thÝi. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/transaction-iso.html?utm_source=chatgpt.com)

15. Đồ án 15: Thiết kế CSDL mạng cộng tác và thảo luận học thuật

## 15. Đồ án 15: Thiết kế CSDL mạng cộng tác và thảo luận học thuật

Mục tiêu: Quản lý nhóm học thuật, quan hệ theo dõi, bài đăng và chuỗi bình luận; nghiên cứu truy vấn dữ liệu có cấu trúc mạng bằng SQL.

Câu hỏi nghiên cứu: CSDL quan hệ đáp ứng thế nào đối với truy vấn quan hệ nhiều bước và bình luận nhiều cấp khi dữ liệu tăng?

Phạm vi dữ liệu: Người dùng, nhóm, thành viên nhóm, quan hệ theo dõi, bài đăng, chủ đề, bình luận và tương tác.

## Các bước gợi ý nghiên cứu

- 1. Đặc tả ngữ nghĩa quan hệ. Phân biệt theo dõi có hướng với kết bạn hai chiều; xác định nhóm công khai/riêng tư và phạm vi hiển thị bài đăng.

- 2. Thiết kế EER và chuẩn hóa. Biểu diễn quan hệ nhiều–nhiều, bình luận tự liên kết và các loại bài đăng. Phân tích 4NF khi có các tập thuộc tính đa trị độc lập theo nghiệp vụ.


- 3. Xây dựng truy vấn đệ quy. Tìm người liên quan trong tối đa hai hoặc ba bước; truy xuất cây bình luận; giới hạn độ sâu và xử lý chu trình.

- 4. Xây dựng SQL nâng cao. Tìm người có nhiều nhóm chung, xếp hạng bài theo tương tác và tổng hợp hoạt động. So sánh các cách viết bằng truy vấn con, phép nối và CTE.

- 5. Thiết kế transaction. Kiểm thử hai yêu cầu cùng tạo quan hệ theo dõi hoặc tương tác; bảo đảm không ghi trùng. Nếu lưu bộ đếm tương tác, kiểm chứng tính nhất quán giữa bộ đếm và dữ liệu chi tiết.

- 6. Đo hiệu năng và thiết kế đối tượng. Tăng quy mô người dùng/quan hệ, so sánh trước và sau khi thêm chỉ mục; mô hình hóa BaiDang, các lớp con và BinhLuan, kèm truy vấn OQL.

Sản phẩm nghiên cứu cần trình bày: Truy vấn nhiều bước trả đúng kết quả trên dữ liệu kiểm chứng; bảng đo thời gian theo quy mô và độ sâu; giải thích kế hoạch thực thi của các truy vấn chính.

## Tài liệu tham khảo

- PostgreSQL - Recursive Queries: nghiên céu duyÇt dï liÇu d¡ng cây/m¡ng và xí lý chu trình. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/queries-with.html?utm_source=chatgpt.com)

- PostgreSQL ‐ Using EXPLAIN: phân tích hiÇu qu£ phép nÑi, truy v¥n và chÉ måc. postgresql.org [URL 🔗](https://www.postgresql.org/docs/current/using-explain.html?utm_source=chatgpt.com)

- Database System Concepts - bài gi£ng: tham kh£o thi¿t k¿ quan hÇ, SQL nâng cao và tÑi ưu truy vấn. slides [URL 🔗](https://www.db-book.com/slides-dir/?utm_source=chatgpt.com)

16. Đồ án 16. Thiết kế vật lý và tối ưu hiệu năng CSDL cho hệ thống giao vận (logistics)

## 16. Đồ án 16. Thiết kế vật lý và tối ưu hiệu năng CSDL cho hệ thống giao vận (logistics)

Bài toán: Một công ty giao vận quản lý kho, bưu cục, tuyến vận chuyển, đơn gửi, lịch sử trạng thái đơn và shipper. Bảng lịch sử trạng thái tăng hàng triệu dòng mỗi tháng, và các truy vấn tra cứu hoặc thống kê bắt đầu chậm.

## Yêu cầu chính:

- Thi¿t k¿ CSDL méc quan niÇm và logic, trình bày ng¯n gÍn.

- Xác ‑Ënh t£i công viÇc (workload): liÇt kê 15120 truy v¥n và thao tác c­p nh­t quan trÍng, ước lượng tần suất của từng thao tác.

- Thi¿t k¿ méc v­t lý:

- o Chọn loại chỉ mục (B-tree, hash, chỉ mục phức hợp, chỉ mục bao phủ, chỉ mục một phần) cho từng truy vấn.

- o Phân vùng bảng (partitioning) theo thời gian hoặc theo khu vực.


- o Phi chuẩn hóa có kiểm soát và materialized view cho báo cáo.

- Sinh kho£ng 510 triÇu b£n ghi. o thÝi gian thñc thi tr°Ûc và sau tÑi °u, phân tích k¿ hoạch thực thi bằng EXPLAIN ANALYZE.

- ánh giá m·t trái cça chÉ måc: chi phí khi INSERT/UPDATE và dung l°ãng l°u trï.

- Mß rÙng (không b¯t buÙc): ch¡y thêm bÙ benchmark TPC-H ß quy mô nhÏ -Ã so sánh.

## Các bước nghiên cứu gợi ý:

- 1. Nghiên cứu cấu trúc lưu trữ, cấu trúc chỉ mục và nguyên lý hoạt động của bộ tối ưu truy vấn.

- 2. Thiết kế lược đồ, viết script sinh dữ liệu lớn.

- 3. Chạy toàn bộ workload khi chưa có tối ưu và ghi nhận số liệu nền (baseline).

- 4. Áp dụng từng kỹ thuật tối ưu một, đo lại và lập bảng so sánh.

- 5. Rút ra quy tắc chọn chỉ mục và phân vùng cho bài toán, rồi viết báo cáo.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 16119 (l°u trï, chÉ måc, xí lý và tÑi °u truy v¥n).

- Silberschatz, ch°¡ng 13216.

- Connolly & Begg, ch°¡ng 18 (ph°¡ng pháp thi¿t k¿ CSDL v­t lý). [URL 🔗](https://www.postgresql.org/docs/current/indexes.html)

- ChÉ måc trong PostgreSQL: https://www.postgresql.org/docs/current/indexes.html [URL 🔗](https://www.postgresql.org/docs/current/ddl-partitioning.html)

- Phân vùng b£ng: https://www.postgresql.org/docs/current/ddl-partitioning.html

- M¹o hiÇu n ng và EXPLAIN: tips.html [URL 🔗](https://www.postgresql.org/docs/current/performance-tips.html)

- Materialized view: Use The Index, Luke: https://use-the-index-luke.com/ [URL 🔗](https://www.postgresql.org/docs/current/rules-materializedviews.html)

- BÙ benchmark TPC-H: https://www.tpc.org/tpch/ [URL 🔗](https://www.tpc.org/tpch/)

17. Đồ án 17. Dữ liệu phân cấp và dữ liệu đồ thị trong CSDL quan hệ: ứng dụng mạng xã hội học tập

17. Đồ án 17. Dữ liệu phân cấp và dữ liệu đồ thị trong CSDL quan hệ: ứng dụng mạng xã hội học tập

Bài toán: Mạng xã hội cho sinh viên có quan hệ bạn bè và theo dõi, nhóm học tập, bài viết, bình luận lồng nhau nhiều cấp, và cây thư mục tài liệu.

- [https://www.postgresql.org/docs/current/rules-materializedviews.html](https://www.postgresql.org/docs/current/rules-materializedviews.html)

## Yêu cầu chính:

- Nghiên céu và cài ‐·t 4 cách l°u dï liÇu cây trong CSDL quan hÇ:

- o danh sách kề (adjacency list);

- o đường dẫn (path enumeration, hoặc kiểu ltree của PostgreSQL);

- o tập lồng nhau (nested set);

- o bảng bao đóng (closure table).

- So sánh 4 cách trên vÁ Ù phéc t¡p truy v¥n, chi phí c­p nh­t và hiÇu nng.


- Dùng SQL —Ç quy (WITH RECURSIVE) cho các bài toán —Ó thË:

- o bạn của bạn đến cấp k;

- o đường đi ngắn nhất giữa hai người dùng;

- o phát hiện chu trình;

- o gợi ý kết bạn dựa trên số bạn chung.

- So sánh vÛi cách gi£i cùng bài toán trên CSDL –Ó thË Neo4j b±ng ngôn ngï Cypher.

- Dùng dï liÇu m¡ng xã hÙi th­t të bÙ SNAP (Stanford) ho·c dï liÇu tñ sinh.

## Các bước nghiên cứu gợi ý:

- 1. Tìm hiểu cơ chế thực thi truy vấn đệ quy (phần neo, phần đệ quy, điều kiện dừng) và các mô hình lưu cây.

- 2. Thiết kế lược đồ và cài đặt cả 4 mô hình cây cho phần bình luận và thư mục.

- 3. Viết bộ truy vấn chuẩn cho mỗi mô hình (lấy cây con, lấy tổ tiên, di chuyển nhánh, xóa nhánh) và đo hiệu năng.

- 4. Nạp dữ liệu đồ thị, viết truy vấn đệ quy, xử lý chu trình và giới hạn độ sâu.

- 5. Cài đặt lại một số truy vấn trên Neo4j, so sánh và kết luận khi nào nên dùng CSDL quan hệ, khi nào nên dùng CSDL đồ thị.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 7 (truy v¥n phéc t¡p, truy v¥n —Ç quy).

- Silberschatz, ch°¡ng 5 (måc Recursive Queries).

- B. Karwin, SQL Antipatterns, ch°¡ng "Naive Trees", trình bày các mô hình l°u cây.

- [WITH RECURSIVE: https://www.postgresql.org/docs/current/queries-with.html](https://www.postgresql.org/docs/current/queries-with.html)

- [KiÃu ltree: https://www.postgresql.org/docs/current/ltree.html](https://www.postgresql.org/docs/current/ltree.html)

- BÙ dï liÇu m¡ng SNAP: https://snap.stanford.edu/data/ [URL 🔗](https://snap.stanford.edu/data/)

- H°Ûng d«n Neo4j Cypher: https://neo4j.com/docs/cypher-manual/current/ [URL 🔗](https://neo4j.com/docs/cypher-manual/current/)

18. Đồ án 18. Khả năng phục hồi dữ liệu và chiến lược sao lưu cho hệ thống kế toán doanh nghiệp

18. Đồ án 18. Khả năng phục hồi dữ liệu và chiến lược sao lưu cho hệ thống kế toán doanh nghiệp

Bài toán: Hệ thống kế toán gồm chứng từ, bút toán ghi sổ kép, sổ cái, công nợ và báo cáo tài chính. Dữ liệu tuyệt đối không được mất hoặc sai lệch, kể cả khi mất điện, hỏng đĩa hay người dùng lỡ tay xóa dữ liệu.

## Yêu cầu chính:

- Thi¿t k¿ CSDL k¿ toán. Ràng buÙc nh¥t quán quan trÍng nh¥t là tÕng Nã = tÕng Có cça mỗi chứng từ. Nhóm cần cài đặt ràng buộc này bằng transaction kết hợp trigger hoặc deferrable constraint.

- Trình bày lý thuy¿t phåc hÓi:


- o các loại sự cố;

- o nhật ký (log), ghi nhật ký trước (WAL);

- o cập nhật trì hoãn và cập nhật tức thời;

- o điểm kiểm tra (checkpoint);

- o UNDO/REDO;

- o thuật toán ARIES.

- Thñc nghiÇm:

- o Ngắt tiến trình CSDL giữa một giao dịch, khởi động lại và quan sát quá trình phục hồi.

- o Dùng savepoint để hủy một phần giao dịch.

- o Khôi phục về một thời điểm trong quá khứ (PITR) sau khi "lỡ" xóa dữ liệu.

- Xây dñng chi¿n l°ãc sao l°u gÓm sao l°u logic và v­t lý, toàn ph§n và gia t-ng, xác ‐Ënh RPO/RTO. Có thể giới thiệu thêm cơ chế nhân bản (replication).

## Các bước nghiên cứu gợi ý:

- 1. Đọc lý thuyết về trạng thái transaction, tính bền vững và nhất quán, cơ chế log và ARIES.

- 2. Thiết kế CSDL kế toán, cài đặt các ràng buộc cân đối và kiểm thử.

- 3. Cấu hình lưu trữ WAL (WAL archiving) trên PostgreSQL và thực hiện các kịch bản sự cố. Ghi lại từng bước kèm log hệ thống.

- 4. Đo thời gian phục hồi với các kích thước dữ liệu và tần suất checkpoint khác nhau.

- 5. Đề xuất quy trình sao lưu và phục hồi hoàn chỉnh cho doanh nghiệp vừa và nhỏ.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 20 và 22 (xí lý giao dËch, kù thu­t phåc hÓi).

- Silberschatz, ch°¡ng 19 (Recovery System).

- C. Mohan et al. (1992), ARIES: A Transaction Recovery Method&: https://dl.acm.org/doi/10.1145/128765.128770 [URL 🔗](https://dl.acm.org/doi/10.1145/128765.128770)

- WAL trong PostgreSQL: https://www.postgresql.org/docs/current/wal-intro.html [URL 🔗](https://www.postgresql.org/docs/current/wal-intro.html)

- [Sao l°u và phåc hÓi: https://www.postgresql.org/docs/current/backup.html](https://www.postgresql.org/docs/current/backup.html)

- Continuous archiving và PITR: https://www.postgresql.org/docs/current/continuous- archiving.html [URL 🔗](https://www.postgresql.org/docs/current/continuous-archiving.html)

- Công cå sao l°u pgBackRest: https://pgbackrest.org/ [URL 🔗](https://pgbackrest.org/)

19. Đồ án 19. Ánh xạ đối tượng – quan hệ (ORM) cho hệ thống quản lý nhân sự

## 19. Đồ án 19. Ánh xạ đối tượng – quan hệ (ORM) cho hệ thống quản lý nhân sự

Bài toán: Hệ thống quản lý nhân sự có phân cấp lớp như Nhân viên → Chính thức, Hợp đồng, Thực tập, hoặc Người → Nhân viên, Ứng viên. Hệ thống quản lý phòng ban dạng cây, hợp đồng lao động, chấm công, lương và đánh giá. Ứng dụng được viết theo hướng đối tượng và dùng ORM để lưu xuống CSDL quan hệ.


## Yêu cầu chính:

- Thi¿t k¿ mô hình lÛp và mô hình EER t°¡ng éng, phân tích sñ t°¡ng -Óng giïa thëa k¿ lớp và chuyên biệt hóa trong EER.

- Cài –·t và so sánh 3 chi¿n l°ãc ánh x¡ thëa k¿:

- o o một bảng cho cả phân cấp (single table);

- mỗi lớp một bảng, nối bằng khóa (joined);

- o mỗi lớp cụ thể một bảng (table per class).

- Phân tích v¥n Á lÇch pha trß kháng (impedance mismatch) giïa mô hình Ñi t°ãng và mô hình quan hệ, gồm:

- o định danh đối tượng và khóa chính;

- o mối quan hệ hai chiều;

- o tập hợp;

- o nạp trễ và nạp sớm (lazy/eager loading);

- o vấn đề truy vấn N+1.

- Cài –·t b±ng Hibernate/JPA (Java) ho·c SQLAlchemy (Python). So sánh truy v¥n h°Ûng đối tượng (JPQL, HQL hoặc SQLAlchemy ORM) với OQL và với SQL do ORM sinh ra.

- o hiÇu nng cça tëng chi¿n l°ãc ánh x¡ vÛi các truy v¥n a hình, ví då l¥y danh sách mọi nhân viên kèm thông tin riêng của từng loại.

## Các bước nghiên cứu gợi ý:

- 1. Ôn mô hình CSDL hướng đối tượng (lớp, OID, thừa kế) và các mẫu ánh xạ của Fowler.

- 2. Thiết kế sơ đồ lớp, ánh xạ sang lược đồ quan hệ theo từng chiến lược.

- 3. Cài đặt ứng dụng với ORM, bật ghi log SQL để quan sát các câu lệnh ORM sinh ra.

- 4. Tạo và khắc phục vấn đề N+1, so sánh các cách nạp dữ liệu.

- 5. Lập bảng so sánh chiến lược ánh xạ, đối chiếu với cách tiếp cận của CSDL hướng đối tượng thuần túy (Đồ án 4).

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 4 (EER), ch°¡ng 12 (CSDL Ñi t°ãng và Ñi t°ãng  quan hệ).

- Connolly & Begg, các ch°¡ng vÁ CSDL h°Ûng –Ñi t°ãng.

- M. Fowler, Patterns of Enterprise Application Architecture, danh måc m«u (Single Table, Class Table, Concrete Table Inheritance): https://martinfowler.com/eaaCatalog/ [URL 🔗](https://martinfowler.com/eaaCatalog/)

- Tài liÇu Hibernate ORM: https://hibernate.org/orm/documentation/ [URL 🔗](https://hibernate.org/orm/documentation/)

- ·c t£ Jakarta Persistence (JPA): https://jakarta.ee/specifications/persistence/ [URL 🔗](https://jakarta.ee/specifications/persistence/)

- Ánh x¡ thëa k¿ trong SQLAlchemy: https://docs.sqlalchemy.org/en/20/orm/inheritance.html [URL 🔗](https://docs.sqlalchemy.org/en/20/orm/inheritance.html)


## 20. Đồ án 20. Tái thiết kế CSDL từ dữ liệu có sẵn: khám phá phụ thuộc hàm và chuẩn hóa

## 20. Đồ án 20. Tái thiết kế CSDL từ dữ liệu có sẵn: khám phá phụ thuộc hàm và chuẩn hóa

Bài toán: Nhiều đơn vị lưu dữ liệu trong các file Excel hoặc CSV lớn, chưa chuẩn hóa, có trùng lặp và bất thường khi cập nhật. Có thể lấy ví dụ dữ liệu bán hàng của một cửa hàng, dữ liệu tuyển sinh, hoặc một bộ dữ liệu công khai trên Kaggle. Nhiệm vụ của nhóm là khôi phục thiết kế đúng từ chính dữ liệu đó.

## Yêu cầu chính:

- ChÍn mÙt bÙ dï liÇu ph³ng (flat) có të 15 cÙt trß lên và 10.000 dòng trß lên. Phân tích các bất thường khi thêm, xóa và sửa dữ liệu.

- Khám phá phå thuÙc hàm të dï liÇu:

- o viết truy vấn SQL kiểm tra X → Y (GROUP BY X HAVING COUNT(DISTINCT Y) > 1);

- o tìm hiểu thuật toán TANE và dùng công cụ Metanome.

- Phân biÇt phå thuÙc hàm "tình cÝ úng trên dï liÇu" vÛi phå thuÙc hàm "úng theo ngï nghĩa nghiệp vụ", và phân tích vai trò của người thiết kế trong việc chọn lọc.

- Tìm phç tÑi tiÃu và khóa, chu©n hóa —¿n 3NF/BCNF, xét phå thuÙc —a trË và 4NF n¿u có.

- Xây dñng l¡i mô hình EER të l°ãc —Ó —ã chu©n hóa (thi¿t k¿ ng°ãc, reverse engineering).

- Vi¿t script di chuyÃn dï liÇu të b£ng ph³ng sang l°ãc -Ó mÛi, làm s¡ch dï liÇu, và kiÃm tra việc phân rã không làm mất thông tin.

## Các bước nghiên cứu gợi ý:

- 1. Chọn dữ liệu, khảo sát và thống kê mô tả từng cột (data profiling).

- 2. Nghiên cứu bài toán khám phá phụ thuộc hàm và độ phức tạp của nó, chạy thử công cụ.

- 3. Lọc phụ thuộc hàm theo ngữ nghĩa, tiến hành chuẩn hóa theo lý thuyết Chương 4.

- 4. Thiết kế ngược mô hình EER, cài đặt lược đồ mới và di chuyển dữ liệu.

- 5. So sánh lược đồ cũ và mới về dung lượng, mức độ dư thừa và độ phức tạp truy vấn, rồi viết báo cáo.

## Tài liệu tham khảo:

- Elmasri & Navathe, ch°¡ng 14115 (phå thuÙc hàm, chu©n hóa, thu­t toán thi¿t k¿).

- Y. Huhtala et al. (1999), TANE: An Efficient Algorithm for Discovering Functional and Approximate Dependencies: https://doi.org/10.1093/comjnl/42.2.100 [URL 🔗](https://doi.org/10.1093/comjnl/42.2.100)

- T. Papenbrock et al. (2015), Functional Dependency Discovery: An Experimental Evaluation of Seven Algorithms, VLDB: https://www.vldb.org/pvldb/vol8/p1082- papenbrock.pdf [URL 🔗](https://www.vldb.org/pvldb/vol8/p1082-papenbrock.pdf)

- [Công cå Metanome: https://github.com/HPI-Information-Systems/Metanome](https://github.com/HPI-Information-Systems/Metanome)

- NguÓn dï liÇu: https://www.kaggle.com/datasets và https://data.gov/ [URL 🔗](https://www.kaggle.com/datasets)
