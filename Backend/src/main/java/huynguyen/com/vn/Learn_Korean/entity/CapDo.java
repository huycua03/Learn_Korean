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
@Table(name = "cap_do", uniqueConstraints = {@UniqueConstraint(name = "uk_cap_do_ten",
        columnNames = {"ten"})})
public class CapDo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 20)
    @NotNull
    @Column(name = "ten", nullable = false, length = 20)
    private String ten;

    @Size(max = 255)
    @Column(name = "mo_ta")
    private String moTa;

    @NotNull
    @Column(name = "thu_tu_hien_thi", nullable = false)
    private Integer thuTuHienThi;

    @ColumnDefault("0")
    @Column(name = "diem_toi_thieu")
    private Integer diemToiThieu;

    @ColumnDefault("200")
    @Column(name = "diem_toi_da")
    private Integer diemToiDa;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}