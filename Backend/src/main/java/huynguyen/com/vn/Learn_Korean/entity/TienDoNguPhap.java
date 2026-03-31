package huynguyen.com.vn.Learn_Korean.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "tien_do_ngu_phap", indexes = {@Index(name = "idx_tdnp_nguoi",
        columnList = "nguoi_dung_id")}, uniqueConstraints = {@UniqueConstraint(name = "uk_tdnp_nguoi_ngu",
        columnNames = {
                "nguoi_dung_id",
                "ngu_phap_id"})})
public class TienDoNguPhap {
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
    @JoinColumn(name = "ngu_phap_id", nullable = false)
    private NguPhap nguPhap;

    @ColumnDefault("0")
    @Column(name = "da_hoc")
    private Boolean daHoc;

    @ColumnDefault("0")
    @Column(name = "so_lan_luyen")
    private Integer soLanLuyen;

    @ColumnDefault("0")
    @Column(name = "so_lan_dung")
    private Integer soLanDung;

    @Column(name = "lan_on_gan_nhat")
    private Instant lanOnGanNhat;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;


}