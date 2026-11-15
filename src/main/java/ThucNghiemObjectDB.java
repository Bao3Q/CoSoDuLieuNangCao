import javax.persistence.*;
import java.text.Normalizer;
import java.util.Date;
import java.util.List;

public class ThucNghiemObjectDB {
    public static void main(String[] args) {
        String dbPath = "quanly_dangky.odb";
        EntityManagerFactory emf = Persistence.createEntityManagerFactory(dbPath);
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            long count = 0;
            try {
                count = em.createQuery("SELECT COUNT(s) FROM SinhVien s", Long.class).getSingleResult();
            } catch (Exception ex) {
                count = 0;
            }

            if (count == 0) {
                System.out.println(">>> Dang nap du lieu mau ban dau vao ObjectDB...");

                HocPhan hp1 = new HocPhan("CS101", "Cơ sở dữ liệu nâng cao", 4, 45, 30);
                HocPhan hp2 = new HocPhan("CS102", "Lập trình hướng đối tượng", 3, 30, 30);
                em.persist(hp1);
                em.persist(hp2);

                LopHocPhan lhp1 = new LopHocPhan("LHP01", "CSDL Nâng cao - Nhóm 1", 50, 45, hp1);
                LopHocPhan lhp2 = new LopHocPhan("LHP02", "OOP - Nhóm 2", 40, 35, hp2);
                em.persist(lhp1);
                em.persist(lhp2);

                SinhVien sv1 = new SinhVien("NG01", "Nguyễn Văn An", new Date(101, 4, 15), "Nam", "an@gmail.com",
                        "0901234567", "SV001", "D20CNTT1", 2020, "Công nghệ thông tin", 3.6f);
                SinhVien sv2 = new SinhVien("NG02", "Trần Thị Bình", new Date(102, 7, 20), "Nu", "binh@gmail.com",
                        "0912345678", "SV002", "D20CNTT2", 2020, "Công nghệ thông tin", 3.1f);
                em.persist(sv1);
                em.persist(sv2);

                DangKy dk1 = new DangKy(new Date(), "ThanhCong", sv1, lhp1);
                DangKy dk2 = new DangKy(new Date(), "ThanhCong", sv2, lhp1);
                em.persist(dk1);
                em.persist(dk2);

                em.getTransaction().commit();
                em.getTransaction().begin();
                System.out.println(">>> Nap du lieu mau thanh cong!");
            }

            // --- CÂU 1: Lấy danh sách sinh viên theo chuyên ngành ---
            System.out.println("\n----------------- CAU 1 -----------------");
            String jpql1 = "SELECT s FROM SinhVien s WHERE s.chuyenNganh = :chuyenNganh";
            TypedQuery<SinhVien> query1 = em.createQuery(jpql1, SinhVien.class);
            query1.setParameter("chuyenNganh", "Công nghệ thông tin");
            List<SinhVien> listSV = query1.getResultList();
            System.out.println("So luong sinh vien nganh CNTT: " + listSV.size());
            for (SinhVien sv : listSV) {
                System.out.println(" - " + sv.getMaSv() + ": " + khongDau(sv.getHoTen())
                        + " (GPA: " + sv.getGpaTichLuy() + ")");
            }

            // --- CÂU 2: Lọc học phần từ 3 tín chỉ trở lên và tiết lý thuyết >= 30 ---
            System.out.println("\n----------------- CAU 2 -----------------");
            String jpql2 = "SELECT h FROM HocPhan h WHERE h.soTinChi >= :minTC AND h.soTietLyThuyet >= 30";
            TypedQuery<HocPhan> query2 = em.createQuery(jpql2, HocPhan.class);
            query2.setParameter("minTC", 3);
            List<HocPhan> listHP = query2.getResultList();
            System.out.println("So luong hoc phan >= 3 tin chi va tiet ly thuyet >= 30: " + listHP.size());
            for (HocPhan hp : listHP) {
                System.out.println(" - " + hp.getMaHp() + ": " + khongDau(hp.getTenHp())
                        + " (So TC: " + hp.getSoTinChi() + ")");
            }

            // --- CÂU 3: Điều hướng đối tượng (Tìm lớp học phần mà sinh viên 'SV001' đã
            // đăng ký) ---
            System.out.println("\n----------------- CAU 3 -----------------");
            String jpql3 = "SELECT d.lopHocPhan FROM DangKy d WHERE d.sinhVien.maSv = :maSv";
            TypedQuery<LopHocPhan> query3 = em.createQuery(jpql3, LopHocPhan.class);
            query3.setParameter("maSv", "SV001");
            List<LopHocPhan> listLHP = query3.getResultList();
            System.out.println("So lop SV001 da dang ky: " + listLHP.size());
            for (LopHocPhan lhp : listLHP) {
                System.out.println(" - " + lhp.getMaLhp() + ": " + khongDau(lhp.getTenLhp()));
            }

            // --- CÂU 4: Hàm kết gộp MAX (Tìm GPA tích lũy cao nhất) ---
            System.out.println("\n----------------- CAU 4 -----------------");
            String jpql4 = "SELECT MAX(s.gpaTichLuy) FROM SinhVien s";
            TypedQuery<Float> query4 = em.createQuery(jpql4, Float.class);
            Float maxGPA = query4.getSingleResult();
            System.out.println("Diem GPA tich luy cao nhat: " + maxGPA);

            // --- CÂU 5: Lấy thông tin các lớp học phần có sĩ số hiện tại > 40 ---
            System.out.println("\n----------------- CAU 5 -----------------");
            String jpql5 = "SELECT l FROM LopHocPhan l WHERE l.siSoHienTai > 40";
            TypedQuery<LopHocPhan> query5 = em.createQuery(jpql5, LopHocPhan.class);
            List<LopHocPhan> listLopDong = query5.getResultList();
            System.out.println("So lop hoc phan co si so > 40: " + listLopDong.size());
            for (LopHocPhan lhp : listLopDong) {
                System.out.println(" - " + lhp.getMaLhp() + " (Si so hien tai: " + lhp.getSiSoHienTai() + "/"
                        + lhp.getSiSoToiDa() + ")");
            }

            em.getTransaction().commit();
            System.out.println("\n>>> THUC THI THANH CONG TOAN BO TRUY VAN TREN OBJECTDB! <<<");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }

    private static String khongDau(String value) {
        String normalized = value.replace("Đ", "D").replace("đ", "d");
        return Normalizer.normalize(normalized, Normalizer.Form.NFD)
                .replaceAll("\\p{M}+", "");
    }
}
