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
@Table(name = "ket_qua_flashcard", indexes = {
        @Index(name = "idx_kqf_phien",
                columnList = "phien_flashcard_id"),
        @Index(name = "idx_kqf_tu_vung",
                columnList = "tu_vung_id"),
        @Index(name = "idx_kqf_nguoi_tu",
                columnList = "nguoi_dung_id, tu_vung_id")})
public class KetQuaFlashcard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "phien_flashcard_id", nullable = false)
    private PhienFlashcard phienFlashcard;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "tu_vung_id", nullable = false)
    private TuVung tuVung;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private NguoiDung nguoiDung;

    @NotNull
    @Lob
    @Column(name = "danh_gia", nullable = false)
    private String danhGia;

    @Column(name = "thoi_gian_ms")
    private Integer thoiGianMs;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}