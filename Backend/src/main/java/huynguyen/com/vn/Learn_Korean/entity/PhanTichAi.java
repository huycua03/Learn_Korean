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
@Table(name = "phan_tich_ai", indexes = {
        @Index(name = "idx_ptai_nguoi_v2",
                columnList = "nguoi_dung_id, ngay_tao, loai_phan_tich"),
        @Index(name = "idx_ptai_loai",
                columnList = "loai_phan_tich")})
public class PhanTichAi {
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
    @Lob
    @Column(name = "loai_phan_tich", nullable = false)
    private String loaiPhanTich;

    @ColumnDefault("0")
    @Column(name = "tong_tu_da_hoc")
    private Integer tongTuDaHoc;

    @ColumnDefault("0")
    @Column(name = "tong_ngu_phap_da_hoc")
    private Integer tongNguPhapDaHoc;

    @ColumnDefault("0.00")
    @Column(name = "diem_trung_binh", precision = 5, scale = 2)
    private BigDecimal diemTrungBinh;

    @ColumnDefault("0")
    @Column(name = "so_ngay_diem_thap")
    private Integer soNgayDiemThap;

    @Lob
    @Column(name = "diem_yeu_tu_vung")
    private String diemYeuTuVung;

    @Lob
    @Column(name = "diem_yeu_ngu_phap")
    private String diemYeuNguPhap;

    @Lob
    @Column(name = "loi_mac_dinh")
    private String loiMacDinh;

    @Lob
    @Column(name = "goi_y_on_tap")
    private String goiYOnTap;

    @NotNull
    @Lob
    @Column(name = "noi_dung_phan_tich", nullable = false)
    private String noiDungPhanTich;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}