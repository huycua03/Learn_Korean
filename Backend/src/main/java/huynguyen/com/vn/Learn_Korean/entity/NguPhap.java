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
@Table(name = "ngu_phap", indexes = {
        @Index(name = "ft_np_tim_kiem",
                columnList = "tieu_de, giai_thich, ghi_chu"),
        @Index(name = "idx_np_chu_de",
                columnList = "dang_ngu_phap_id, thu_tu_hien_thi"),
        @Index(name = "idx_np_dang_ngu_phap",
                columnList = "dang_ngu_phap_id"),
        @Index(name = "idx_np_cap_do",
                columnList = "cap_do_id")})
public class NguPhap {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 200)
    @NotNull
    @Column(name = "tieu_de", nullable = false, length = 200)
    private String tieuDe;

    @NotNull
    @Lob
    @Column(name = "cau_truc", nullable = false)
    private String cauTruc;

    @NotNull
    @Lob
    @Column(name = "giai_thich", nullable = false)
    private String giaiThich;

    @Lob
    @Column(name = "ghi_chu")
    private String ghiChu;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "dang_ngu_phap_id")
    private DangNguPhap dangNguPhap;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cap_do_id", nullable = false)
    private CapDo capDo;

    @ColumnDefault("0")
    @Column(name = "thu_tu_hien_thi")
    private Integer thuTuHienThi;

    @ColumnDefault("0")
    @Column(name = "da_xoa")
    private Boolean daXoa;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;

    @ColumnDefault("0")
    @Column(name = "version")
    private Integer version;


}