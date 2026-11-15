# BÁO CÁO THỰC NGHIỆM OBJECTDB & TRUY VẤN OQL / JPQL (MEMBER 4)

## 1. Mục tiêu và Phạm vi công việc (M4)
- **Thiết kế mô hình lớp ODMG (Object Database Management Group):** Chuyển đổi mô hình thực thể quan hệ (ERD) sang mô hình đối tượng, thể hiện rõ tính kế thừa (`SinhVien` kế thừa `Nguoi`) và các mối liên kết quan hệ đối tượng (`1-N`, `N-1`).
- **Cài đặt cơ sở dữ liệu đối tượng ObjectDB:** Định nghĩa các lớp Entity bằng JPA/ObjectDB và khởi tạo dữ liệu đối tượng vào file CSDL `quanly_dangky.odb`.
- **Hiện thực 5 câu truy vấn OQL / JPQL nâng cao:** Chứng minh ưu điểm của mô hình đối tượng (truy vấn kế thừa, duyệt quan hệ theo đường dẫn không cần JOIN thủ công, hàm kết gộp).
- **Đối chiếu và so sánh với mô hình CSDL quan hệ (RDBMS - PostgreSQL).**

---

## 2. Mô hình lớp đối tượng ODMG
- Sơ đồ lớp chi tiết được lưu trữ tại: `docs/ODMG.png`.
- **Cấu trúc thực thể chính:**
  1. `Nguoi` (Lớp cha): Định nghĩa các thuộc tính chung (`maNguoi`, `hoTen`, `ngaySinh`, `gioiTinh`, `email`, `sdt`).
  2. `SinhVien` (Kế thừa `Nguoi`): Bổ sung các thuộc tính riêng của sinh viên (`maSv`, `maLop`, `namNhapHoc`, `chuyenNganh`, `gpaTichLuy`).
  3. `HocPhan`: Biểu diễn thông tin học phần (`maHp`, `tenHp`, `soTinChi`, `soTietLyThuyet`, `soTietThucHanh`).
  4. `LopHocPhan`: Biểu diễn lớp được mở trong học kỳ (`maLhp`, `tenLhp`, `siSoToiDa`, `siSoHienTai`), có quan hệ tham chiếu `ManyToOne` đến `HocPhan`.
  5. `DangKy`: Biểu diễn việc sinh viên đăng ký lớp học phần (`maDk`, `ngayDangKy`, `trangThai`), lưu tham chiếu trực tiếp đến đối tượng `SinhVien` và `LopHocPhan`.

---

## 3. Chi tiết 5 câu truy vấn OQL / JPQL và Phân tích kỹ thuật

### Câu 1: Truy vấn có điều kiện trên lớp con (Kế thừa)
- **Yêu cầu:** Lấy danh sách sinh viên thuộc chuyên ngành "Công nghệ thông tin".
- **Câu lệnh OQL / JPQL:**
  ```sql
  SELECT s FROM SinhVien s WHERE s.chuyenNganh = :chuyenNganh
  ```
- **Phân tích:** 
  - Truy vấn trực tiếp trên lớp con `SinhVien`, tự động truy cập được các thuộc tính của lớp cha `Nguoi` (`hoTen`, `email`,...) mà không cần phải thực hiện phép nối bảng `JOIN sinh_vien sv ON sv.ma_sv = nguoi.ma_nguoi` như trong SQL quan hệ.
- **Kết quả thực thi:**
  - Tìm thấy 2 sinh viên:
    + `SV001`: Nguyễn Văn An (GPA: 3.6)
    + `SV002`: Trần Thị Bình (GPA: 3.1)

---

### Câu 2: Lọc đối tượng với nhiều điều kiện logic
- **Yêu cầu:** Lọc các học phần có số tín chỉ $\ge 3$ và số tiết lý thuyết $\ge 30$.
- **Câu lệnh OQL / JPQL:**
  ```sql
  SELECT h FROM HocPhan h WHERE h.soTinChi >= :minTC AND h.soTietLyThuyet >= 30
  ```
- **Phân tích:**
  - Xử lý các phép toán so sánh và logic trực tiếp trên trường dữ liệu đối tượng đóng gói.
- **Kết quả thực thi:**
  - Tìm thấy 2 học phần:
    + `CS101`: Cơ sở dữ liệu nâng cao (4 tín chỉ, 45 LT)
    + `CS102`: Lập trình hướng đối tượng (3 tín chỉ, 30 LT)

---

### Câu 3: Điều hướng quan hệ đối tượng theo đường dẫn (Path Navigation)
- **Yêu cầu:** Tìm danh sách các lớp học phần mà sinh viên có mã `SV001` đã đăng ký.
- **Câu lệnh OQL / JPQL:**
  ```sql
  SELECT d.lopHocPhan FROM DangKy d WHERE d.sinhVien.maSv = :maSv
  ```
- **Phân tích ưu việt so với SQL:**
  - Trong SQL quan hệ: Bắt buộc phải viết `SELECT lhp.* FROM dang_ky dk JOIN lop_hoc_phan lhp ON ... JOIN sinh_vien sv ON ... WHERE sv.ma_sv = 'SV001'`.
  - Trong OQL: Sử dụng **Path Expression** (`d.lopHocPhan` và `d.sinhVien.maSv`). ObjectDB tự động giải quyết con trỏ tham chiếu đối tượng (pointer navigation), câu lệnh cực kỳ ngắn gọn và hướng tư duy lập trình viên.
- **Kết quả thực thi:**
  - 1 lớp học phần: `LHP01` - CSDL Nâng cao - Nhóm 1.

---

### Câu 4: Hàm kết gộp trên tập đối tượng
- **Yêu cầu:** Tìm điểm trung bình tích lũy (GPA) cao nhất trong toàn bộ sinh viên.
- **Câu lệnh OQL / JPQL:**
  ```sql
  SELECT MAX(s.gpaTichLuy) FROM SinhVien s
  ```
- **Phân tích:**
  - Thao tác tính toán aggregate trực tiếp trên thuộc tính kiểu thực `float` của tập thực thể `SinhVien`.
- **Kết quả thực thi:**
  - Điểm GPA tích lũy cao nhất: `3.6`.

---

### Câu 5: Lọc đối tượng dựa trên trạng thái sĩ số lớp
- **Yêu cầu:** Lấy danh sách các lớp học phần đang có sĩ số thực tế vượt quá 40 sinh viên.
- **Câu lệnh OQL / JPQL:**
  ```sql
  SELECT l FROM LopHocPhan l WHERE l.siSoHienTai > 40
  ```
- **Phân tích:**
  - Truy vấn nhanh chóng phục vụ nghiệp vụ cảnh báo các lớp sắp đầy sĩ số tối đa.
- **Kết quả thực thi:**
  - Tìm thấy: Lớp `LHP01` (Sĩ số hiện tại: 45 / Sĩ số tối đa: 50).

---

## 4. Bảng đối chiếu so sánh OQL (ObjectDB) và SQL (PostgreSQL)

| Tiêu chí | Cơ sở dữ liệu Quan hệ (PostgreSQL / SQL) | Cơ sở dữ liệu Đối tượng (ObjectDB / OQL) |
|---|---|---|
| **Mô hình hóa dữ liệu** | Bảng 2 chiều (Tables, Rows, Columns), khóa ngoại (FK) | Lớp đối tượng (Class, Object, References) |
| **Tính kế thừa (Inheritance)** | Khó biểu diễn tự nhiên; phải chia thành 2 bảng (`nguoi`, `sinh_vien`) và JOIN | Hỗ trợ kế thừa nguyên bản (`extends Nguoi`), không cần JOIN |
| **Liên kết giữa các thực thể** | Phải thực hiện phép `JOIN` trên khóa chính/khóa ngoại | Điều hướng trực tiếp bằng dấu chấm (`d.sinhVien.maSv`, `d.lopHocPhan`) |
| **Trở ngại không tương thích kiểu (Impedance Mismatch)** | Có sự chênh lệch lớn giữa code OOP trong ứng dụng và bảng CSDL | Triệt tiêu hoàn toàn sự chênh lệch: Đối tượng lưu thẳng xuống đĩa |
| **Tính toàn vẹn tham chiếu** | Đảm bảo qua ràng buộc `FOREIGN KEY` | Đảm bảo thông qua quan hệ thực thể JPA (`@ManyToOne`, `@OneToMany`) |

---

## 5. Minh chứng thực thi (Evidence Output)
Toàn bộ mã nguồn thực thi đã được kiểm thử thành công bằng chương trình Java:
```text
----------------- CÂU 1 -----------------
Số lượng SV ngành CNTT: 2
 - SV001: Nguyễn Văn An (GPA: 3.6)
 - SV002: Trần Thị Bình (GPA: 3.1)

----------------- CÂU 2 -----------------
Số lượng học phần >= 3 tín chỉ & tiết LT >= 30: 2
 - CS101: Cơ sở dữ liệu nâng cao (Số TC: 4)
 - CS102: Lập trình hướng đối tượng (Số TC: 3)

----------------- CÂU 3 -----------------
Số lớp SV001 đã đăng ký: 1
 - LHP01: CSDL Nâng cao - Nhóm 1

----------------- CÂU 4 -----------------
Điểm GPA tích lũy cao nhất: 3.6

----------------- CÂU 5 -----------------
Số lớp học phần có sĩ số > 40: 1
 - LHP01 (Sĩ số hiện tại: 45/50)

>>> THỰC THI THÀNH CÔNG TOÀN BỘ TRUY VẤN TRÊN OBJECTDB! <<<
```
File log minh chứng đính kèm: `m4_oql_evidence.txt`.
