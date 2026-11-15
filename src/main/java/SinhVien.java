import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class SinhVien extends Nguoi {
    private static final long serialVersionUID = 1L;

    private String maSv;
    private String lopSinhHoat;
    private int namNhapHoc;
    private String chuyenNganh;
    private float gpaTichLuy;

    @OneToMany(mappedBy = "sinhVien", cascade = CascadeType.ALL)
    private List<DangKy> danhSachDangKy = new ArrayList<>();

    public SinhVien() {
        super();
    }

    public SinhVien(String maNguoi, String hoTen, Date ngaySinh, String gioiTinh, String email, String soDienThoai,
                    String maSv, String lopSinhHoat, int namNhapHoc, String chuyenNganh, float gpaTichLuy) {
        super(maNguoi, hoTen, ngaySinh, gioiTinh, email, soDienThoai);
        this.maSv = maSv;
        this.lopSinhHoat = lopSinhHoat;
        this.namNhapHoc = namNhapHoc;
        this.chuyenNganh = chuyenNganh;
        this.gpaTichLuy = gpaTichLuy;
    }

    public String getMaSv() {
        return maSv;
    }

    public void setMaSv(String maSv) {
        this.maSv = maSv;
    }

    public String getLopSinhHoat() {
        return lopSinhHoat;
    }

    public void setLopSinhHoat(String lopSinhHoat) {
        this.lopSinhHoat = lopSinhHoat;
    }

    public int getNamNhapHoc() {
        return namNhapHoc;
    }

    public void setNamNhapHoc(int namNhapHoc) {
        this.namNhapHoc = namNhapHoc;
    }

    public String getChuyenNganh() {
        return chuyenNganh;
    }

    public void setChuyenNganh(String chuyenNganh) {
        this.chuyenNganh = chuyenNganh;
    }

    public float getGpaTichLuy() {
        return gpaTichLuy;
    }

    public void setGpaTichLuy(float gpaTichLuy) {
        this.gpaTichLuy = gpaTichLuy;
    }

    public List<DangKy> getDanhSachDangKy() {
        return danhSachDangKy;
    }

    public void setDanhSachDangKy(List<DangKy> danhSachDangKy) {
        this.danhSachDangKy = danhSachDangKy;
    }
}

