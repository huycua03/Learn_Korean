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
@Table(name = "lo_trinh_hoc", indexes = {@Index(name = "idx_lth_cap_bat_dau",
        columnList = "cap_do_bat_dau_id")})
public class LoTrinhHoc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 200)
    @NotNull
    @Column(name = "ten", nullable = false, length = 200)
    private String ten;

    @Lob
    @Column(name = "mo_ta")
    private String moTa;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cap_do_bat_dau_id", nullable = false)
    private CapDo capDoBatDau;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cap_do_ket_thuc_id", nullable = false)
    private CapDo capDoKetThuc;

    @NotNull
    @Column(name = "tong_tuan", nullable = false)
    private Integer tongTuan;

    @ColumnDefault("30")
    @Column(name = "so_phut_moi_ngay")
    private Integer soPhutMoiNgay;

    @ColumnDefault("0")
    @Column(name = "da_xoa")
    private Boolean daXoa;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}