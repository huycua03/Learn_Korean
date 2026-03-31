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
@Table(name = "bai_hoc", indexes = {
        @Index(name = "idx_bh_cap_do",
                columnList = "cap_do_id"),
        @Index(name = "idx_bh_loc",
                columnList = "trang_thai, da_xoa, thu_tu_hien_thi")})
public class BaiHoc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 200)
    @NotNull
    @Column(name = "tieu_de", nullable = false, length = 200)
    private String tieuDe;

    @Lob
    @Column(name = "mo_ta")
    private String moTa;

    @Size(max = 255)
    @Column(name = "hinh_anh_url")
    private String hinhAnhUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "cap_do_id")
    private CapDo capDo;

    @ColumnDefault("'NHAP'")
    @Lob
    @Column(name = "trang_thai")
    private String trangThai;

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