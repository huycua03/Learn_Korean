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
@Table(name = "de_thi", indexes = {
        @Index(name = "idx_dt_cap_do",
                columnList = "cap_do_id"),
        @Index(name = "idx_dt_loai",
                columnList = "loai_de"),
        @Index(name = "idx_dt_trang_thai",
                columnList = "trang_thai, cap_do_id, loai_de")})
public class DeThi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 200)
    @NotNull
    @Column(name = "tieu_de", nullable = false, length = 200)
    private String tieuDe;

    @Lob
    @Column(name = "mo_ta")
    private String moTa;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cap_do_id", nullable = false)
    private CapDo capDo;

    @NotNull
    @Lob
    @Column(name = "loai_de", nullable = false)
    private String loaiDe;

    @ColumnDefault("60")
    @Column(name = "thoi_gian_phut")
    private Integer thoiGianPhut;

    @ColumnDefault("0")
    @Column(name = "tong_cau_hoi")
    private Integer tongCauHoi;

    @ColumnDefault("200")
    @Column(name = "diem_toi_da")
    private Integer diemToiDa;

    @ColumnDefault("'DANG_HOAT_DONG'")
    @Lob
    @Column(name = "trang_thai")
    private String trangThai;

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