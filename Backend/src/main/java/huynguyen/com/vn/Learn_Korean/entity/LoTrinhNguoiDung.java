package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "lo_trinh_nguoi_dung", indexes = {
        @Index(name = "idx_lnd_nguoi",
                columnList = "nguoi_dung_id, trang_thai"),
        @Index(name = "idx_lnd_lo_trinh",
                columnList = "lo_trinh_hoc_id")}, uniqueConstraints = {@UniqueConstraint(name = "uk_lnd_nguoi_lo_trinh",
        columnNames = {
                "nguoi_dung_id",
                "lo_trinh_hoc_id"})})
public class LoTrinhNguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private NguoiDung nguoiDung;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "lo_trinh_hoc_id", nullable = false)
    private LoTrinhHoc loTrinhHoc;

    @Column(name = "diem_phan_loai")
    private Integer diemPhanLoai;

    @NotNull
    @Column(name = "ngay_bat_dau", nullable = false)
    private LocalDate ngayBatDau;

    @NotNull
    @Column(name = "ngay_ket_thuc_du_kien", nullable = false)
    private LocalDate ngayKetThucDuKien;

    @ColumnDefault("'DANG_HOC'")
    @Lob
    @Column(name = "trang_thai")
    private String trangThai;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}