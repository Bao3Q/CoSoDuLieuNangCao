import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
public class HocPhan implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private long oid;

    private String maHp;
    private String tenHp;
    private int soTinChi;
    private int soTietLyThuyet;
    private int soTietThucHanh;

    @OneToMany(mappedBy = "hocPhan", cascade = CascadeType.ALL)
    private List<LopHocPhan> danhSachLopHocPhan = new ArrayList<>();

    public HocPhan() {
    }

    public HocPhan(String maHp, String tenHp, int soTinChi, int soTietLyThuyet, int soTietThucHanh) {
        this.maHp = maHp;
        this.tenHp = tenHp;
        this.soTinChi = soTinChi;
        this.soTietLyThuyet = soTietLyThuyet;
        this.soTietThucHanh = soTietThucHanh;
    }

    public long getOid() {
        return oid;
    }

    public void setOid(long oid) {
        this.oid = oid;
    }

    public String getMaHp() {
        return maHp;
    }

    public void setMaHp(String maHp) {
        this.maHp = maHp;
    }

    public String getTenHp() {
        return tenHp;
    }

    public void setTenHp(String tenHp) {
        this.tenHp = tenHp;
    }

    public int getSoTinChi() {
        return soTinChi;
    }

    public void setSoTinChi(int soTinChi) {
        this.soTinChi = soTinChi;
    }

    public int getSoTietLyThuyet() {
        return soTietLyThuyet;
    }

    public void setSoTietLyThuyet(int soTietLyThuyet) {
        this.soTietLyThuyet = soTietLyThuyet;
    }

    public int getSoTietThucHanh() {
        return soTietThucHanh;
    }

    public void setSoTietThucHanh(int soTietThucHanh) {
        this.soTietThucHanh = soTietThucHanh;
    }

    public List<LopHocPhan> getDanhSachLopHocPhan() {
        return danhSachLopHocPhan;
    }

    public void setDanhSachLopHocPhan(List<LopHocPhan> danhSachLopHocPhan) {
        this.danhSachLopHocPhan = danhSachLopHocPhan;
    }
}

