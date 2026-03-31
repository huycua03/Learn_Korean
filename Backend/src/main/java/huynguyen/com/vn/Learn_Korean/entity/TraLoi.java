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
@Table(name = "tra_loi", indexes = {
        @Index(name = "idx_tl_ghi_nho",
                columnList = "phien_luyen_tap_id, duoc_ghi_nho"),
        @Index(name = "idx_tl_phien",
                columnList = "phien_luyen_tap_id"),
        @Index(name = "idx_tl_cau_hoi",
                columnList = "cau_hoi_id")})
public class TraLoi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "phien_luyen_tap_id", nullable = false)
    private PhienLuyenTap phienLuyenTap;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cau_hoi_id", nullable = false)
    private CauHoi cauHoi;

    @Column(name = "lua_chon")
    private Character luaChon;

    @NotNull
    @Column(name = "dung_hay_sai", nullable = false)
    private Boolean dungHaySai;

    @Column(name = "thoi_gian_ms")
    private Integer thoiGianMs;

    @ColumnDefault("0")
    @Column(name = "duoc_ghi_nho")
    private Boolean duocGhiNho;

    @ColumnDefault("CURRENT_TIMESTAMP(6)")
    @Column(name = "ngay_tra_loi")
    private Instant ngayTraLoi;


}