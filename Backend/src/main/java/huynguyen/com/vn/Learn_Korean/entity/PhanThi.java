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
@Table(name = "phan_thi", indexes = {@Index(name = "idx_pt_de_thi",
        columnList = "de_thi_id, thu_tu_hien_thi")})
public class PhanThi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "de_thi_id", nullable = false)
    private DeThi deThi;

    @Size(max = 100)
    @NotNull
    @Column(name = "ten", nullable = false, length = 100)
    private String ten;

    @NotNull
    @Lob
    @Column(name = "ky_nang", nullable = false)
    private String kyNang;

    @NotNull
    @Column(name = "cau_so", nullable = false)
    private Integer cauSo;

    @NotNull
    @Column(name = "cau_den", nullable = false)
    private Integer cauDen;

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