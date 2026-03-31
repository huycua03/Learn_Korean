-- ============================================================
-- FILE: hoc_tieng_han_seed.sql
-- Mo ta: Du lieu seed cho he thong hoc tieng Han
-- Phiên ban: v1.0
-- Ghi chu:
--   - Chay SAU hoc_tieng_han.sql (hoac sau khi import dump)
--   - Dung INSERT IGNORE de tranh loi khi chay nhieu lan
-- ============================================================
USE hoc_tieng_han;
SET NAMES utf8mb4;

-- ============================================================
-- 1. Vai tro
-- ============================================================
INSERT IGNORE INTO vai_tro (ten, mo_ta) VALUES
('ADMIN',     'Quan tri he thong'),
('NGUOI_DUNG', 'Nguoi dung thong thuong'),
('MODERATOR', 'Nguoi dieu hanh noi dung: duyet bai hoc, quan ly binh luan');

-- ============================================================
-- 2. Cap do TOPIK
-- ============================================================
INSERT IGNORE INTO cap_do (ten, mo_ta, thu_tu_hien_thi, diem_toi_thieu, diem_toi_da) VALUES
('TOPIK 1', 'So cap TOPIK 1 - Nguoi moi bat dau', 1,   0, 200),
('TOPIK 2', 'So cap TOPIK 2',                        2, 140, 200),
('TOPIK 3', 'Trung cap TOPIK 3',                      3, 120, 300),
('TOPIK 4', 'Trung cap TOPIK 4',                      4, 150, 300),
('TOPIK 5', 'Cao cap TOPIK 5',                        5, 190, 300),
('TOPIK 6', 'Cao nhat TOPIK 6',                       6, 230, 300);

-- ============================================================
-- 3. Loai tu
-- ============================================================
INSERT IGNORE INTO loai_tu (ten, ky_hieu, mo_ta) VALUES
('Danh tu',     'N',    'Danh tu (Noun)'),
('Dong tu',     'V',    'Dong tu (Verb)'),
('Tinh tu',     'ADJ',  'Tinh tu (Adjective)'),
('Trang tu',    'ADV',  'Trang tu (Adverb)'),
('So tu',       'NUM',  'So tu (Numeral)'),
('Dong chi',    'PRON', 'Dong chi (Pronoun)'),
('Trong tu',    'PART', 'Trong tu (Particle)'),
('Thu nguyen',  'AFF',  'Thu nguyen (Affix)');

-- ============================================================
-- 4. Tai khoan admin mac dinh
--    Password: admin123 (se duoc hash = BCrypt o tầng Spring Security)
--    Chu y: mat_khau o day chi la placeholder, can hash truoc khi insert
--    Hoac dung JPA Service de tao tai khoan
-- ============================================================
INSERT IGNORE INTO nguoi_dung (ten_dang_nhap, email, mat_khau, ho_ten, vai_tro_id, trang_thai, da_kich_hoat) VALUES
('admin', 'admin@hoc_tieng_han.vn', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Quan tri vien', 1, 'ACTIVE', 1);
-- mat_khau tren la BCrypt hash cua 'admin123'

-- ============================================================
-- 5. INDEX BI REGRESSION - Can fix sau khi import dump
--    Hai index nay bi drop trong qua trinh migration
--    va khong duoc tao lai dung cach
-- ============================================================
-- Index cua ngu_phap: (chu_de_id, thu_tu_hien_thi) -> (dang_ngu_phap_id, thu_tu_hien_thi)
ALTER TABLE ngu_phap
    DROP KEY IF EXISTS idx_np_chu_de,
    ADD KEY idx_np_chu_de (dang_ngu_phap_id, thu_tu_hien_thi);

-- Index cua nhom_tu_vung: (chu_de_id, thu_tu_hien_thi) -> (chu_de_tu_vung_id, thu_tu_hien_thi)
ALTER TABLE nhom_tu_vung
    DROP KEY IF EXISTS idx_ntv_chu_de,
    ADD KEY idx_ntv_chu_de (chu_de_tu_vung_id, thu_tu_hien_thi);
