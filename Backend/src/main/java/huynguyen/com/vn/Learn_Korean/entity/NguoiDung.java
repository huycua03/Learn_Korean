package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "nguoi_dung", indexes = {
        @Index(name = "idx_nguoi_dung_vai_tro",
                columnList = "vai_tro_id"),
        @Index(name = "idx_nguoi_dung_trang_thai",
                columnList = "trang_thai")}, uniqueConstraints = {
        @UniqueConstraint(name = "uk_nguoi_dung_ten_dang_nhap",
                columnNames = {"ten_dang_nhap"}),
        @UniqueConstraint(name = "uk_nguoi_dung_email",
                columnNames = {"email"})})
public class NguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 50)
    @NotNull
    @Column(name = "ten_dang_nhap", nullable = false, length = 50)
    private String tenDangNhap;

    @Size(max = 100)
    @NotNull
    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Size(max = 255)
    @NotNull
    @Column(name = "mat_khau", nullable = false)
    private String matKhau;

    @Size(max = 32)
    @Column(name = "mat_khau_salt", length = 32)
    private String matKhauSalt;

    @Size(max = 100)
    @ColumnDefault("''")
    @Column(name = "ho_ten", length = 100)
    private String hoTen;

    @Size(max = 100)
    @Column(name = "ten_hien_thi", length = 100)
    private String tenHienThi;

    @Size(max = 255)
    @Column(name = "avatar_url")
    private String avatarUrl;

    @Size(max = 200)
    @ColumnDefault("''")
    @Column(name = "dia_chi", length = 200)
    private String diaChi;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vai_tro_id", nullable = false)
    private VaiTro vaiTro;

    @ColumnDefault("'ACTIVE'")
    @Lob
    @Column(name = "trang_thai")
    private String trangThai;

    @Column(name = "lan_dang_nhap_cuoi")
    private Instant lanDangNhapCuoi;

    @ColumnDefault("1")
    @Column(name = "da_kich_hoat")
    private Boolean daKichHoat;

    @ColumnDefault("0")
    @Column(name = "da_xoa")
    private Boolean daXoa;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;

    @ColumnDefault("0")
    @Column(name = "version")
    private Integer version;


}