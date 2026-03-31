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
@Table(name = "tien_do_tu_vung", indexes = {
        @Index(name = "idx_tdtv_on_tap_v2",
                columnList = "nguoi_dung_id, trang_thai, lan_on_tiep_theo"),
        @Index(name = "idx_tdtv_trang_thai",
                columnList = "nguoi_dung_id, trang_thai"),
        @Index(name = "idx_tdtv_nguoi",
                columnList = "nguoi_dung_id")}, uniqueConstraints = {@UniqueConstraint(name = "uk_tdtv_nguoi_tu",
        columnNames = {
                "nguoi_dung_id",
                "tu_vung_id"})})
public class TienDoTuVung {
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
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "tu_vung_id", nullable = false)
    private TuVung tuVung;

    @ColumnDefault("'CHUA_HOC'")
    @Lob
    @Column(name = "trang_thai")
    private String trangThai;

    @ColumnDefault("0")
    @Column(name = "so_lan_dung")
    private Integer soLanDung;

    @ColumnDefault("0")
    @Column(name = "so_lan_sai")
    private Integer soLanSai;

    @ColumnDefault("1")
    @Column(name = "khoang_lap_ngay")
    private Integer khoangLapNgay;

    @ColumnDefault("2.50")
    @Column(name = "he_so_de", precision = 4, scale = 2)
    private BigDecimal heSoDe;

    @ColumnDefault("0")
    @Column(name = "so_lan_lien_tiep_dung")
    private Integer soLanLienTiepDung;

    @Column(name = "lan_on_tiep_theo")
    private Instant lanOnTiepTheo;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}