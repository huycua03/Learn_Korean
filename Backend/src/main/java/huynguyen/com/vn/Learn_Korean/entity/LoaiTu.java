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
@Table(name = "loai_tu", uniqueConstraints = {
        @UniqueConstraint(name = "uk_loai_tu_ten",
                columnNames = {"ten"}),
        @UniqueConstraint(name = "uk_loai_tu_ky_hieu",
                columnNames = {"ky_hieu"})})
public class LoaiTu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Size(max = 50)
    @NotNull
    @Column(name = "ten", nullable = false, length = 50)
    private String ten;

    @Size(max = 20)
    @NotNull
    @Column(name = "ky_hieu", nullable = false, length = 20)
    private String kyHieu;

    @Size(max = 255)
    @Column(name = "mo_ta")
    private String moTa;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}