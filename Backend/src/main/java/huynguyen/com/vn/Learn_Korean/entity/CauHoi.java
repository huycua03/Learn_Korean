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
@Table(name = "cau_hoi", indexes = {
        @Index(name = "idx_ch_bo_cau_hoi",
                columnList = "bo_cau_hoi_id"),
        @Index(name = "idx_ch_do_kho",
                columnList = "do_kho"),
        @Index(name = "idx_ch_phan_thi",
                columnList = "phan_thi_id")})
public class CauHoi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "bo_cau_hoi_id", nullable = false)
    private BoCauHoi boCauHoi;

    @NotNull
    @Lob
    @Column(name = "noi_dung", nullable = false)
    private String noiDung;

    @ColumnDefault("'VAN_BAN'")
    @Lob
    @Column(name = "loai_noi_dung")
    private String loaiNoiDung;

    @Size(max = 255)
    @Column(name = "duong_dan_tep")
    private String duongDanTep;

    @Size(max = 255)
    @NotNull
    @Column(name = "lua_chon_a", nullable = false)
    private String luaChonA;

    @Size(max = 255)
    @NotNull
    @Column(name = "lua_chon_b", nullable = false)
    private String luaChonB;

    @Size(max = 255)
    @NotNull
    @Column(name = "lua_chon_c", nullable = false)
    private String luaChonC;

    @Size(max = 255)
    @NotNull
    @Column(name = "lua_chon_d", nullable = false)
    private String luaChonD;

    @NotNull
    @Column(name = "dap_an_dung", nullable = false)
    private Character dapAnDung;

    @Lob
    @Column(name = "giai_thich")
    private String giaiThich;

    @ColumnDefault("'TRUNG_BINH'")
    @Lob
    @Column(name = "do_kho")
    private String doKho;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "phan_thi_id")
    private PhanThi phanThi;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tao")
    private Instant ngayTao;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_cap_nhat")
    private Instant ngayCapNhat;

    @ColumnDefault("0")
    @Column(name = "version")
    private Integer version;


}