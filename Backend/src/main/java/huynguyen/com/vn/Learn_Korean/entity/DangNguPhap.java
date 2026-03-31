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
@Table(name = "dang_ngu_phap", indexes = {@Index(name = "idx_cdnp_thu_tu",
        columnList = "da_xoa, thu_tu_hien_thi")}, uniqueConstraints = {@UniqueConstraint(name = "uk_cdnp_ten",
        columnNames = {"ten"})})
public class DangNguPhap {
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

    @Size(max = 255)
    @Column(name = "hinh_anh_url")
    private String hinhAnhUrl;

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