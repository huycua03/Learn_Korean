package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "bai_hoc_bo_cau_hoi", indexes = {@Index(name = "idx_bh_bch_bo",
        columnList = "bo_cau_hoi_id")}, uniqueConstraints = {@UniqueConstraint(name = "uk_bh_bch",
        columnNames = {
                "bai_hoc_id",
                "thu_tu_hien_thi"})})
public class BaiHocBoCauHoi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "bai_hoc_id", nullable = false)
    private BaiHoc baiHoc;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "bo_cau_hoi_id", nullable = false)
    private BoCauHoi boCauHoi;

    @NotNull
    @Column(name = "thu_tu_hien_thi", nullable = false)
    private Integer thuTuHienThi;

    @ColumnDefault("1")
    @Column(name = "la_bat_buoc")
    private Boolean laBatBuoc;

    @ColumnDefault("0")
    @Column(name = "diem_toi_thieu")
    private Integer diemToiThieu;


}