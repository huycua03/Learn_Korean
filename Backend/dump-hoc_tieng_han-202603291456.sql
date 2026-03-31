-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: hoc_tieng_han
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bai_hoc`
--

DROP TABLE IF EXISTS `bai_hoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bai_hoc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `hinh_anh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cap_do_id` bigint unsigned DEFAULT NULL,
  `trang_thai` enum('NHAP','DANG_HOAT_DONG','LUU_TRU') COLLATE utf8mb4_unicode_ci DEFAULT 'NHAP',
  `thu_tu_hien_thi` int DEFAULT '0',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bh_cap_do` (`cap_do_id`),
  KEY `idx_bh_loc` (`trang_thai`,`da_xoa`,`thu_tu_hien_thi`),
  CONSTRAINT `fk_bh_cap_do` FOREIGN KEY (`cap_do_id`) REFERENCES `cap_do` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bai hoc hoan chinh thuoc chu de';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bai_hoc`
--

LOCK TABLES `bai_hoc` WRITE;
/*!40000 ALTER TABLE `bai_hoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `bai_hoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bai_hoc_bo_cau_hoi`
--

DROP TABLE IF EXISTS `bai_hoc_bo_cau_hoi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bai_hoc_bo_cau_hoi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bai_hoc_id` bigint unsigned NOT NULL,
  `bo_cau_hoi_id` bigint unsigned NOT NULL,
  `thu_tu_hien_thi` int NOT NULL,
  `la_bat_buoc` tinyint(1) DEFAULT '1',
  `diem_toi_thieu` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bh_bch` (`bai_hoc_id`,`thu_tu_hien_thi`),
  KEY `idx_bh_bch_bo` (`bo_cau_hoi_id`),
  CONSTRAINT `fk_bh_bch_bai_hoc` FOREIGN KEY (`bai_hoc_id`) REFERENCES `bai_hoc` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bh_bch_bo_cau_hoi` FOREIGN KEY (`bo_cau_hoi_id`) REFERENCES `bo_cau_hoi` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bang trung gian: bai hoc chua nhung bo cau hoi nao';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bai_hoc_bo_cau_hoi`
--

LOCK TABLES `bai_hoc_bo_cau_hoi` WRITE;
/*!40000 ALTER TABLE `bai_hoc_bo_cau_hoi` DISABLE KEYS */;
/*!40000 ALTER TABLE `bai_hoc_bo_cau_hoi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bo_cau_hoi`
--

DROP TABLE IF EXISTS `bo_cau_hoi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bo_cau_hoi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chu_de_tu_vung_id` bigint unsigned DEFAULT NULL,
  `ngu_phap_id` bigint unsigned DEFAULT NULL,
  `phan_thi_id` bigint unsigned DEFAULT NULL,
  `cap_do_id` bigint unsigned DEFAULT NULL,
  `loai_bo_cau_hoi` enum('TRAC_NGHIEM','NGHE','DIEU_CHINH_TA','TU_VIET') COLLATE utf8mb4_unicode_ci DEFAULT 'TRAC_NGHIEM',
  `do_kho` enum('DE','TRUNG_BINH','KHO') COLLATE utf8mb4_unicode_ci DEFAULT 'TRUNG_BINH',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bch_ngu_phap` (`ngu_phap_id`),
  KEY `idx_bch_phan_thi` (`phan_thi_id`),
  KEY `idx_bch_cap_do` (`cap_do_id`),
  KEY `idx_bch_chu_de_tv` (`chu_de_tu_vung_id`),
  CONSTRAINT `fk_bch_cap_do` FOREIGN KEY (`cap_do_id`) REFERENCES `cap_do` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bch_chu_de_tu_vung` FOREIGN KEY (`chu_de_tu_vung_id`) REFERENCES `chu_de_tu_vung` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bch_ngu_phap` FOREIGN KEY (`ngu_phap_id`) REFERENCES `ngu_phap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_bch_phan_thi` FOREIGN KEY (`phan_thi_id`) REFERENCES `phan_thi` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bo cau hoi trac nghiem, co the gan voi chu de hoac ngu phap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bo_cau_hoi`
--

LOCK TABLES `bo_cau_hoi` WRITE;
/*!40000 ALTER TABLE `bo_cau_hoi` DISABLE KEYS */;
/*!40000 ALTER TABLE `bo_cau_hoi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cap_do`
--

DROP TABLE IF EXISTS `cap_do`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cap_do` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thu_tu_hien_thi` int NOT NULL,
  `diem_toi_thieu` int DEFAULT '0',
  `diem_toi_da` int DEFAULT '200',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_cap_do_ten` (`ten`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cap do thanh thao TOPIK (TOPIK 1 - TOPIK 6)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cap_do`
--

LOCK TABLES `cap_do` WRITE;
/*!40000 ALTER TABLE `cap_do` DISABLE KEYS */;
/*!40000 ALTER TABLE `cap_do` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cau_hoi`
--

DROP TABLE IF EXISTS `cau_hoi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cau_hoi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bo_cau_hoi_id` bigint unsigned NOT NULL,
  `noi_dung` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `loai_noi_dung` enum('VAN_BAN','HINH_ANH','AM_THANH','VIDEO') COLLATE utf8mb4_unicode_ci DEFAULT 'VAN_BAN',
  `duong_dan_tep` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lua_chon_a` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lua_chon_b` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lua_chon_c` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lua_chon_d` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dap_an_dung` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `giai_thich` text COLLATE utf8mb4_unicode_ci,
  `do_kho` enum('DE','TRUNG_BINH','KHO') COLLATE utf8mb4_unicode_ci DEFAULT 'TRUNG_BINH',
  `phan_thi_id` bigint unsigned DEFAULT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ch_bo_cau_hoi` (`bo_cau_hoi_id`),
  KEY `idx_ch_do_kho` (`do_kho`),
  KEY `idx_ch_phan_thi` (`phan_thi_id`),
  CONSTRAINT `fk_ch_bo_cau_hoi` FOREIGN KEY (`bo_cau_hoi_id`) REFERENCES `bo_cau_hoi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ch_phan_thi` FOREIGN KEY (`phan_thi_id`) REFERENCES `phan_thi` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_ch_dap_an` CHECK ((`dap_an_dung` in (_utf8mb4'A',_utf8mb4'B',_utf8mb4'C',_utf8mb4'D')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cau hoi trac nghiem 4 lua chon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cau_hoi`
--

LOCK TABLES `cau_hoi` WRITE;
/*!40000 ALTER TABLE `cau_hoi` DISABLE KEYS */;
/*!40000 ALTER TABLE `cau_hoi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_lo_trinh`
--

DROP TABLE IF EXISTS `chi_tiet_lo_trinh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_lo_trinh` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lo_trinh_hoc_id` bigint unsigned NOT NULL,
  `bai_hoc_id` bigint unsigned DEFAULT NULL,
  `so_ngay` int NOT NULL,
  `loai_hoat_dong` enum('LUYEN_TAP','DANH_GIA','THI_THU') COLLATE utf8mb4_unicode_ci DEFAULT 'LUYEN_TAP',
  `bo_cau_hoi_id` bigint unsigned NOT NULL,
  `so_cau_hoi` int DEFAULT '15',
  `muc_tieu_diem` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ctlt_lo_ngay_bo` (`lo_trinh_hoc_id`,`so_ngay`,`bo_cau_hoi_id`),
  KEY `idx_ctlt_lo_trinh` (`lo_trinh_hoc_id`,`so_ngay`),
  KEY `idx_ctlt_bo_cau_hoi` (`bo_cau_hoi_id`),
  KEY `idx_ctlt_bai_hoc` (`bai_hoc_id`),
  CONSTRAINT `fk_ctlt_bai_hoc` FOREIGN KEY (`bai_hoc_id`) REFERENCES `bai_hoc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_ctlt_bo_cau_hoi` FOREIGN KEY (`bo_cau_hoi_id`) REFERENCES `bo_cau_hoi` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ctlt_lo_trinh` FOREIGN KEY (`lo_trinh_hoc_id`) REFERENCES `lo_trinh_hoc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chi tiet tung ngay trong lo trinh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_lo_trinh`
--

LOCK TABLES `chi_tiet_lo_trinh` WRITE;
/*!40000 ALTER TABLE `chi_tiet_lo_trinh` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_lo_trinh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chu_de_tu_vung`
--

DROP TABLE IF EXISTS `chu_de_tu_vung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chu_de_tu_vung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hinh_anh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_cdtv_ten` (`ten`),
  KEY `idx_cdtv_thu_tu` (`da_xoa`,`thu_tu_hien_thi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chu de hoc tu vung';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chu_de_tu_vung`
--

LOCK TABLES `chu_de_tu_vung` WRITE;
/*!40000 ALTER TABLE `chu_de_tu_vung` DISABLE KEYS */;
/*!40000 ALTER TABLE `chu_de_tu_vung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dang_ngu_phap`
--

DROP TABLE IF EXISTS `dang_ngu_phap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dang_ngu_phap` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hinh_anh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_cdnp_ten` (`ten`),
  KEY `idx_cdnp_thu_tu` (`da_xoa`,`thu_tu_hien_thi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chu de hoc ngu phap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dang_ngu_phap`
--

LOCK TABLES `dang_ngu_phap` WRITE;
/*!40000 ALTER TABLE `dang_ngu_phap` DISABLE KEYS */;
/*!40000 ALTER TABLE `dang_ngu_phap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `de_thi`
--

DROP TABLE IF EXISTS `de_thi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `de_thi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `cap_do_id` bigint unsigned NOT NULL,
  `loai_de` enum('TOPIK_1','TOPIK_2','LUYEN_TAP') COLLATE utf8mb4_unicode_ci NOT NULL,
  `thoi_gian_phut` int DEFAULT '60',
  `tong_cau_hoi` int DEFAULT '0',
  `diem_toi_da` int DEFAULT '200',
  `trang_thai` enum('DANG_HOAT_DONG','DUNG','LUU_TRU') COLLATE utf8mb4_unicode_ci DEFAULT 'DANG_HOAT_DONG',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dt_cap_do` (`cap_do_id`),
  KEY `idx_dt_loai` (`loai_de`),
  KEY `idx_dt_trang_thai` (`trang_thai`,`cap_do_id`,`loai_de`),
  CONSTRAINT `fk_dt_cap_do` FOREIGN KEY (`cap_do_id`) REFERENCES `cap_do` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='De thi TOPIK hoan chinh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `de_thi`
--

LOCK TABLES `de_thi` WRITE;
/*!40000 ALTER TABLE `de_thi` DISABLE KEYS */;
/*!40000 ALTER TABLE `de_thi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ket_qua_flashcard`
--

DROP TABLE IF EXISTS `ket_qua_flashcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ket_qua_flashcard` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phien_flashcard_id` bigint unsigned NOT NULL,
  `tu_vung_id` bigint unsigned NOT NULL,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `danh_gia` enum('BIET','KHO','KHONG_BIET') COLLATE utf8mb4_unicode_ci NOT NULL,
  `thoi_gian_ms` int DEFAULT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_kqf_phien` (`phien_flashcard_id`),
  KEY `idx_kqf_tu_vung` (`tu_vung_id`),
  KEY `idx_kqf_nguoi_tu` (`nguoi_dung_id`,`tu_vung_id`),
  CONSTRAINT `fk_kqf_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kqf_phien` FOREIGN KEY (`phien_flashcard_id`) REFERENCES `phien_flashcard` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kqf_tu_vung` FOREIGN KEY (`tu_vung_id`) REFERENCES `tu_vung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ket qua tung the trong phien flashcard';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ket_qua_flashcard`
--

LOCK TABLES `ket_qua_flashcard` WRITE;
/*!40000 ALTER TABLE `ket_qua_flashcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `ket_qua_flashcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ket_qua_ky_nang`
--

DROP TABLE IF EXISTS `ket_qua_ky_nang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ket_qua_ky_nang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `tu_vung_id` bigint unsigned NOT NULL,
  `loai_ky_nang` enum('NOI','NGHE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_audio_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diem_phat_am` decimal(4,2) DEFAULT NULL,
  `nhan_xet_ai` text COLLATE utf8mb4_unicode_ci,
  `cau_tra_loi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dung_hay_sai` tinyint(1) DEFAULT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_kqkn_nguoi_loai` (`nguoi_dung_id`,`loai_ky_nang`),
  KEY `idx_kqkn_tu_vung` (`tu_vung_id`),
  CONSTRAINT `fk_kqkn_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kqkn_tu_vung` FOREIGN KEY (`tu_vung_id`) REFERENCES `tu_vung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ket qua luyen Noi/Nghe co cham diem bang AI';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ket_qua_ky_nang`
--

LOCK TABLES `ket_qua_ky_nang` WRITE;
/*!40000 ALTER TABLE `ket_qua_ky_nang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ket_qua_ky_nang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_ngay`
--

DROP TABLE IF EXISTS `lich_su_ngay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_su_ngay` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `ngay_hoc` date NOT NULL,
  `so_phien_luyen` int DEFAULT '0',
  `so_phien_flashcard` int DEFAULT '0',
  `so_tu_vung_on_tap` int DEFAULT '0',
  `so_ngu_phap_on_tap` int DEFAULT '0',
  `tong_thoi_gian_phut` int DEFAULT '0',
  `diem_trung_binh` decimal(5,2) DEFAULT '0.00',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_lsn_nguoi_ngay` (`nguoi_dung_id`,`ngay_hoc`),
  KEY `idx_lsn_nguoi` (`nguoi_dung_id`),
  KEY `idx_lsn_ngay` (`ngay_hoc`),
  KEY `idx_lsn_nguoi_ngay_sort` (`nguoi_dung_id`,`ngay_hoc` DESC),
  CONSTRAINT `fk_lsn_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lich su hoc hang ngay - tong hop nhe';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_ngay`
--

LOCK TABLES `lich_su_ngay` WRITE;
/*!40000 ALTER TABLE `lich_su_ngay` DISABLE KEYS */;
/*!40000 ALTER TABLE `lich_su_ngay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_trinh_hoc`
--

DROP TABLE IF EXISTS `lo_trinh_hoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lo_trinh_hoc` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` text COLLATE utf8mb4_unicode_ci,
  `cap_do_bat_dau_id` bigint unsigned NOT NULL,
  `cap_do_ket_thuc_id` bigint unsigned NOT NULL,
  `tong_tuan` int NOT NULL,
  `so_phut_moi_ngay` int DEFAULT '30',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_lth_cap_bat_dau` (`cap_do_bat_dau_id`),
  KEY `fk_lth_cap_ket_thuc` (`cap_do_ket_thuc_id`),
  CONSTRAINT `fk_lth_cap_bat_dau` FOREIGN KEY (`cap_do_bat_dau_id`) REFERENCES `cap_do` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lth_cap_ket_thuc` FOREIGN KEY (`cap_do_ket_thuc_id`) REFERENCES `cap_do` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Mau lo trinh hoc tap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_trinh_hoc`
--

LOCK TABLES `lo_trinh_hoc` WRITE;
/*!40000 ALTER TABLE `lo_trinh_hoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_trinh_hoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_trinh_nguoi_dung`
--

DROP TABLE IF EXISTS `lo_trinh_nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lo_trinh_nguoi_dung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `lo_trinh_hoc_id` bigint unsigned NOT NULL,
  `diem_phan_loai` int DEFAULT NULL,
  `ngay_bat_dau` date NOT NULL,
  `ngay_ket_thuc_du_kien` date NOT NULL,
  `trang_thai` enum('DANG_HOC','HOAN_THANH','BO_CUOC') COLLATE utf8mb4_unicode_ci DEFAULT 'DANG_HOC',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_lnd_nguoi_lo_trinh` (`nguoi_dung_id`,`lo_trinh_hoc_id`),
  KEY `idx_lnd_nguoi` (`nguoi_dung_id`,`trang_thai`),
  KEY `idx_lnd_lo_trinh` (`lo_trinh_hoc_id`),
  CONSTRAINT `fk_lnd_lo_trinh` FOREIGN KEY (`lo_trinh_hoc_id`) REFERENCES `lo_trinh_hoc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lnd_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nguoi dung dang ky lo trinh hoc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_trinh_nguoi_dung`
--

LOCK TABLES `lo_trinh_nguoi_dung` WRITE;
/*!40000 ALTER TABLE `lo_trinh_nguoi_dung` DISABLE KEYS */;
/*!40000 ALTER TABLE `lo_trinh_nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loai_tu`
--

DROP TABLE IF EXISTS `loai_tu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loai_tu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ky_hieu` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_loai_tu_ten` (`ten`),
  UNIQUE KEY `uk_loai_tu_ky_hieu` (`ky_hieu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loai tu (danh tu, dong tu, tinh tu...)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loai_tu`
--

LOCK TABLES `loai_tu` WRITE;
/*!40000 ALTER TABLE `loai_tu` DISABLE KEYS */;
/*!40000 ALTER TABLE `loai_tu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nghia_tu`
--

DROP TABLE IF EXISTS `nghia_tu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nghia_tu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tu_vung_loai_tu_id` bigint unsigned NOT NULL,
  `nghia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cap_do_su_dung` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vi_du` text COLLATE utf8mb4_unicode_ci,
  `vi_du_dich` text COLLATE utf8mb4_unicode_ci,
  `thu_tu_hien_thi` int DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_nt_tu_vung_loai_tu` (`tu_vung_loai_tu_id`),
  CONSTRAINT `fk_nt_tu_vung_loai_tu` FOREIGN KEY (`tu_vung_loai_tu_id`) REFERENCES `tu_vung_loai_tu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nghia mo rong cua tu vung da nghia, ho tro tich hop API tu dien';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nghia_tu`
--

LOCK TABLES `nghia_tu` WRITE;
/*!40000 ALTER TABLE `nghia_tu` DISABLE KEYS */;
/*!40000 ALTER TABLE `nghia_tu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ngu_phap`
--

DROP TABLE IF EXISTS `ngu_phap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ngu_phap` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tieu_de` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cau_truc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `giai_thich` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ghi_chu` text COLLATE utf8mb4_unicode_ci,
  `dang_ngu_phap_id` bigint unsigned DEFAULT NULL,
  `cap_do_id` bigint unsigned NOT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_np_chu_de` (`thu_tu_hien_thi`),
  KEY `idx_np_cap_do` (`cap_do_id`),
  KEY `idx_np_dang_ngu_phap` (`dang_ngu_phap_id`),
  FULLTEXT KEY `ft_np_tim_kiem` (`tieu_de`,`giai_thich`,`ghi_chu`),
  CONSTRAINT `fk_np_cap_do` FOREIGN KEY (`cap_do_id`) REFERENCES `cap_do` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_np_dang_ngu_phap` FOREIGN KEY (`dang_ngu_phap_id`) REFERENCES `dang_ngu_phap` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ngữ pháp - cau truc, giai thich, ghi chu';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ngu_phap`
--

LOCK TABLES `ngu_phap` WRITE;
/*!40000 ALTER TABLE `ngu_phap` DISABLE KEYS */;
/*!40000 ALTER TABLE `ngu_phap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoi_dung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten_dang_nhap` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mat_khau` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mat_khau_salt` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ho_ten` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `ten_hien_thi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dia_chi` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `vai_tro_id` bigint unsigned NOT NULL,
  `trang_thai` enum('ACTIVE','INACTIVE','BANNED') COLLATE utf8mb4_unicode_ci DEFAULT 'ACTIVE',
  `lan_dang_nhap_cuoi` timestamp(6) NULL DEFAULT NULL,
  `da_kich_hoat` tinyint(1) DEFAULT '1',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_nguoi_dung_ten_dang_nhap` (`ten_dang_nhap`),
  UNIQUE KEY `uk_nguoi_dung_email` (`email`),
  KEY `idx_nguoi_dung_vai_tro` (`vai_tro_id`),
  KEY `idx_nguoi_dung_trang_thai` (`trang_thai`),
  CONSTRAINT `fk_nguoi_dung_vai_tro` FOREIGN KEY (`vai_tro_id`) REFERENCES `vai_tro` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nguoi dung chinh cua he thong';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhom_tu_vung`
--

DROP TABLE IF EXISTS `nhom_tu_vung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhom_tu_vung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chu_de_tu_vung_id` bigint unsigned DEFAULT NULL,
  `cap_do_id` bigint unsigned NOT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_ntv_chu_de` (`thu_tu_hien_thi`),
  KEY `idx_ntv_cap_do` (`cap_do_id`),
  KEY `idx_ntv_chu_de_tv` (`chu_de_tu_vung_id`),
  CONSTRAINT `fk_ntv_cap_do` FOREIGN KEY (`cap_do_id`) REFERENCES `cap_do` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ntv_chu_de_tu_vung` FOREIGN KEY (`chu_de_tu_vung_id`) REFERENCES `chu_de_tu_vung` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nhom tu vung (deck flashcard), thuoc chu de va cap do';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhom_tu_vung`
--

LOCK TABLES `nhom_tu_vung` WRITE;
/*!40000 ALTER TABLE `nhom_tu_vung` DISABLE KEYS */;
/*!40000 ALTER TABLE `nhom_tu_vung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phan_thi`
--

DROP TABLE IF EXISTS `phan_thi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phan_thi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `de_thi_id` bigint unsigned NOT NULL,
  `ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ky_nang` enum('NGHE','DOC','VIET','NOI') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cau_so` int NOT NULL,
  `cau_den` int NOT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_pt_de_thi` (`de_thi_id`,`thu_tu_hien_thi`),
  CONSTRAINT `fk_pt_de_thi` FOREIGN KEY (`de_thi_id`) REFERENCES `de_thi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Phan thi trong de TOPIK (Nghe, Doc, Viet, Noi)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phan_thi`
--

LOCK TABLES `phan_thi` WRITE;
/*!40000 ALTER TABLE `phan_thi` DISABLE KEYS */;
/*!40000 ALTER TABLE `phan_thi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phan_tich_ai`
--

DROP TABLE IF EXISTS `phan_tich_ai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phan_tich_ai` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `loai_phan_tich` enum('TU_VUNG','NGU_PHAP','TOAN_DIEN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tong_tu_da_hoc` int DEFAULT '0',
  `tong_ngu_phap_da_hoc` int DEFAULT '0',
  `diem_trung_binh` decimal(5,2) DEFAULT '0.00',
  `so_ngay_diem_thap` int DEFAULT '0',
  `diem_yeu_tu_vung` text COLLATE utf8mb4_unicode_ci,
  `diem_yeu_ngu_phap` text COLLATE utf8mb4_unicode_ci,
  `loi_mac_dinh` text COLLATE utf8mb4_unicode_ci,
  `goi_y_on_tap` text COLLATE utf8mb4_unicode_ci,
  `noi_dung_phan_tich` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_ptai_loai` (`loai_phan_tich`),
  KEY `idx_ptai_nguoi_v2` (`nguoi_dung_id`,`ngay_tao` DESC,`loai_phan_tich`),
  CONSTRAINT `fk_ptai_nguoi_dung_v2` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Ket qua phan tich hoc tap bang AI';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phan_tich_ai`
--

LOCK TABLES `phan_tich_ai` WRITE;
/*!40000 ALTER TABLE `phan_tich_ai` DISABLE KEYS */;
/*!40000 ALTER TABLE `phan_tich_ai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phien_flashcard`
--

DROP TABLE IF EXISTS `phien_flashcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phien_flashcard` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `nhom_tu_vung_id` bigint unsigned NOT NULL,
  `tong_the` int NOT NULL,
  `so_the_biet` int DEFAULT '0',
  `so_the_kho` int DEFAULT '0',
  `so_the_khong_biet` int DEFAULT '0',
  `thoi_gian_ms` int DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_pf_nguoi` (`nguoi_dung_id`),
  KEY `idx_pf_nhom_tu` (`nhom_tu_vung_id`),
  CONSTRAINT `fk_pf_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pf_nhom_tu_vung` FOREIGN KEY (`nhom_tu_vung_id`) REFERENCES `nhom_tu_vung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Phien hoc flashcard';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phien_flashcard`
--

LOCK TABLES `phien_flashcard` WRITE;
/*!40000 ALTER TABLE `phien_flashcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `phien_flashcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phien_luyen_tap`
--

DROP TABLE IF EXISTS `phien_luyen_tap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phien_luyen_tap` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `bo_cau_hoi_id` bigint unsigned NOT NULL,
  `loai_nguon` enum('TU_DO','TU_VUNG','NGU_PHAP','BAI_HOC','LO_TRINH') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TU_DO',
  `nguon_id` bigint unsigned DEFAULT NULL,
  `tong_cau_hoi` int NOT NULL,
  `so_cau_dung` int NOT NULL,
  `do_chinh_xac` decimal(5,2) NOT NULL,
  `diem_so` int DEFAULT '0',
  `thoi_gian_trung_binh_ms` int DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_plt_nguoi_dung` (`nguoi_dung_id`),
  KEY `idx_plt_bo_cau_hoi` (`bo_cau_hoi_id`),
  KEY `idx_plt_nguon` (`loai_nguon`,`nguon_id`),
  KEY `idx_plt_nguoi_ngay` (`nguoi_dung_id`,`ngay_tao` DESC),
  CONSTRAINT `fk_plt_bo_cau_hoi` FOREIGN KEY (`bo_cau_hoi_id`) REFERENCES `bo_cau_hoi` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_plt_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_plt_cau_dung` CHECK (((`so_cau_dung` >= 0) and (`so_cau_dung` <= `tong_cau_hoi`))),
  CONSTRAINT `chk_plt_diem_so` CHECK ((`diem_so` >= 0)),
  CONSTRAINT `chk_plt_do_chinh_xac` CHECK (((`do_chinh_xac` >= 0) and (`do_chinh_xac` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Phien luyen tap - ghi nhan 1 lan lam bai';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phien_luyen_tap`
--

LOCK TABLES `phien_luyen_tap` WRITE;
/*!40000 ALTER TABLE `phien_luyen_tap` DISABLE KEYS */;
/*!40000 ALTER TABLE `phien_luyen_tap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streak`
--

DROP TABLE IF EXISTS `streak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streak` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `chuoi_hien_tai` int DEFAULT '0',
  `chuoi_dai_nhat` int DEFAULT '0',
  `ngay_hoat_dong_cuoi` date DEFAULT NULL,
  `tong_ngay_hoat_dong` int DEFAULT '0',
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_s_nguoi` (`nguoi_dung_id`),
  CONSTRAINT `fk_s_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chuoi ngay hoc lien tiep (streak)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streak`
--

LOCK TABLES `streak` WRITE;
/*!40000 ALTER TABLE `streak` DISABLE KEYS */;
/*!40000 ALTER TABLE `streak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tien_do_ngu_phap`
--

DROP TABLE IF EXISTS `tien_do_ngu_phap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tien_do_ngu_phap` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `ngu_phap_id` bigint unsigned NOT NULL,
  `da_hoc` tinyint(1) DEFAULT '0',
  `so_lan_luyen` int DEFAULT '0',
  `so_lan_dung` int DEFAULT '0',
  `lan_on_gan_nhat` timestamp(6) NULL DEFAULT NULL,
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tdnp_nguoi_ngu` (`nguoi_dung_id`,`ngu_phap_id`),
  KEY `idx_tdnp_nguoi` (`nguoi_dung_id`),
  KEY `fk_tdnp_ngu_phap` (`ngu_phap_id`),
  CONSTRAINT `fk_tdnp_ngu_phap` FOREIGN KEY (`ngu_phap_id`) REFERENCES `ngu_phap` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tdnp_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tien do hoc ngu phap - danh dau da hoc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tien_do_ngu_phap`
--

LOCK TABLES `tien_do_ngu_phap` WRITE;
/*!40000 ALTER TABLE `tien_do_ngu_phap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tien_do_ngu_phap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tien_do_tu_vung`
--

DROP TABLE IF EXISTS `tien_do_tu_vung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tien_do_tu_vung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `tu_vung_id` bigint unsigned NOT NULL,
  `trang_thai` enum('CHUA_HOC','DANG_HOC','DA_THUAN') COLLATE utf8mb4_unicode_ci DEFAULT 'CHUA_HOC',
  `so_lan_dung` int DEFAULT '0',
  `so_lan_sai` int DEFAULT '0',
  `khoang_lap_ngay` int DEFAULT '1',
  `he_so_de` decimal(4,2) DEFAULT '2.50',
  `so_lan_lien_tiep_dung` int DEFAULT '0',
  `lan_on_tiep_theo` timestamp(6) NULL DEFAULT NULL,
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tdtv_nguoi_tu` (`nguoi_dung_id`,`tu_vung_id`),
  KEY `idx_tdtv_nguoi` (`nguoi_dung_id`),
  KEY `idx_tdtv_trang_thai` (`nguoi_dung_id`,`trang_thai`),
  KEY `fk_tdtv_tu_vung` (`tu_vung_id`),
  KEY `idx_tdtv_on_tap_v2` (`nguoi_dung_id`,`trang_thai`,`lan_on_tiep_theo`),
  CONSTRAINT `fk_tdtv_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tdtv_tu_vung` FOREIGN KEY (`tu_vung_id`) REFERENCES `tu_vung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_tdtv_he_so` CHECK (((`he_so_de` >= 1.3) and (`he_so_de` <= 2.5))),
  CONSTRAINT `chk_tdtv_so_lan` CHECK (((`so_lan_dung` >= 0) and (`so_lan_sai` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tien do hoc tu vung - thuat toan SRS SM-2';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tien_do_tu_vung`
--

LOCK TABLES `tien_do_tu_vung` WRITE;
/*!40000 ALTER TABLE `tien_do_tu_vung` DISABLE KEYS */;
/*!40000 ALTER TABLE `tien_do_tu_vung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nguoi_dung_id` bigint unsigned NOT NULL,
  `access_token_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hash cua access token JWT (de revoke)',
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Refresh token (renew access token)',
  `vai_tro_id` bigint unsigned NOT NULL COMMENT 'Quyen tai thoi diem tao (napshot)',
  `thiet_bi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'User-Agent / Device info',
  `dia_chi_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loai_token` enum('ACCESS','REFRESH','BOTH') COLLATE utf8mb4_unicode_ci DEFAULT 'BOTH',
  `het_han` datetime DEFAULT NULL COMMENT 'Thoi diem het han (access hoac refresh)',
  `bi_thu_hoi` tinyint(1) DEFAULT '0' COMMENT '1 = da thu hoi',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_tk_nguoi_dung` (`nguoi_dung_id`),
  KEY `idx_tk_access_hash` (`access_token_hash`(64)),
  KEY `idx_tk_refresh` (`refresh_token`(64)),
  KEY `idx_tk_het_han` (`het_han`),
  KEY `idx_tk_nguoi_thu_hoi` (`nguoi_dung_id`,`bi_thu_hoi`),
  KEY `fk_tk_vai_tro` (`vai_tro_id`),
  CONSTRAINT `fk_tk_nguoi_dung` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tk_vai_tro` FOREIGN KEY (`vai_tro_id`) REFERENCES `vai_tro` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bang quan ly token: access token hash + refresh token + quyen (snapshot)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tra_loi`
--

DROP TABLE IF EXISTS `tra_loi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tra_loi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phien_luyen_tap_id` bigint unsigned NOT NULL,
  `cau_hoi_id` bigint unsigned NOT NULL,
  `lua_chon` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dung_hay_sai` tinyint(1) NOT NULL,
  `thoi_gian_ms` int DEFAULT NULL,
  `duoc_ghi_nho` tinyint(1) DEFAULT '0',
  `ngay_tra_loi` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_tl_phien` (`phien_luyen_tap_id`),
  KEY `idx_tl_cau_hoi` (`cau_hoi_id`),
  KEY `idx_tl_ghi_nho` (`phien_luyen_tap_id`,`duoc_ghi_nho`),
  CONSTRAINT `fk_tl_cau_hoi` FOREIGN KEY (`cau_hoi_id`) REFERENCES `cau_hoi` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tl_phien_luyen_tap` FOREIGN KEY (`phien_luyen_tap_id`) REFERENCES `phien_luyen_tap` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_tl_lua_chon` CHECK (((`lua_chon` is null) or (`lua_chon` in (_utf8mb4'A',_utf8mb4'B',_utf8mb4'C',_utf8mb4'D')))),
  CONSTRAINT `chk_tl_thoi_gian` CHECK (((`thoi_gian_ms` is null) or (`thoi_gian_ms` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chi tiet tung cau tra loi trong phien luyen tap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tra_loi`
--

LOCK TABLES `tra_loi` WRITE;
/*!40000 ALTER TABLE `tra_loi` DISABLE KEYS */;
/*!40000 ALTER TABLE `tra_loi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tu_vung`
--

DROP TABLE IF EXISTS `tu_vung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tu_vung` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tu` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phien_am` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nghia_chinh` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vi_du` text COLLATE utf8mb4_unicode_ci,
  `vi_du_dich` text COLLATE utf8mb4_unicode_ci,
  `hinh_anh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `am_thanh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nhom_tu_vung_id` bigint unsigned NOT NULL,
  `da_xoa` tinyint(1) DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tv_tu` (`tu`),
  KEY `idx_tv_nhom` (`nhom_tu_vung_id`),
  FULLTEXT KEY `ft_tv_tim_kiem` (`tu`,`phien_am`,`nghia_chinh`),
  CONSTRAINT `fk_tv_nhom_tu_vung` FOREIGN KEY (`nhom_tu_vung_id`) REFERENCES `nhom_tu_vung` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tu vung - thong tin co ban, lien ket den nhom_tu_vung';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tu_vung`
--

LOCK TABLES `tu_vung` WRITE;
/*!40000 ALTER TABLE `tu_vung` DISABLE KEYS */;
/*!40000 ALTER TABLE `tu_vung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tu_vung_loai_tu`
--

DROP TABLE IF EXISTS `tu_vung_loai_tu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tu_vung_loai_tu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tu_vung_id` bigint unsigned NOT NULL,
  `loai_tu_id` bigint unsigned NOT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tvlt_tv_loai` (`tu_vung_id`,`loai_tu_id`),
  KEY `idx_tvlt_loai_tu` (`loai_tu_id`),
  CONSTRAINT `fk_tvlt_loai_tu` FOREIGN KEY (`loai_tu_id`) REFERENCES `loai_tu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tvlt_tu_vung` FOREIGN KEY (`tu_vung_id`) REFERENCES `tu_vung` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bang trung gian: tu vung co the co nhieu loai tu';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tu_vung_loai_tu`
--

LOCK TABLES `tu_vung_loai_tu` WRITE;
/*!40000 ALTER TABLE `tu_vung_loai_tu` DISABLE KEYS */;
/*!40000 ALTER TABLE `tu_vung_loai_tu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vai_tro`
--

DROP TABLE IF EXISTS `vai_tro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vai_tro` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mo_ta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_vai_tro_ten` (`ten`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Danh sach vai tro nguoi dung';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vai_tro`
--

LOCK TABLES `vai_tro` WRITE;
/*!40000 ALTER TABLE `vai_tro` DISABLE KEYS */;
INSERT INTO `vai_tro` VALUES (1,'MODERATOR','Nguoi dieu hanh noi dung: duyet bai hoc, quan ly binh luan','2026-03-29 07:37:37.339780','2026-03-29 07:37:37.339780');
/*!40000 ALTER TABLE `vai_tro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vi_du_ngu_phap`
--

DROP TABLE IF EXISTS `vi_du_ngu_phap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vi_du_ngu_phap` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ngu_phap_id` bigint unsigned NOT NULL,
  `vi_du` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `dich_nghia` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `am_thanh_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thu_tu_hien_thi` int DEFAULT '0',
  `ngay_tao` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ngay_cap_nhat` timestamp(6) NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_vnp_ngu_phap` (`ngu_phap_id`),
  FULLTEXT KEY `ft_vnp_tim_kiem` (`vi_du`,`dich_nghia`),
  CONSTRAINT `fk_vnp_ngu_phap` FOREIGN KEY (`ngu_phap_id`) REFERENCES `ngu_phap` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Vi du cho tung muc ngu phap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vi_du_ngu_phap`
--

LOCK TABLES `vi_du_ngu_phap` WRITE;
/*!40000 ALTER TABLE `vi_du_ngu_phap` DISABLE KEYS */;
/*!40000 ALTER TABLE `vi_du_ngu_phap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hoc_tieng_han'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-29 14:56:56
