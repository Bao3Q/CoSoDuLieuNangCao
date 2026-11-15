import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
public class LopHocPhan implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private long oid;

    private String maLhp;
    private String tenLhp;
    private int siSoToiDa;
    private int siSoHienTai;

    @ManyToOne
    private HocPhan hocPhan;

    @OneToMany(mappedBy = "lopHocPhan", cascade = CascadeType.ALL)
    private List<DangKy> danhSachDangKy = new ArrayList<>();

    public LopHocPhan() {
    }

    public LopHocPhan(String maLhp, String tenLhp, int siSoToiDa, int siSoHienTai, HocPhan hocPhan) {
        this.maLhp = maLhp;
        this.tenLhp = tenLhp;
        this.siSoToiDa = siSoToiDa;
        this.siSoHienTai = siSoHienTai;
        this.hocPhan = hocPhan;
    }

    public long getOid() {
        return oid;
    }

    public void setOid(long oid) {
        this.oid = oid;
    }

    public String getMaLhp() {
        return maLhp;
    }

    public void setMaLhp(String maLhp) {
        this.maLhp = maLhp;
    }

    public String getTenLhp() {
        return tenLhp;
    }

    public void setTenLhp(String tenLhp) {
        this.tenLhp = tenLhp;
    }

    public int getSiSoToiDa() {
        return siSoToiDa;
    }

    public void setSiSoToiDa(int siSoToiDa) {
        this.siSoToiDa = siSoToiDa;
    }

    public int getSiSoHienTai() {
        return siSoHienTai;
    }

    public void setSiSoHienTai(int siSoHienTai) {
        this.siSoHienTai = siSoHienTai;
    }

    public HocPhan getHocPhan() {
        return hocPhan;
    }

    public void setHocPhan(HocPhan hocPhan) {
        this.hocPhan = hocPhan;
    }

    public List<DangKy> getDanhSachDangKy() {
        return danhSachDangKy;
    }

    public void setDanhSachDangKy(List<DangKy> danhSachDangKy) {
        this.danhSachDangKy = danhSachDangKy;
    }
}

