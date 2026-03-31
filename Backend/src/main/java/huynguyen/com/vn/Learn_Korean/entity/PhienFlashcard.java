package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "phien_flashcard", indexes = {
        @Index(name = "idx_pf_nguoi",
                columnList = "nguoi_dung_id"),
        @Index(name = "idx_pf_nhom_tu",
                columnList = "nhom_tu_vung_id")})
public class PhienFlashcard {
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
    @JoinColumn(name = "nhom_tu_vung_id", nullable = false)
    private NhomTuVung nhomTuVung;

    @NotNull
    @Column(name = "tong_the", nullable = false)
    private Integer tongThe;

    @ColumnDefault("0")
    @Column(name = "so_the_biet")
    private Integer soTheBiet;

    @ColumnDefault("0")
    @Column(name = "so_the_kho")
    private Integer soTheKho;

    @ColumnDefault("0")
    @Column(name = "so_the_khong_biet")
    private Integer soTheKhongBiet;

    @ColumnDefault("0")
    @Column(name = "thoi_gian_ms")
    private Integer thoiGianMs;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}