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
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "lich_su_ngay", indexes = {
        @Index(name = "idx_lsn_nguoi_ngay_sort",
                columnList = "nguoi_dung_id, ngay_hoc"),
        @Index(name = "idx_lsn_nguoi",
                columnList = "nguoi_dung_id"),
        @Index(name = "idx_lsn_ngay",
                columnList = "ngay_hoc")}, uniqueConstraints = {@UniqueConstraint(name = "uk_lsn_nguoi_ngay",
        columnNames = {
                "nguoi_dung_id",
                "ngay_hoc"})})
public class LichSuNgay {
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
    @Column(name = "ngay_hoc", nullable = false)
    private LocalDate ngayHoc;

    @ColumnDefault("0")
    @Column(name = "so_phien_luyen")
    private Integer soPhienLuyen;

    @ColumnDefault("0")
    @Column(name = "so_phien_flashcard")
    private Integer soPhienFlashcard;

    @ColumnDefault("0")
    @Column(name = "so_tu_vung_on_tap")
    private Integer soTuVungOnTap;

    @ColumnDefault("0")
    @Column(name = "so_ngu_phap_on_tap")
    private Integer soNguPhapOnTap;

    @ColumnDefault("0")
    @Column(name = "tong_thoi_gian_phut")
    private Integer tongThoiGianPhut;

    @ColumnDefault("0.00")
    @Column(name = "diem_trung_binh", precision = 5, scale = 2)
    private BigDecimal diemTrungBinh;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}