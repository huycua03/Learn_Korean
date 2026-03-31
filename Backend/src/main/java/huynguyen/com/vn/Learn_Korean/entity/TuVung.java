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
@Table(name = "tu_vung", indexes = {
        @Index(name = "ft_tv_tim_kiem",
                columnList = "tu, phien_am, nghia_chinh"),
        @Index(name = "idx_tv_tu",
                columnList = "tu"),
        @Index(name = "idx_tv_nhom",
                columnList = "nhom_tu_vung_id")})
public class TuVung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 100)
    @NotNull
    @Column(name = "tu", nullable = false, length = 100)
    private String tu;

    @Size(max = 100)
    @Column(name = "phien_am", length = 100)
    private String phienAm;

    @Size(max = 255)
    @NotNull
    @Column(name = "nghia_chinh", nullable = false)
    private String nghiaChinh;

    @Lob
    @Column(name = "vi_du")
    private String viDu;

    @Lob
    @Column(name = "vi_du_dich")
    private String viDuDich;

    @Size(max = 255)
    @Column(name = "hinh_anh_url")
    private String hinhAnhUrl;

    @Size(max = 255)
    @Column(name = "am_thanh_url")
    private String amThanhUrl;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "nhom_tu_vung_id", nullable = false)
    private NhomTuVung nhomTuVung;

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