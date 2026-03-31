package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
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
@Table(name = "ket_qua_ky_nang", indexes = {
        @Index(name = "idx_kqkn_nguoi_loai",
                columnList = "nguoi_dung_id, loai_ky_nang"),
        @Index(name = "idx_kqkn_tu_vung",
                columnList = "tu_vung_id")})
public class KetQuaKyNang {
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

    @NotNull
    @Lob
    @Column(name = "loai_ky_nang", nullable = false)
    private String loaiKyNang;

    @Size(max = 255)
    @Column(name = "file_audio_url")
    private String fileAudioUrl;

    @Column(name = "diem_phat_am", precision = 4, scale = 2)
    private BigDecimal diemPhatAm;

    @Lob
    @Column(name = "nhan_xet_ai")
    private String nhanXetAi;

    @Size(max = 255)
    @Column(name = "cau_tra_loi")
    private String cauTraLoi;

    @Column(name = "dung_hay_sai")
    private Boolean dungHaySai;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}