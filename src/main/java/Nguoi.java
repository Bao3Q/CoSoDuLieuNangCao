import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Nguoi implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private long oid;

    private String maNguoi;
    private String hoTen;
    @Temporal(TemporalType.DATE)
    private Date ngaySinh;
    private String gioiTinh;
    private String email;
    private String soDienThoai;

    public Nguoi() {
    }

    public Nguoi(String maNguoi, String hoTen, Date ngaySinh, String gioiTinh, String email, String soDienThoai) {
        this.maNguoi = maNguoi;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.email = email;
        this.soDienThoai = soDienThoai;
    }

    public long getOid() {
        return oid;
    }

    public void setOid(long oid) {
        this.oid = oid;
    }

    public String getMaNguoi() {
        return maNguoi;
    }

    public void setMaNguoi(String maNguoi) {
        this.maNguoi = maNguoi;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }
}

