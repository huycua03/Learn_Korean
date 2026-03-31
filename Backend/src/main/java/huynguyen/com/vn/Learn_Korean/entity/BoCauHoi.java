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
@Table(name = "bo_cau_hoi", indexes = {
        @Index(name = "idx_bch_chu_de_tv",
                columnList = "chu_de_tu_vung_id"),
        @Index(name = "idx_bch_ngu_phap",
                columnList = "ngu_phap_id"),
        @Index(name = "idx_bch_phan_thi",
                columnList = "phan_thi_id"),
        @Index(name = "idx_bch_cap_do",
                columnList = "cap_do_id")})
public class BoCauHoi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 100)
    @NotNull
    @Column(name = "tieu_de", nullable = false, length = 100)
    private String tieuDe;

    @Size(max = 255)
    @Column(name = "mo_ta")
    private String moTa;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "chu_de_tu_vung_id")
    private ChuDeTuVung chuDeTuVung;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "ngu_phap_id")
    private NguPhap nguPhap;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "phan_thi_id")
    private PhanThi phanThi;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "cap_do_id")
    private CapDo capDo;

    @ColumnDefault("'TRAC_NGHIEM'")
    @Lob
    @Column(name = "loai_bo_cau_hoi")
    private String loaiBoCauHoi;

    @ColumnDefault("'TRUNG_BINH'")
    @Lob
    @Column(name = "do_kho")
    private String doKho;

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