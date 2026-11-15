import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
public class DangKy implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private long oid;

    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGianDk;
    private String trangThai;

    @ManyToOne
    private SinhVien sinhVien;

    @ManyToOne
    private LopHocPhan lopHocPhan;

    public DangKy() {
    }

    public DangKy(Date thoiGianDk, String trangThai, SinhVien sinhVien, LopHocPhan lopHocPhan) {
        this.thoiGianDk = thoiGianDk;
        this.trangThai = trangThai;
        this.sinhVien = sinhVien;
        this.lopHocPhan = lopHocPhan;
    }

    public long getOid() {
        return oid;
    }

    public void setOid(long oid) {
        this.oid = oid;
    }

    public Date getThoiGianDk() {
        return thoiGianDk;
    }

    public void setThoiGianDk(Date thoiGianDk) {
        this.thoiGianDk = thoiGianDk;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public SinhVien getSinhVien() {
        return sinhVien;
    }

    public void setSinhVien(SinhVien sinhVien) {
        this.sinhVien = sinhVien;
    }

    public LopHocPhan getLopHocPhan() {
        return lopHocPhan;
    }

    public void setLopHocPhan(LopHocPhan lopHocPhan) {
        this.lopHocPhan = lopHocPhan;
    }
}
