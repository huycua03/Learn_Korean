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
@Table(name = "streak", uniqueConstraints = {@UniqueConstraint(name = "uk_s_nguoi",
        columnNames = {"nguoi_dung_id"})})
public class Streak {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private NguoiDung nguoiDung;

    @ColumnDefault("0")
    @Column(name = "chuoi_hien_tai")
    private Integer chuoiHienTai;

    @ColumnDefault("0")
    @Column(name = "chuoi_dai_nhat")
    private Integer chuoiDaiNhat;

    @Column(name = "ngay_hoat_dong_cuoi")
    private LocalDate ngayHoatDongCuoi;

    @ColumnDefault("0")
    @Column(name = "tong_ngay_hoat_dong")
    private Integer tongNgayHoatDong;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}