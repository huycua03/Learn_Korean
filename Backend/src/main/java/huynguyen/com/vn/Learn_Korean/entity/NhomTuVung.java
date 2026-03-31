package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "nhom_tu_vung", indexes = {
        @Index(name = "idx_ntv_chu_de",
                columnList = "chu_de_tu_vung_id, thu_tu_hien_thi"),
        @Index(name = "idx_ntv_chu_de_tv",
                columnList = "chu_de_tu_vung_id"),
        @Index(name = "idx_ntv_cap_do",
                columnList = "cap_do_id")})
public class NhomTuVung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 100)
    @NotNull
    @Column(name = "ten", nullable = false, length = 100)
    private String ten;

    @Size(max = 255)
    @Column(name = "mo_ta")
    private String moTa;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chu_de_tu_vung_id")
    private ChuDeTuVung chuDeTuVung;

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


}