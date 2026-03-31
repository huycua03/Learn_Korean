package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "token", indexes = {
        @Index(name = "idx_tk_nguoi_thu_hoi",
                columnList = "nguoi_dung_id, bi_thu_hoi"),
        @Index(name = "idx_tk_nguoi_dung",
                columnList = "nguoi_dung_id"),
        @Index(name = "idx_tk_access_hash",
                columnList = "access_token_hash"),
        @Index(name = "idx_tk_refresh",
                columnList = "refresh_token"),
        @Index(name = "idx_tk_het_han",
                columnList = "het_han")})
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private NguoiDung nguoiDung;

    @Size(max = 255)
    @Column(name = "access_token_hash")
    private String accessTokenHash;

    @Size(max = 255)
    @Column(name = "refresh_token")
    private String refreshToken;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vai_tro_id", nullable = false)
    private VaiTro vaiTro;

    @Size(max = 255)
    @Column(name = "thiet_bi")
    private String thietBi;

    @Size(max = 45)
    @Column(name = "dia_chi_ip", length = 45)
    private String diaChiIp;

    @ColumnDefault("'BOTH'")
    @Lob
    @Column(name = "loai_token")
    private String loaiToken;

    @Column(name = "het_han")
    private Instant hetHan;

    @ColumnDefault("0")
    @Column(name = "bi_thu_hoi")
    private Boolean biThuHoi;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;


}