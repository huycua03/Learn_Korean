package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "phien_luyen_tap", indexes = {
        @Index(name = "idx_plt_nguoi_ngay",
                columnList = "nguoi_dung_id, ngay_tao"),
        @Index(name = "idx_plt_nguoi_dung",
                columnList = "nguoi_dung_id"),
        @Index(name = "idx_plt_bo_cau_hoi",
                columnList = "bo_cau_hoi_id"),
        @Index(name = "idx_plt_nguon",
                columnList = "loai_nguon, nguon_id")})
public class PhienLuyenTap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private NguoiDung nguoiDung;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "bo_cau_hoi_id", nullable = false)
    private BoCauHoi boCauHoi;

    @NotNull
    @ColumnDefault("'TU_DO'")
    @Lob
    @Column(name = "loai_nguon", nullable = false)
    private String loaiNguon;

    @Column(name = "nguon_id")
    private Long nguonId;

    @NotNull
    @Column(name = "tong_cau_hoi", nullable = false)
    private Integer tongCauHoi;

    @NotNull
    @Column(name = "so_cau_dung", nullable = false)
    private Integer soCauDung;

    @NotNull
    @Column(name = "do_chinh_xac", nullable = false, precision = 5, scale = 2)
    private BigDecimal doChinhXac;

    @ColumnDefault("0")
    @Column(name = "diem_so")
    private Integer diemSo;

    @ColumnDefault("0")
    @Column(name = "thoi_gian_trung_binh_ms")
    private Integer thoiGianTrungBinhMs;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}