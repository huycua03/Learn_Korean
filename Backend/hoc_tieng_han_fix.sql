-- ============================================================
-- FILE: hoc_tieng_han_fix.sql
-- Mo ta: Fix cac van de phat hien trong review schema
--         + Bo sung cac bang/column con thieu
-- Phiên ban: v1.2
-- Ghi chu:
--   - Chay file nay SAU hoc_tieng_han.sql goc
--   - Danh cho muc dich: dev + export nop bao cao
--   - Cac bang/feature nho (binh luan, yeu thich...) da loai bo
-- ============================================================
USE hoc_tieng_han;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ============================================================
-- FIX C17: Orphan FK o bang bai_hoc
-- Van de: bai_hoc con co FK fk_bh_chu_de_tu_vung
--         nhung chu_de_tu_vung_id da bi DROP
--         -> MySQL se bao loi khi tao table
-- Giai phap: DROP constraint truoc, sau do drop column
-- ============================================================
ALTER TABLE bai_hoc
    DROP FOREIGN KEY IF EXISTS fk_bh_chu_de_tu_vung;

-- Cac bang da bi DROP (chi can tao lai neu can, bo qua neu khong dung):
--   nhom_flashcard, chi_tiet_flashcard -> LOAI BO (sinh flashcard tu nhom_tu_vung)


-- ============================================================
-- FIX C15: Bo sung mat_khau_salt
-- Password trong DB luc nay van la raw string
-- Spring Security se dung BCrypt(password + salt) -> luu vao mat_khau
-- mat_khau_salt co the dung lam pepper field hoac loai bo sau
-- ============================================================
ALTER TABLE nguoi_dung
    ADD COLUMN mat_khau_salt VARCHAR(32) DEFAULT NULL
    AFTER mat_khau;


-- ============================================================
-- FIX I14: Sua ENUM trang_thai nguoi_dung
-- ONLINE/OFFLINE khong phu hop lam trang thai tai khoan
-- ENUM cu: ONLINE, OFFLINE, BI_KHOA
-- ENUM moi: ACTIVE, INACTIVE, BANNED
-- ============================================================
ALTER TABLE nguoi_dung
    MODIFY COLUMN trang_thai ENUM('ACTIVE','INACTIVE','BANNED') DEFAULT 'ACTIVE';


-- ============================================================
-- FIX I11: Them FK phan_thi_id vao cau_hoi
-- Moi cau hoi thuoc ve 1 phan thi cu the (Nghe hoac Doc)
-- VD: cau_hoi.nghe_cua_phan_thi(phan_thi.ky_nang = 'NGHE')
-- Giup loc cau hoi theo phan thi chinh xac, khong phu thuoc cau_so thu cong
-- ============================================================
ALTER TABLE cau_hoi
    ADD COLUMN phan_thi_id BIGINT UNSIGNED DEFAULT NULL
    AFTER do_kho;

ALTER TABLE cau_hoi
    ADD KEY idx_ch_phan_thi (phan_thi_id);

ALTER TABLE cau_hoi
    ADD CONSTRAINT fk_ch_phan_thi
        FOREIGN KEY (phan_thi_id) REFERENCES phan_thi (id)
        ON DELETE SET NULL ON UPDATE CASCADE;


-- ============================================================
-- FIX I9: Them FULLTEXT INDEX cho tim kiem tu vung / ngu phap
-- Khi nguoi dung search tu Hanqu, phien am, hoac nghia
-- Fulltext search toc hon nhieu so voi LIKE '%...%'
-- ============================================================
ALTER TABLE tu_vung
    ADD FULLTEXT INDEX ft_tv_tim_kiem (tu, phien_am, nghia_chinh);

ALTER TABLE ngu_phap
    ADD FULLTEXT INDEX ft_np_tim_kiem (tieu_de, giai_thich, ghi_chu);

ALTER TABLE vi_du_ngu_phap
    ADD FULLTEXT INDEX ft_vnp_tim_kiem (vi_du, dich_nghia);


-- ============================================================
-- FIX I10: Them index cho cac truy van pho bien
-- ============================================================

-- 1. Tien do on tap SRS: them trang_thai vao composite index
--    Truy van: "Lay tu can on hom nay" -> WHERE nguoi_dung_id=? AND trang_thai!='DA_THUAN' AND lan_on_tiep_theo <= NOW()
ALTER TABLE tien_do_tu_vung
    DROP KEY idx_tdtv_on_tap,
    ADD KEY idx_tdtv_on_tap_v2 (nguoi_dung_id, trang_thai, lan_on_tiep_theo);

-- 2. Lich su luyen tap gan day: ORDER BY ngay_tao DESC
ALTER TABLE phien_luyen_tap
    ADD KEY idx_plt_nguoi_ngay (nguoi_dung_id, ngay_tao DESC);

-- 3. Phan tich AI: filter + sort theo ngay
--    Index cu: (nguoi_dung_id, ngay_tao DESC) -> chi 2 cot
--    Index moi: (nguoi_dung_id, ngay_tao DESC, loai_phan_tich) -> 3 cot
--    Vi index dang phuc vu FK, can DROP FK truoc moi DROP duoc index
--    MySQL 8+ ho tro IF EXISTS cho DROP FOREIGN KEY / DROP INDEX

-- Buoc 1: DROP FK cu
ALTER TABLE phan_tich_ai
    DROP FOREIGN KEY IF EXISTS fk_ptai_nguoi_dung;

-- Buoc 2: DROP INDEX cu (index do FK tao ra se bi xoa cung)
ALTER TABLE phan_tich_ai
    DROP KEY IF EXISTS idx_ptai_nguoi;

-- Buoc 3: ADD INDEX moi
ALTER TABLE phan_tich_ai
    ADD KEY idx_ptai_nguoi_v2 (nguoi_dung_id, ngay_tao DESC, loai_phan_tich);

-- Buoc 4: TAO LAI FK
ALTER TABLE phan_tich_ai
    ADD CONSTRAINT fk_ptai_nguoi_dung_v2
        FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id)
        ON DELETE CASCADE ON UPDATE CASCADE;

-- 4. Lich su hoc: ORDER BY ngay_hoc DESC
ALTER TABLE lich_su_ngay
    ADD KEY idx_lsn_nguoi_ngay_sort (nguoi_dung_id, ngay_hoc DESC);

-- 5. De thi: loc nhanh theo trang thai + cap do + loai de
ALTER TABLE de_thi
    ADD KEY idx_dt_trang_thai (trang_thai, cap_do_id, loai_de);


-- ============================================================
-- FIX I20: Them CHECK constraint cho du lieu
-- Dam bao tinh toan ven cua cac gia tri denormalized
-- ============================================================
ALTER TABLE phien_luyen_tap
    ADD CONSTRAINT chk_plt_cau_dung CHECK (so_cau_dung >= 0 AND so_cau_dung <= tong_cau_hoi);

ALTER TABLE phien_luyen_tap
    ADD CONSTRAINT chk_plt_do_chinh_xac
        CHECK (do_chinh_xac >= 0 AND do_chinh_xac <= 100);

ALTER TABLE phien_luyen_tap
    ADD CONSTRAINT chk_plt_diem_so
        CHECK (diem_so >= 0);

ALTER TABLE tien_do_tu_vung
    ADD CONSTRAINT chk_tdtv_so_lan CHECK (so_lan_dung >= 0 AND so_lan_sai >= 0);

ALTER TABLE tien_do_tu_vung
    ADD CONSTRAINT chk_tdtv_he_so CHECK (he_so_de >= 1.3 AND he_so_de <= 2.5);

ALTER TABLE tra_loi
    ADD CONSTRAINT chk_tl_lua_chon
        CHECK (lua_chon IS NULL OR lua_chon IN ('A','B','C','D'));

ALTER TABLE tra_loi
    ADD CONSTRAINT chk_tl_thoi_gian
        CHECK (thoi_gian_ms IS NULL OR thoi_gian_ms >= 0);

-- NOTE: danh_gia_bai_hoc da bi loai bo theo yeu cau cua ban
--        Khong them CHECK constraint vi bang khong ton tai


-- ============================================================
-- THEM BANG TOKEN
-- Quan ly token cho JWT authentication + authorization
-- Thay the: refresh_token, vai_tro_quyen, audit_log, thong_bao
--
-- Su dung:
--   - access_token_hash : luu hash cua access token (de revoke)
--   - refresh_token     : luu refresh token (de renew)
--   - vai_tro_id        : quyen cua nguoi dung tai thoi diem tao token
--                         (co the thay doi -> token van con quyen cu)
--   - is_revoked        : danh dau thu hoi (logout / doi mat khau)
-- ============================================================
CREATE TABLE IF NOT EXISTS token (
    id                  BIGINT UNSIGNED    NOT NULL    AUTO_INCREMENT,
    nguoi_dung_id       BIGINT UNSIGNED    NOT NULL,
    access_token_hash   VARCHAR(255)       DEFAULT NULL COMMENT 'Hash cua access token JWT (de revoke)',
    refresh_token       VARCHAR(255)       DEFAULT NULL COMMENT 'Refresh token (renew access token)',
    vai_tro_id          BIGINT UNSIGNED    NOT NULL COMMENT 'Quyen tai thoi diem tao (napshot)',
    thiet_bi            VARCHAR(255)       DEFAULT NULL COMMENT 'User-Agent / Device info',
    dia_chi_ip          VARCHAR(45)        DEFAULT NULL,
    loai_token          ENUM('ACCESS','REFRESH','BOTH') DEFAULT 'BOTH',
    het_han             DATETIME           DEFAULT NULL COMMENT 'Thoi diem het han (access hoac refresh)',
    bi_thu_hoi          TINYINT(1)         DEFAULT 0 COMMENT '1 = da thu hoi',
    ngay_tao            TIMESTAMP(6)       DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_tk_nguoi_dung (nguoi_dung_id),
    KEY idx_tk_access_hash (access_token_hash(64)),
    KEY idx_tk_refresh (refresh_token(64)),
    KEY idx_tk_het_han (het_han),
    KEY idx_tk_nguoi_thu_hoi (nguoi_dung_id, bi_thu_hoi),
    CONSTRAINT fk_tk_nguoi_dung
        FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tk_vai_tro
        FOREIGN KEY (vai_tro_id) REFERENCES vai_tro(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Bang quan ly token: access token hash + refresh token + quyen (snapshot)';


-- ============================================================
-- THEM MODERATOR vao vai_tro
-- Fix: comment noi MODERATOR nhung khong co trong seed data
-- ============================================================
INSERT IGNORE INTO vai_tro (ten, mo_ta) VALUES
('MODERATOR', 'Nguoi dieu hanh noi dung: duyet bai hoc, quan ly binh luan');


-- ============================================================
-- THEM nguoi_dung_id vao ket_qua_flashcard
-- Muc dich: truy van theo nguoi dung truc tiep, khong can JOIN
-- VD: "Lay lich su flashcard cua nguoi dung X"
-- ============================================================
ALTER TABLE ket_qua_flashcard
    ADD COLUMN nguoi_dung_id BIGINT UNSIGNED DEFAULT NULL
    AFTER tu_vung_id;

-- Cap nhat gia tri tu bang phien_flashcard
SET SQL_SAFE_UPDATES = 0;
UPDATE ket_qua_flashcard kqf
JOIN phien_flashcard pf ON pf.id = kqf.phien_flashcard_id
SET kqf.nguoi_dung_id = pf.nguoi_dung_id;
SET SQL_SAFE_UPDATES = 1;

-- Dat NOT NULL sau khi da co gia tri
ALTER TABLE ket_qua_flashcard
    MODIFY COLUMN nguoi_dung_id BIGINT UNSIGNED NOT NULL;

-- Tao index & FK
ALTER TABLE ket_qua_flashcard
    ADD KEY idx_kqf_nguoi_tu (nguoi_dung_id, tu_vung_id),
    ADD CONSTRAINT fk_kqf_nguoi_dung
        FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id)
        ON DELETE CASCADE ON UPDATE CASCADE;


-- ============================================================
-- THEM @Version cho JPA optimistic locking
-- JPA @Version tu dong tang khi update
-- Chung toi: tranh lost update khi nhieu nguoi cung sua 1 ban ghi
-- ============================================================
ALTER TABLE nguoi_dung    ADD COLUMN version INT DEFAULT 0;
ALTER TABLE tu_vung       ADD COLUMN version INT DEFAULT 0;
ALTER TABLE ngu_phap     ADD COLUMN version INT DEFAULT 0;
ALTER TABLE bai_hoc      ADD COLUMN version INT DEFAULT 0;
ALTER TABLE bo_cau_hoi   ADD COLUMN version INT DEFAULT 0;
ALTER TABLE cau_hoi      ADD COLUMN version INT DEFAULT 0;
ALTER TABLE de_thi       ADD COLUMN version INT DEFAULT 0;


SET FOREIGN_KEY_CHECKS = 1;
