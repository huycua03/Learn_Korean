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
@Table(name = "nghia_tu", indexes = {@Index(name = "idx_nt_tu_vung_loai_tu",
        columnList = "tu_vung_loai_tu_id")})
public class NghiaTu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "tu_vung_loai_tu_id", nullable = false)
    private TuVungLoaiTu tuVungLoaiTu;

    @Size(max = 255)
    @NotNull
    @Column(name = "nghia", nullable = false)
    private String nghia;

    @Size(max = 10)
    @Column(name = "cap_do_su_dung", length = 10)
    private String capDoSuDung;

    @Lob
    @Column(name = "vi_du")
    private String viDu;

    @Lob
    @Column(name = "vi_du_dich")
    private String viDuDich;

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