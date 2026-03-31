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
@Table(name = "chi_tiet_lo_trinh", indexes = {
        @Index(name = "idx_ctlt_lo_trinh",
                columnList = "lo_trinh_hoc_id, so_ngay"),
        @Index(name = "idx_ctlt_bai_hoc",
                columnList = "bai_hoc_id"),
        @Index(name = "idx_ctlt_bo_cau_hoi",
                columnList = "bo_cau_hoi_id")}, uniqueConstraints = {@UniqueConstraint(name = "uk_ctlt_lo_ngay_bo",
        columnNames = {
                "lo_trinh_hoc_id",
                "so_ngay",
                "bo_cau_hoi_id"})})
public class ChiTietLoTrinh {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "lo_trinh_hoc_id", nullable = false)
    private LoTrinhHoc loTrinhHoc;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "bai_hoc_id")
    private BaiHoc baiHoc;

    @NotNull
    @Column(name = "so_ngay", nullable = false)
    private Integer soNgay;

    @ColumnDefault("'LUYEN_TAP'")
    @Lob
    @Column(name = "loai_hoat_dong")
    private String loaiHoatDong;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "bo_cau_hoi_id", nullable = false)
    private BoCauHoi boCauHoi;

    @ColumnDefault("15")
    @Column(name = "so_cau_hoi")
    private Integer soCauHoi;

    @ColumnDefault("0")
    @Column(name = "muc_tieu_diem")
    private Integer mucTieuDiem;


}