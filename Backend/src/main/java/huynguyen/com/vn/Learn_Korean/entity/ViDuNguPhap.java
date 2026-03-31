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
@Table(name = "vi_du_ngu_phap", indexes = {
        @Index(name = "idx_vnp_ngu_phap",
                columnList = "ngu_phap_id"),
        @Index(name = "ft_vnp_tim_kiem",
                columnList = "vi_du, dich_nghia")})
public class ViDuNguPhap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "ngu_phap_id", nullable = false)
    private NguPhap nguPhap;

    @NotNull
    @Lob
    @Column(name = "vi_du", nullable = false)
    private String viDu;

    @NotNull
    @Lob
    @Column(name = "dich_nghia", nullable = false)
    private String dichNghia;

    @Size(max = 255)
    @Column(name = "am_thanh_url")
    private String amThanhUrl;

    @ColumnDefault("0")
    @Column(name = "thu_tu_hien_thi")
    private Integer thuTuHienThi;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}