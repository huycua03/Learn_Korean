-- ============================================================
-- DATABASE: hoc_tieng_han
-- Mo ta: Ung dung hoc tieng Han theo phong cach Duolingo
-- Phien ban: v1.0
-- So luong bang: 28
-- Chuan hoa: 3NF
-- ============================================================
create database hoc_tieng_han;
use hoc_tieng_han;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. NEN TANG HE THONG
-- ============================================================

-- -----------------------------------------------------------
-- Bang: vai_tro
-- Mo ta: Phan quyen nguoi dung (ADMIN, MODERATOR, NGUOI_DUNG)
-- -----------------------------------------------------------
CREATE TABLE vai_tro (
    id              BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten             VARCHAR(50)        NOT NULL,
    mo_ta           VARCHAR(255)       DEFAULT NULL,
    ngay_tao        TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat   TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_vai_tro_ten (ten)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Danh sach vai tro nguoi dung';

-- -----------------------------------------------------------
-- Bang: cap_do
-- Mo ta: Muc do thanh thao (TOPIK 1 den TOPIK 6)
-- -----------------------------------------------------------
CREATE TABLE cap_do (
    id              BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten             VARCHAR(20)        NOT NULL,
    mo_ta           VARCHAR(255)       DEFAULT NULL,
    thu_tu_hien_thi INT                NOT NULL,
    diem_toi_thieu  INT                DEFAULT 0,
    diem_toi_da     INT                DEFAULT 200,
    ngay_tao        TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat   TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_cap_do_ten (ten)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Cap do thanh thao TOPIK (TOPIK 1 - TOPIK 6)';

-- -----------------------------------------------------------
-- Bang: chu_de
-- Mo ta: Chu de hoc tap chung (chia lam chu_de_tu_vung va chu_de_ngu_phap)
-- -----------------------------------------------------------
CREATE TABLE chu_de (
    id              BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten             VARCHAR(100)       NOT NULL,
    mo_ta           VARCHAR(255)       DEFAULT NULL,
    hinh_anh_url    VARCHAR(255)       DEFAULT NULL,
    loai_chu_de     ENUM('TU_VUNG','NGU_PHAP') NOT NULL,
    cap_do_id       BIGINT UNSIGNED    DEFAULT NULL,
    thu_tu_hien_thi INT                DEFAULT 0,
    da_xoa          TINYINT(1)         DEFAULT 0,
    ngay_tao        TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat   TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_chu_de_ten (ten),
    KEY idx_chu_de_loai (loai_chu_de),
    KEY idx_chu_de_cap_do (cap_do_id),
    CONSTRAINT fk_chu_de_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chu de hoc tap (tu vung hoac ngu phap)';

-- ============================================================
-- 2. NGUOI DUNG
-- ============================================================

-- -----------------------------------------------------------
-- Bang: nguoi_dung
-- Mo ta: Tai khoan nguoi dung chinh
-- -----------------------------------------------------------
CREATE TABLE nguoi_dung (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten_dang_nhap       VARCHAR(50)        NOT NULL,
    email               VARCHAR(100)       NOT NULL,
    mat_khau            VARCHAR(255)       NOT NULL,
    ho_ten              VARCHAR(100)       DEFAULT '',
    ten_hien_thi        VARCHAR(100)       DEFAULT NULL,
    avatar_url          VARCHAR(255)       DEFAULT NULL,
    dia_chi             VARCHAR(200)       DEFAULT '',
    vai_tro_id          BIGINT UNSIGNED    NOT NULL,
    trang_thai          ENUM('ONLINE','OFFLINE','BI_KHOA') DEFAULT 'OFFLINE',
    lan_dang_nhap_cuoi  TIMESTAMP(6)       DEFAULT NULL,
    da_kich_hoat        TINYINT(1)         DEFAULT 1,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_nguoi_dung_ten_dang_nhap (ten_dang_nhap),
    UNIQUE KEY uk_nguoi_dung_email (email),
    KEY idx_nguoi_dung_vai_tro (vai_tro_id),
    KEY idx_nguoi_dung_trang_thai (trang_thai),
    CONSTRAINT fk_nguoi_dung_vai_tro FOREIGN KEY (vai_tro_id) REFERENCES vai_tro (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Nguoi dung chinh cua he thong';

-- ============================================================
-- 3. TU VUNG
-- ============================================================

-- -----------------------------------------------------------
-- Bang: nhom_tu_vung
-- Mo ta: Nhom/bai hoc tu vung, dong thoi la deck flashcard
-- -----------------------------------------------------------
CREATE TABLE nhom_tu_vung (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten                 VARCHAR(100)       NOT NULL,
    mo_ta               VARCHAR(255)       DEFAULT NULL,
    chu_de_id           BIGINT UNSIGNED    NOT NULL,
    cap_do_id           BIGINT UNSIGNED    NOT NULL,
    thu_tu_hien_thi    INT                DEFAULT 0,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_ntv_chu_de (chu_de_id, thu_tu_hien_thi),
    KEY idx_ntv_cap_do (cap_do_id),
    CONSTRAINT fk_ntv_chu_de FOREIGN KEY (chu_de_id) REFERENCES chu_de (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ntv_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Nhom tu vung (deck flashcard), thuoc chu de va cap do';

-- -----------------------------------------------------------
-- Bang: loai_tu
-- Mo ta: Loai tu (danh tu, dong tu, tinh tu, trang tu...)
-- -----------------------------------------------------------
CREATE TABLE loai_tu (
    id              BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten             VARCHAR(50)        NOT NULL,
    ky_hieu         VARCHAR(20)        NOT NULL,   -- N, V, ADJ, ADV...
    mo_ta           VARCHAR(255)       DEFAULT NULL,
    ngay_tao        TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat   TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_loai_tu_ten (ten),
    UNIQUE KEY uk_loai_tu_ky_hieu (ky_hieu)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Loai tu (danh tu, dong tu, tinh tu...)';

-- -----------------------------------------------------------
-- Bang: tu_vung
-- Mo ta: Tu vung co thong tin co ban
-- -----------------------------------------------------------
CREATE TABLE tu_vung (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tu                  VARCHAR(100)       NOT NULL,
    phien_am            VARCHAR(100)       DEFAULT NULL,
    nghia_chinh         VARCHAR(255)       NOT NULL,
    nghia_mo_rong       TEXT               DEFAULT NULL,
    loai_tu_id          BIGINT UNSIGNED    DEFAULT NULL,
    vi_du               TEXT               DEFAULT NULL,
    vi_du_dich          TEXT               DEFAULT NULL,
    hinh_anh_url        VARCHAR(255)       DEFAULT NULL,
    am_thanh_url        VARCHAR(255)       DEFAULT NULL,
    nhom_tu_vung_id     BIGINT UNSIGNED    NOT NULL,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_tv_tu (tu),
    KEY idx_tv_nhom (nhom_tu_vung_id),
    KEY idx_tv_loai_tu (loai_tu_id),
    CONSTRAINT fk_tv_nhom_tu_vung FOREIGN KEY (nhom_tu_vung_id) REFERENCES nhom_tu_vung (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_tv_loai_tu FOREIGN KEY (loai_tu_id) REFERENCES loai_tu (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tu vung - thong tin co ban, lien ket den nhom_tu_vung';

-- -----------------------------------------------------------
-- Bang: nghia_tu
-- Mo ta: Nghia mo rong cho tu vung da nghia (polysemous words)
-- -----------------------------------------------------------
CREATE TABLE nghia_tu (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tu_vung_id          BIGINT UNSIGNED    NOT NULL,
    nghia               VARCHAR(255)       NOT NULL,
    loai_tu_id          BIGINT UNSIGNED    DEFAULT NULL,
    cap_do_su_dung      VARCHAR(10)        DEFAULT NULL,  -- N5, N4...
    vi_du               TEXT               DEFAULT NULL,
    vi_du_dich          TEXT               DEFAULT NULL,
    thu_tu_hien_thi    INT                DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_nt_tu_vung (tu_vung_id),
    CONSTRAINT fk_nt_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_nt_loai_tu FOREIGN KEY (loai_tu_id) REFERENCES loai_tu (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Nghia mo rong cua tu vung da nghia, ho tro tich hop API tu dien';

-- ============================================================
-- 4. NGU PHAP
-- ============================================================

-- -----------------------------------------------------------
-- Bang: ngu_phap
-- Mo ta: Cau truc ngu phap Han Quoc
-- -----------------------------------------------------------
CREATE TABLE ngu_phap (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tieu_de             VARCHAR(200)       NOT NULL,
    cau_truc            TEXT               NOT NULL,
    giai_thich          TEXT               NOT NULL,
    ghi_chu            TEXT               DEFAULT NULL,
    chu_de_id           BIGINT UNSIGNED    NOT NULL,
    cap_do_id           BIGINT UNSIGNED    NOT NULL,
    thu_tu_hien_thi    INT                DEFAULT 0,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_np_chu_de (chu_de_id, thu_tu_hien_thi),
    KEY idx_np_cap_do (cap_do_id),
    CONSTRAINT fk_np_chu_de FOREIGN KEY (chu_de_id) REFERENCES chu_de (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_np_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Ngữ pháp - cau truc, giai thich, ghi chu';

-- -----------------------------------------------------------
-- Bang: vi_du_ngu_phap
-- Mo ta: Vi du cho tung muc ngu phap
-- -----------------------------------------------------------
CREATE TABLE vi_du_ngu_phap (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ngu_phap_id         BIGINT UNSIGNED    NOT NULL,
    vi_du               TEXT               NOT NULL,
    dich_nghia          TEXT               NOT NULL,
    am_thanh_url        VARCHAR(255)       DEFAULT NULL,
    thu_tu_hien_thi    INT                DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_vnp_ngu_phap (ngu_phap_id),
    CONSTRAINT fk_vnp_ngu_phap FOREIGN KEY (ngu_phap_id) REFERENCES ngu_phap (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Vi du cho tung muc ngu phap';

-- ============================================================
-- 5. DE THI TOPIK
-- -----------------------------------------------------------
-- Cau truc: de_thi -> phan_thi -> cau_hoi
-- ============================================================

-- -----------------------------------------------------------
-- Bang: de_thi
-- Mo ta: De thi TOPIK hoan chinh
-- -----------------------------------------------------------
CREATE TABLE de_thi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tieu_de             VARCHAR(200)       NOT NULL,
    mo_ta               TEXT               DEFAULT NULL,
    cap_do_id           BIGINT UNSIGNED    NOT NULL,
    loai_de             ENUM('TOPIK_1','TOPIK_2','LUYEN_TAP') NOT NULL,
    thoi_gian_phut      INT                DEFAULT 60,
    tong_cau_hoi        INT                DEFAULT 0,
    diem_toi_da         INT                DEFAULT 200,
    trang_thai          ENUM('DANG_HOAT_DONG','DUNG','LUU_TRU') DEFAULT 'DANG_HOAT_DONG',
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_dt_cap_do (cap_do_id),
    KEY idx_dt_loai (loai_de),
    CONSTRAINT fk_dt_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='De thi TOPIK hoan chinh';

-- -----------------------------------------------------------
-- Bang: phan_thi
-- Mo ta: Phan thi trong de thi (Nghe, Doc, Viet, Noi)
-- -----------------------------------------------------------
CREATE TABLE phan_thi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    de_thi_id           BIGINT UNSIGNED    NOT NULL,
    ten                 VARCHAR(100)       NOT NULL,
    ky_nang             ENUM('NGHE','DOC','VIET','NOI') NOT NULL,
    cau_so              INT                NOT NULL,
    cau_den             INT                NOT NULL,
    thu_tu_hien_thi     INT                DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_pt_de_thi (de_thi_id, thu_tu_hien_thi),
    CONSTRAINT fk_pt_de_thi FOREIGN KEY (de_thi_id) REFERENCES de_thi (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Phan thi trong de TOPIK (Nghe, Doc, Viet, Noi)';

-- ============================================================
-- 6. BO CAU HOI & CAU HOI
-- ============================================================

-- -----------------------------------------------------------
-- Bang: bo_cau_hoi
-- Mo ta: Bo cau hoi trắc nghiệm, co the lien ket voi chu de, ngu phap, phan thi
-- -----------------------------------------------------------
CREATE TABLE bo_cau_hoi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tieu_de             VARCHAR(100)       NOT NULL,
    mo_ta               VARCHAR(255)       DEFAULT NULL,
    chu_de_id           BIGINT UNSIGNED    DEFAULT NULL,
    ngu_phap_id         BIGINT UNSIGNED    DEFAULT NULL,
    phan_thi_id         BIGINT UNSIGNED    DEFAULT NULL,
    cap_do_id           BIGINT UNSIGNED    DEFAULT NULL,
    loai_bo_cau_hoi     ENUM('TRAC_NGHIEM','NGHE','DIEU_CHINH_TA','TU_VIET') DEFAULT 'TRAC_NGHIEM',
    do_kho              ENUM('DE','TRUNG_BINH','KHO') DEFAULT 'TRUNG_BINH',
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_bch_chu_de (chu_de_id),
    KEY idx_bch_ngu_phap (ngu_phap_id),
    KEY idx_bch_phan_thi (phan_thi_id),
    KEY idx_bch_cap_do (cap_do_id),
    CONSTRAINT fk_bch_chu_de FOREIGN KEY (chu_de_id) REFERENCES chu_de (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_bch_ngu_phap FOREIGN KEY (ngu_phap_id) REFERENCES ngu_phap (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_bch_phan_thi FOREIGN KEY (phan_thi_id) REFERENCES phan_thi (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_bch_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Bo cau hoi trac nghiem, co the gan voi chu de hoac ngu phap';

-- -----------------------------------------------------------
-- Bang: cau_hoi
-- Mo ta: Tung cau hoi trắc nghiệm 4 lua chon
-- -----------------------------------------------------------
CREATE TABLE cau_hoi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    bo_cau_hoi_id       BIGINT UNSIGNED    NOT NULL,
    noi_dung            TEXT               NOT NULL,
    loai_noi_dung       ENUM('VAN_BAN','HINH_ANH','AM_THANH','VIDEO') DEFAULT 'VAN_BAN',
    duong_dan_tep       VARCHAR(255)       DEFAULT NULL,
    lua_chon_a          VARCHAR(255)       NOT NULL,
    lua_chon_b          VARCHAR(255)       NOT NULL,
    lua_chon_c          VARCHAR(255)       NOT NULL,
    lua_chon_d          VARCHAR(255)       NOT NULL,
    dap_an_dung         CHAR(1)            NOT NULL,
    giai_thich          TEXT               DEFAULT NULL,
    do_kho              ENUM('DE','TRUNG_BINH','KHO') DEFAULT 'TRUNG_BINH',
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_ch_bo_cau_hoi (bo_cau_hoi_id),
    KEY idx_ch_do_kho (do_kho),
    CONSTRAINT fk_ch_bo_cau_hoi FOREIGN KEY (bo_cau_hoi_id) REFERENCES bo_cau_hoi (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_ch_dap_an CHECK (dap_an_dung IN ('A','B','C','D'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Cau hoi trac nghiem 4 lua chon';

-- ============================================================
-- 7. BAI HOC
-- ============================================================

-- -----------------------------------------------------------
-- Bang: bai_hoc
-- Mo ta: Bai hoc hoan chinh (ly thuyết + luyen tap)
-- -----------------------------------------------------------
CREATE TABLE bai_hoc (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tieu_de             VARCHAR(200)       NOT NULL,
    mo_ta               TEXT               DEFAULT NULL,
    hinh_anh_url        VARCHAR(255)       DEFAULT NULL,
    chu_de_id           BIGINT UNSIGNED    NOT NULL,
    cap_do_id           BIGINT UNSIGNED    DEFAULT NULL,
    trang_thai          ENUM('NHAP','DANG_HOAT_DONG','LUU_TRU') DEFAULT 'NHAP',
    thu_tu_hien_thi     INT                DEFAULT 0,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_bh_chu_de (chu_de_id),
    KEY idx_bh_cap_do (cap_do_id),
    KEY idx_bh_loc (chu_de_id, trang_thai, da_xoa, thu_tu_hien_thi),
    CONSTRAINT fk_bh_chu_de FOREIGN KEY (chu_de_id) REFERENCES chu_de (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_bh_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Bai hoc hoan chinh thuoc chu de';

-- -----------------------------------------------------------
-- Bang: bai_hoc_bo_cau_hoi
-- Mo ta: Bang trung gian: bai hoc nao co nhung bo cau hoi nao
-- -----------------------------------------------------------
CREATE TABLE bai_hoc_bo_cau_hoi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    bai_hoc_id          BIGINT UNSIGNED    NOT NULL,
    bo_cau_hoi_id       BIGINT UNSIGNED    NOT NULL,
    thu_tu_hien_thi     INT                NOT NULL,
    la_bat_buoc         TINYINT(1)         DEFAULT 1,
    diem_toi_thieu       INT                DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_bh_bch (bai_hoc_id, thu_tu_hien_thi),
    KEY idx_bh_bch_bo (bo_cau_hoi_id),
    CONSTRAINT fk_bh_bch_bai_hoc FOREIGN KEY (bai_hoc_id) REFERENCES bai_hoc (id) ON DELETE CASCADE,
    CONSTRAINT fk_bh_bch_bo_cau_hoi FOREIGN KEY (bo_cau_hoi_id) REFERENCES bo_cau_hoi (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Bang trung gian: bai hoc chua nhung bo cau hoi nao';

-- ============================================================
-- 8. LUYEN TAP
-- ============================================================

-- -----------------------------------------------------------
-- Bang: phien_luyen_tap
-- Mo ta: Mot lan luyen tap hoan chinh (co the tu nguon: TU_VUNG, NGU_PHAP, BAI_HOC, LO_TRINH...)
-- -----------------------------------------------------------
CREATE TABLE phien_luyen_tap (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id       BIGINT UNSIGNED    NOT NULL,
    bo_cau_hoi_id       BIGINT UNSIGNED    NOT NULL,
    loai_nguon          ENUM('TU_DO','TU_VUNG','NGU_PHAP','BAI_HOC','LO_TRINH') NOT NULL DEFAULT 'TU_DO',
    nguon_id            BIGINT UNSIGNED    DEFAULT NULL,
    tong_cau_hoi        INT                NOT NULL,
    so_cau_dung         INT                NOT NULL,
    do_chinh_xac        DECIMAL(5,2)       NOT NULL,
    diem_so             INT                DEFAULT 0,
    thoi_gian_trung_binh_ms INT            DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_plt_nguoi_dung (nguoi_dung_id),
    KEY idx_plt_bo_cau_hoi (bo_cau_hoi_id),
    KEY idx_plt_nguon (loai_nguon, nguon_id),
    CONSTRAINT fk_plt_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_plt_bo_cau_hoi FOREIGN KEY (bo_cau_hoi_id) REFERENCES bo_cau_hoi (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Phien luyen tap - ghi nhan 1 lan lam bai';

-- -----------------------------------------------------------
-- Bang: tra_loi
-- Mo ta: Chi tiet tung cau tra loi trong phien luyen tap
-- -----------------------------------------------------------
CREATE TABLE tra_loi (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    phien_luyen_tap_id  BIGINT UNSIGNED    NOT NULL,
    cau_hoi_id          BIGINT UNSIGNED    NOT NULL,
    lua_chon            CHAR(1)            DEFAULT NULL,
    dung_hay_sai         TINYINT(1)         NOT NULL,
    thoi_gian_ms        INT                DEFAULT NULL,
    duoc_ghi_nho        TINYINT(1)         DEFAULT 0,
    ngay_tra_loi        TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_tl_phien (phien_luyen_tap_id),
    KEY idx_tl_cau_hoi (cau_hoi_id),
    KEY idx_tl_ghi_nho (phien_luyen_tap_id, duoc_ghi_nho),
    CONSTRAINT fk_tl_phien_luyen_tap FOREIGN KEY (phien_luyen_tap_id) REFERENCES phien_luyen_tap (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tl_cau_hoi FOREIGN KEY (cau_hoi_id) REFERENCES cau_hoi (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chi tiet tung cau tra loi trong phien luyen tap';

-- ============================================================
-- 9. TIEN DO HOC TAP
-- ============================================================

-- -----------------------------------------------------------
-- Bang: tien_do_tu_vung
-- Mo ta: Tien do hoc tu vung cua tung nguoi dung, tich hop thuat toan SRS SM-2
-- -----------------------------------------------------------
CREATE TABLE tien_do_tu_vung (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    tu_vung_id             BIGINT UNSIGNED    NOT NULL,
    trang_thai              ENUM('CHUA_HOC','DANG_HOC','DA_THUAN') DEFAULT 'CHUA_HOC',
    so_lan_dung            INT                DEFAULT 0,
    so_lan_sai             INT                DEFAULT 0,
    khoang_lap_ngay        INT                DEFAULT 1,
    he_so_de               DECIMAL(4,2)       DEFAULT 2.50,
    so_lan_lien_tiep_dung  INT                DEFAULT 0,
    lan_on_tiep_theo       TIMESTAMP(6)       DEFAULT NULL,
    ngay_cap_nhat          TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_tdtv_nguoi_tu (nguoi_dung_id, tu_vung_id),
    KEY idx_tdtv_nguoi (nguoi_dung_id),
    KEY idx_tdtv_on_tap (nguoi_dung_id, lan_on_tiep_theo),
    KEY idx_tdtv_trang_thai (nguoi_dung_id, trang_thai),
    CONSTRAINT fk_tdtv_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tdtv_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tien do hoc tu vung - thuat toan SRS SM-2';

-- -----------------------------------------------------------
-- Bang: tien_do_ngu_phap
-- Mo ta: Tien do hoc ngu phap cua tung nguoi dung
-- -----------------------------------------------------------
CREATE TABLE tien_do_ngu_phap (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id       BIGINT UNSIGNED    NOT NULL,
    ngu_phap_id         BIGINT UNSIGNED    NOT NULL,
    da_hoc              TINYINT(1)         DEFAULT 0,
    so_lan_luyen        INT                DEFAULT 0,
    so_lan_dung         INT                DEFAULT 0,
    lan_on_gan_nhat     TIMESTAMP(6)       DEFAULT NULL,
    ngay_cap_nhat       TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_tdnp_nguoi_ngu (nguoi_dung_id, ngu_phap_id),
    KEY idx_tdnp_nguoi (nguoi_dung_id),
    CONSTRAINT fk_tdnp_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tdnp_ngu_phap FOREIGN KEY (ngu_phap_id) REFERENCES ngu_phap (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tien do hoc ngu phap - danh dau da hoc';

-- ============================================================
-- 10. LỘ TRÌNH HỌC
-- ============================================================

-- -----------------------------------------------------------
-- Bang: lo_trinh_hoc
-- Mo ta: Mau lo trinh hoc tap (VD: TOPIK 1 -> TOPIK 3 trong 12 tuan)
-- -----------------------------------------------------------
CREATE TABLE lo_trinh_hoc (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten                     VARCHAR(200)       NOT NULL,
    mo_ta                   TEXT               DEFAULT NULL,
    cap_do_bat_dau_id       BIGINT UNSIGNED    NOT NULL,
    cap_do_ket_thuc_id      BIGINT UNSIGNED    NOT NULL,
    tong_tuan               INT                NOT NULL,
    so_phut_moi_ngay        INT                DEFAULT 30,
    da_xoa                  TINYINT(1)         DEFAULT 0,
    ngay_tao                TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat           TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_lth_cap_bat_dau (cap_do_bat_dau_id),
    CONSTRAINT fk_lth_cap_bat_dau FOREIGN KEY (cap_do_bat_dau_id) REFERENCES cap_do (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_lth_cap_ket_thuc FOREIGN KEY (cap_do_ket_thuc_id) REFERENCES cap_do (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Mau lo trinh hoc tap';

-- -----------------------------------------------------------
-- Bang: lo_trinh_nguoi_dung
-- Mo ta: Nguoi dung dang ky mot lo trinh cu the
-- -----------------------------------------------------------
CREATE TABLE lo_trinh_nguoi_dung (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    lo_trinh_hoc_id         BIGINT UNSIGNED    NOT NULL,
    diem_phan_loai          INT                DEFAULT NULL,
    ngay_bat_dau            DATE               NOT NULL,
    ngay_ket_thuc_du_kien  DATE               NOT NULL,
    trang_thai              ENUM('DANG_HOC','HOAN_THANH','BO_CUOC') DEFAULT 'DANG_HOC',
    ngay_tao                TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat           TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_lnd_nguoi_lo_trinh (nguoi_dung_id, lo_trinh_hoc_id),
    KEY idx_lnd_nguoi (nguoi_dung_id, trang_thai),
    KEY idx_lnd_lo_trinh (lo_trinh_hoc_id),
    CONSTRAINT fk_lnd_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_lnd_lo_trinh FOREIGN KEY (lo_trinh_hoc_id) REFERENCES lo_trinh_hoc (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Nguoi dung dang ky lo trinh hoc';

-- -----------------------------------------------------------
-- Bang: chi_tiet_lo_trinh
-- Mo ta: Chi tiet tung ngay trong lo trinh (bai hoc, bo cau hoi)
-- -----------------------------------------------------------
CREATE TABLE chi_tiet_lo_trinh (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    lo_trinh_hoc_id         BIGINT UNSIGNED    NOT NULL,
    bai_hoc_id             BIGINT UNSIGNED    DEFAULT NULL,
    so_ngay                INT                NOT NULL,
    loai_hoat_dong          ENUM('LUYEN_TAP','DANH_GIA','THI_THU') DEFAULT 'LUYEN_TAP',
    bo_cau_hoi_id          BIGINT UNSIGNED    NOT NULL,
    so_cau_hoi             INT                DEFAULT 15,
    muc_tieu_diem          INT                DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_ctlt_lo_ngay_bo (lo_trinh_hoc_id, so_ngay, bo_cau_hoi_id),
    KEY idx_ctlt_lo_trinh (lo_trinh_hoc_id, so_ngay),
    KEY idx_ctlt_bo_cau_hoi (bo_cau_hoi_id),
    KEY idx_ctlt_bai_hoc (bai_hoc_id),
    CONSTRAINT fk_ctlt_lo_trinh FOREIGN KEY (lo_trinh_hoc_id) REFERENCES lo_trinh_hoc (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ctlt_bai_hoc FOREIGN KEY (bai_hoc_id) REFERENCES bai_hoc (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ctlt_bo_cau_hoi FOREIGN KEY (bo_cau_hoi_id) REFERENCES bo_cau_hoi (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chi tiet tung ngay trong lo trinh';

-- ============================================================
-- 11. FLASHCARD
-- ============================================================

-- -----------------------------------------------------------
-- Bang: nhom_flashcard
-- Mo ta: Deck flashcard tuy chinh cua nguoi dung
-- -----------------------------------------------------------
CREATE TABLE nhom_flashcard (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id       BIGINT UNSIGNED    NOT NULL,
    ten                 VARCHAR(100)       NOT NULL,
    mo_ta               VARCHAR(255)       DEFAULT NULL,
    la_cong_khai        TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_nf_nguoi_ten (nguoi_dung_id, ten),
    KEY idx_nf_nguoi (nguoi_dung_id),
    CONSTRAINT fk_nf_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Deck flashcard tuy chinh cua nguoi dung';

-- -----------------------------------------------------------
-- Bang: chi_tiet_flashcard
-- Mo ta: Chi tiet tu vung trong flashcard tuy chinh
-- -----------------------------------------------------------
CREATE TABLE chi_tiet_flashcard (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nhom_flashcard_id   BIGINT UNSIGNED    NOT NULL,
    tu_vung_id          BIGINT UNSIGNED    NOT NULL,
    nhom_tu_vung_goc_id BIGINT UNSIGNED    DEFAULT NULL,
    thu_tu_hien_thi     INT                DEFAULT 0,
    ngay_them           TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_ctf_nhom_tu (nhom_flashcard_id, tu_vung_id),
    KEY idx_ctf_tu_vung (tu_vung_id),
    CONSTRAINT fk_ctf_nhom_flashcard FOREIGN KEY (nhom_flashcard_id) REFERENCES nhom_flashcard (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ctf_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ctf_nhom_goc FOREIGN KEY (nhom_tu_vung_goc_id) REFERENCES nhom_tu_vung (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chi tiet tu vung trong deck flashcard tuy chinh';

-- -----------------------------------------------------------
-- Bang: phien_flashcard
-- Mo ta: Mot phien hoc flashcard
-- -----------------------------------------------------------
CREATE TABLE phien_flashcard (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    nhom_tu_vung_id         BIGINT UNSIGNED    NOT NULL,
    nhom_flashcard_id       BIGINT UNSIGNED    DEFAULT NULL,
    tong_the                 INT                NOT NULL,
    so_the_biet             INT                DEFAULT 0,
    so_the_kho              INT                DEFAULT 0,
    so_the_khong_biet       INT                DEFAULT 0,
    thoi_gian_ms            INT                DEFAULT 0,
    ngay_tao                TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_pf_nguoi (nguoi_dung_id),
    KEY idx_pf_nhom_tu (nhom_tu_vung_id),
    KEY idx_pf_nhom_flashcard (nhom_flashcard_id),
    CONSTRAINT fk_pf_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pf_nhom_tu_vung FOREIGN KEY (nhom_tu_vung_id) REFERENCES nhom_tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pf_nhom_flashcard FOREIGN KEY (nhom_flashcard_id) REFERENCES nhom_flashcard (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Phien hoc flashcard';

-- -----------------------------------------------------------
-- Bang: ket_qua_flashcard
-- Mo ta: Ket qua tung the trong phien flashcard
-- -----------------------------------------------------------
CREATE TABLE ket_qua_flashcard (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    phien_flashcard_id  BIGINT UNSIGNED    NOT NULL,
    tu_vung_id          BIGINT UNSIGNED    NOT NULL,
    danh_gia            ENUM('BIET','KHO','KHONG_BIET') NOT NULL,
    thoi_gian_ms        INT                DEFAULT NULL,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_kqf_phien (phien_flashcard_id),
    KEY idx_kqf_tu_vung (tu_vung_id),
    CONSTRAINT fk_kqf_phien FOREIGN KEY (phien_flashcard_id) REFERENCES phien_flashcard (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_kqf_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Ket qua tung the trong phien flashcard';

-- ============================================================
-- 12. LICH SU HOC & STREAK
-- ============================================================

-- -----------------------------------------------------------
-- Bang: lich_su_ngay
-- Mo ta: Tong hop lich su hoc hang ngay cua nguoi dung
-- -----------------------------------------------------------
CREATE TABLE lich_su_ngay (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    ngay_hoc                DATE               NOT NULL,
    so_phien_luyen          INT                DEFAULT 0,
    so_phien_flashcard      INT                DEFAULT 0,
    so_tu_vung_on_tap       INT                DEFAULT 0,
    so_ngu_phap_on_tap      INT                DEFAULT 0,
    tong_thoi_gian_phut     INT                DEFAULT 0,
    diem_trung_binh         DECIMAL(5,2)       DEFAULT 0,
    ngay_tao                TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat           TIMESTAMP(6)      DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_lsn_nguoi_ngay (nguoi_dung_id, ngay_hoc),
    KEY idx_lsn_nguoi (nguoi_dung_id),
    KEY idx_lsn_ngay (ngay_hoc),
    CONSTRAINT fk_lsn_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Lich su hoc hang ngay - tong hop nhe';

-- -----------------------------------------------------------
-- Bang: streak
-- Mo ta: Theo doi chuoi ngay hoc lien tiep
-- -----------------------------------------------------------
CREATE TABLE streak (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    chuoi_hien_tai          INT                DEFAULT 0,
    chuoi_dai_nhat          INT                DEFAULT 0,
    ngay_hoat_dong_cuoi     DATE               DEFAULT NULL,
    tong_ngay_hoat_dong      INT                DEFAULT 0,
    ngay_cap_nhat           TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_s_nguoi (nguoi_dung_id),
    CONSTRAINT fk_s_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chuoi ngay hoc lien tiep (streak)';

-- ============================================================
-- 13. AI PHAN TICH
-- ============================================================

-- -----------------------------------------------------------
-- Bang: phan_tich_ai
-- Mo ta: Ket qua phan tich hoc tap bang AI
-- -----------------------------------------------------------
CREATE TABLE phan_tich_ai (
    id                      BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id           BIGINT UNSIGNED    NOT NULL,
    loai_phan_tich          ENUM('TU_VUNG','NGU_PHAP','TOAN_DIEN') NOT NULL,
    -- Tong quan
    tong_tu_da_hoc          INT                DEFAULT 0,
    tong_ngu_phap_da_hoc    INT                DEFAULT 0,
    diem_trung_binh         DECIMAL(5,2)       DEFAULT 0,
    so_ngay_diem_thap       INT                DEFAULT 0,
    -- Chi tiet (dinh dang JSON)
    diem_yeu_tu_vung        TEXT               DEFAULT NULL,
    diem_yeu_ngu_phap       TEXT               DEFAULT NULL,
    loi_mac_dinh            TEXT               DEFAULT NULL,
    goi_y_on_tap            TEXT               DEFAULT NULL,
    noi_dung_phan_tich      TEXT               NOT NULL,
    ngay_tao                TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_ptai_nguoi (nguoi_dung_id, ngay_tao DESC),
    KEY idx_ptai_loai (loai_phan_tich),
    CONSTRAINT fk_ptai_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Ket qua phan tich hoc tap bang AI';

-- ============================================================
-- 15. LUYEN KY NANG (NOI/NGHE)
-- ============================================================

-- -----------------------------------------------------------
-- Bang: ket_qua_ky_nang
-- Mo ta: Ket qua luyen ky nang Noi va Nghe co AI cham diem
-- -----------------------------------------------------------
CREATE TABLE ket_qua_ky_nang (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id       BIGINT UNSIGNED    NOT NULL,
    tu_vung_id          BIGINT UNSIGNED    NOT NULL,
    loai_ky_nang        ENUM('NOI','NGHE') NOT NULL,
    file_audio_url      VARCHAR(255)       DEFAULT NULL,
    diem_phat_am        DECIMAL(4,2)       DEFAULT NULL,
    nhan_xet_ai         TEXT               DEFAULT NULL,
    cau_tra_loi         VARCHAR(255)       DEFAULT NULL,
    dung_hay_sai        TINYINT(1)         DEFAULT NULL,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_kqkn_nguoi_loai (nguoi_dung_id, loai_ky_nang),
    KEY idx_kqkn_tu_vung (tu_vung_id),
    CONSTRAINT fk_kqkn_nguoi_dung FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_kqkn_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Ket qua luyen Noi/Nghe co cham diem bang AI';

CREATE TABLE chu_de_tu_vung (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten                 VARCHAR(100)       NOT NULL,
    mo_ta               VARCHAR(255)       DEFAULT NULL,
    hinh_anh_url        VARCHAR(255)       DEFAULT NULL,
    cap_do_id           BIGINT UNSIGNED    DEFAULT NULL,
    thu_tu_hien_thi     INT                DEFAULT 0,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_cdtv_ten (ten),
    KEY idx_cdtv_cap_do (cap_do_id),
    KEY idx_cdtv_thu_tu (da_xoa, thu_tu_hien_thi),
    CONSTRAINT fk_cdtv_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chu de hoc tu vung';


CREATE TABLE chu_de_ngu_phap (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    ten                 VARCHAR(100)       NOT NULL,
    mo_ta               VARCHAR(255)       DEFAULT NULL,
    hinh_anh_url        VARCHAR(255)       DEFAULT NULL,
    cap_do_id           BIGINT UNSIGNED    DEFAULT NULL,
    thu_tu_hien_thi     INT                DEFAULT 0,
    da_xoa              TINYINT(1)         DEFAULT 0,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    ngay_cap_nhat       TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_cdnp_ten (ten),
    KEY idx_cdnp_cap_do (cap_do_id),
    KEY idx_cdnp_thu_tu (da_xoa, thu_tu_hien_thi),
    CONSTRAINT fk_cdnp_cap_do FOREIGN KEY (cap_do_id) REFERENCES cap_do (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Chu de hoc ngu phap';


ALTER TABLE nhom_tu_vung
    ADD COLUMN chu_de_tu_vung_id BIGINT UNSIGNED DEFAULT NULL AFTER chu_de_id;
SET SQL_SAFE_UPDATES = 0;
UPDATE nhom_tu_vung ntv
JOIN chu_de_tu_vung cdtv ON cdtv.id = ntv.chu_de_id
SET ntv.chu_de_tu_vung_id = cdtv.id;

ALTER TABLE nhom_tu_vung
    DROP FOREIGN KEY fk_ntv_chu_de,
    DROP COLUMN chu_de_id,
    ADD CONSTRAINT fk_ntv_chu_de_tu_vung FOREIGN KEY (chu_de_tu_vung_id) REFERENCES chu_de_tu_vung (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD KEY idx_ntv_chu_de_tv (chu_de_tu_vung_id);


ALTER TABLE ngu_phap
    ADD COLUMN chu_de_ngu_phap_id BIGINT UNSIGNED DEFAULT NULL AFTER chu_de_id;

UPDATE ngu_phap np
JOIN chu_de_ngu_phap cdnp ON cdnp.id = np.chu_de_id
SET np.chu_de_ngu_phap_id = cdnp.id;

ALTER TABLE ngu_phap
    DROP FOREIGN KEY fk_np_chu_de,
    DROP COLUMN chu_de_id,
    ADD CONSTRAINT fk_np_chu_de_ngu_phap FOREIGN KEY (chu_de_ngu_phap_id) REFERENCES chu_de_ngu_phap (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD KEY idx_np_chu_de_np (chu_de_ngu_phap_id);


ALTER TABLE bo_cau_hoi
    ADD COLUMN chu_de_tu_vung_id BIGINT UNSIGNED DEFAULT NULL AFTER mo_ta;

UPDATE bo_cau_hoi bch
JOIN chu_de_tu_vung cdtv ON cdtv.id = bch.chu_de_id
SET bch.chu_de_tu_vung_id = cdtv.id;

ALTER TABLE bo_cau_hoi
    DROP FOREIGN KEY fk_bch_chu_de,
    DROP COLUMN chu_de_id,
    ADD CONSTRAINT fk_bch_chu_de_tu_vung FOREIGN KEY (chu_de_tu_vung_id) REFERENCES chu_de_tu_vung (id) ON DELETE SET NULL ON UPDATE CASCADE,
    ADD KEY idx_bch_chu_de_tv (chu_de_tu_vung_id);


ALTER TABLE bai_hoc
    ADD COLUMN chu_de_tu_vung_id BIGINT UNSIGNED DEFAULT NULL AFTER mo_ta;

UPDATE bai_hoc bh
JOIN chu_de_tu_vung cdtv ON cdtv.id = bh.chu_de_id
SET bh.chu_de_tu_vung_id = cdtv.id;

ALTER TABLE bai_hoc
    DROP FOREIGN KEY fk_bh_chu_de,
    DROP COLUMN chu_de_id,
    ADD CONSTRAINT fk_bh_chu_de_tu_vung FOREIGN KEY (chu_de_tu_vung_id) REFERENCES chu_de_tu_vung (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD KEY idx_bh_chu_de_tv (chu_de_tu_vung_id);


DROP TABLE chu_de;

ALTER TABLE chu_de_tu_vung
    DROP FOREIGN KEY fk_cdtv_cap_do,
    DROP COLUMN cap_do_id,
    DROP KEY idx_cdtv_cap_do;

ALTER TABLE chu_de_ngu_phap
    DROP FOREIGN KEY fk_cdnp_cap_do,
    DROP COLUMN cap_do_id,
	DROP KEY idx_cdnp_cap_do;
    
ALTER TABLE bai_hoc
    DROP FOREIGN KEY fk_bh_chu_de_tu_vung,
    DROP COLUMN chu_de_tu_vung_id;
    
RENAME TABLE chu_de_ngu_phap TO dang_ngu_phap;


-- ============================================================
-- 2. Cap nhat khoa ngoai trong bang ngu_phap
-- ============================================================
ALTER TABLE ngu_phap
    DROP FOREIGN KEY fk_np_chu_de_ngu_phap,
    DROP KEY idx_np_chu_de_np,
    CHANGE COLUMN chu_de_ngu_phap_id dang_ngu_phap_id BIGINT UNSIGNED DEFAULT NULL,
    ADD CONSTRAINT fk_np_dang_ngu_phap FOREIGN KEY (dang_ngu_phap_id) REFERENCES dang_ngu_phap (id) ON DELETE SET NULL ON UPDATE CASCADE,
    ADD KEY idx_np_dang_ngu_phap (dang_ngu_phap_id);

CREATE TABLE tu_vung_loai_tu (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    tu_vung_id          BIGINT UNSIGNED    NOT NULL,
    loai_tu_id          BIGINT UNSIGNED    NOT NULL,
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_tvlt_tv_loai (tu_vung_id, loai_tu_id),
    KEY idx_tvlt_loai_tu (loai_tu_id),
    CONSTRAINT fk_tvlt_tu_vung FOREIGN KEY (tu_vung_id) REFERENCES tu_vung (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tvlt_loai_tu FOREIGN KEY (loai_tu_id) REFERENCES loai_tu (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Bang trung gian: tu vung co the co nhieu loai tu';


-- ============================================================
-- 2. Cap nhat bang nghia_tu: nghia gắn với loại từ cụ thể
-- ============================================================
ALTER TABLE nghia_tu
    DROP FOREIGN KEY fk_nt_tu_vung,
    DROP FOREIGN KEY fk_nt_loai_tu,   -- ✅ Đây là nơi DUY NHẤT để drop
    DROP COLUMN tu_vung_id,
    DROP COLUMN loai_tu_id,
    ADD COLUMN tu_vung_loai_tu_id BIGINT UNSIGNED NOT NULL AFTER id,
    ADD KEY idx_nt_tu_vung_loai_tu (tu_vung_loai_tu_id),
    ADD CONSTRAINT fk_nt_tu_vung_loai_tu FOREIGN KEY (tu_vung_loai_tu_id)
        REFERENCES tu_vung_loai_tu (id) ON DELETE CASCADE ON UPDATE CASCADE;


-- ============================================================
-- 3. Xoa cot loai_tu_id cu khoi tu_vung (da chuyen sang bang trung gian)
-- ============================================================
ALTER TABLE tu_vung
    DROP FOREIGN KEY fk_tv_loai_tu,
    DROP COLUMN loai_tu_id;
    
DROP TABLE IF EXISTS chi_tiet_flashcard;
DROP TABLE IF EXISTS nhom_flashcard;


-- ============================================================
-- Don gian phien_flashcard
-- ============================================================
ALTER TABLE phien_flashcard
    DROP FOREIGN KEY fk_pf_nhom_flashcard,
    DROP COLUMN nhom_flashcard_id;


-- ============================================================
-- Don gian ket_qua_flashcard
-- ============================================================
 
ALTER TABLE tu_vung
    DROP COLUMN nghia_mo_rong;

-- ============================================================
-- SEED DATA: Du lieu ban dau
-- ============================================================

-- Vai tro
INSERT INTO vai_tro (ten, mo_ta) VALUES
('ADMIN',    'Quan tri he thong'),
('NGUOI_DUNG', 'Nguoi dung thong thuong');

-- Cap do
INSERT INTO cap_do (ten, mo_ta, thu_tu_hien_thi, diem_toi_thieu, diem_toi_da) VALUES
('TOPIK 1', 'So cap TOPIK 1 - Nguoi moi bat dau', 1,   0, 200),
('TOPIK 2', 'So cap TOPIK 2',                        2, 140, 200),
('TOPIK 3', 'Trung cap TOPIK 3',                      3, 120, 300),
('TOPIK 4', 'Trung cap TOPIK 4',                      4, 150, 300),
('TOPIK 5', 'Cao cap TOPIK 5',                        5, 190, 300),
('TOPIK 6', 'Cao nhat TOPIK 6',                       6,  230, 300);

-- Loai tu
INSERT INTO loai_tu (ten, ky_hieu, mo_ta) VALUES
('Danh tu',     'N',  'Danh tu (Noun)'),
('Dong tu',     'V',  'Dong tu (Verb)'),
('Tinh tu',     'ADJ','Tinh tu (Adjective)'),
('Trang tu',    'ADV','Trang tu (Adverb)'),
('So tu',       'NUM','So tu (Numeral)'),
('Dong chi',    'PRON','Dong chi (Pronoun)'),
('Trong tu',    'PART','Trong tu (Particle)'),
('Thu nguyen',  'AFF','Thu nguyen (Affix)');

SET FOREIGN_KEY_CHECKS = 1;
