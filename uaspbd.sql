-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 23, 2024 at 07:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uaspbd`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_barang_by_status` (IN `statusPelacakan` VARCHAR(255))   BEGIN
    SELECT b.*
    FROM barang b
    JOIN pengiriman p ON b.id_pengiriman = p.id_pengiriman
    JOIN pelacakan l ON p.id_pengiriman = l.id_pengiriman
    WHERE l.status = statusPelacakan;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `jumlah_pengiriman_sopir` (`namaSopir` VARCHAR(200)) RETURNS INT(11)  BEGIN
    DECLARE jumlah INT;
    
    
    SELECT COUNT(*) INTO jumlah
    FROM armada a
    JOIN pengiriman p ON a.id_armada = p.id_armada
    WHERE a.nama_sopir = namaSopir;
    
    RETURN jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `armada`
--

CREATE TABLE `armada` (
  `id_armada` int(11) NOT NULL,
  `nama_sopir` varchar(200) NOT NULL,
  `tipe_kendaraan` varchar(200) NOT NULL,
  `kapasitas` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `armada`
--

INSERT INTO `armada` (`id_armada`, `nama_sopir`, `tipe_kendaraan`, `kapasitas`) VALUES
(1, 'miftah', 'truck', '500 kg'),
(2, 'brilyan', 'fuso', '1000kg'),
(3, 'angga', 'truck_hino', '500kg'),
(4, 'jaki', 'mini_truck', '250kg'),
(5, 'siwan', 'pickup', '100kg');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(11) NOT NULL,
  `id_pengiriman` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `id_pengiriman`, `nama`, `deskripsi`) VALUES
('EA001', 1, 'carrier', 'carrier ini berkapasitas 60L'),
('EA002', 2, 'stand_laptop', 'stand laptop ini sangat kokoh dan tahan lama'),
('EA003', 3, 'POCO F5', 'HP ini dilengkapi dengan chipeset G99'),
('EA004', 4, 'key FANTECH', 'keyboard mechanical dengan menggunakan switch biru'),
('EA005', 5, 'LOQ', 'laptop ini menggunakan processor INTEL 5'),
('EA006', 1, 'monitor', 'Monitor 24 inci dengan resolusi 1080p'),
('EA007', 2, 'printer', 'Printer laser hitam putih'),
('EA008', 3, 'mouse', 'Mouse gaming dengan DPI tinggi'),
('EA009', 4, 'speaker', 'Speaker bluetooth dengan bass kuat'),
('EA010', 5, 'headphone', 'Headphone noise-cancelling');

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE `gudang` (
  `id_gudang` int(11) NOT NULL,
  `lokasi` varchar(56) NOT NULL,
  `kapasitas` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gudang`
--

INSERT INTO `gudang` (`id_gudang`, `lokasi`, `kapasitas`) VALUES
(1, 'bandung', '1000 kg'),
(2, 'semarang', '850kg'),
(3, 'jakarta', '1500kg'),
(5, 'glagahsari', '500kg'),
(6, 'surabaya', '1200kg');

-- --------------------------------------------------------

--
-- Table structure for table `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` int(11) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `kota` varchar(255) NOT NULL,
  `provinsi` varchar(255) NOT NULL,
  `negara` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `alamat`, `kota`, `provinsi`, `negara`) VALUES
(1, 'cimahi', 'bandung', 'jawa barat', 'indonesia'),
(2, 'tembalang', 'semarang', 'jawa tengah', 'indonesia'),
(3, 'pasar senen', 'jakarta timur', 'DKI jakarta', 'indonesia'),
(4, 'glagahsari', 'jogja', 'yogyakarta', 'indoensia'),
(5, 'ketintang', 'surabaya', 'jawa timur', 'indonesia'),
(6, 'Jl. Raya No. 1', 'Bandung', 'Jawa Barat', 'Indonesia'),
(7, 'Jl. Semangka No. 3', 'Semarang', 'Jawa Tengah', 'Indonesia'),
(8, 'Jl. Jaksa No. 10', 'Jakarta', 'DKI Jakarta', 'Indonesia'),
(9, 'Jl. Melati No. 5', 'Surabaya', 'Jawa Timur', 'Indonesia'),
(10, 'Jl. Anggrek No. 7', 'Yogyakarta', 'DIY', 'Indonesia');

-- --------------------------------------------------------

--
-- Table structure for table `pelacakan`
--

CREATE TABLE `pelacakan` (
  `id_pelacakan` int(11) NOT NULL,
  `id_pengiriman` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `waktu_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelacakan`
--

INSERT INTO `pelacakan` (`id_pelacakan`, `id_pengiriman`, `status`, `lokasi`, `waktu_update`) VALUES
(1, 1, 'dikirim', 'bandung', '2024-07-01 17:33:08'),
(2, 2, 'dikirim', 'semarang', '2024-07-02 18:47:22'),
(3, 3, 'dikemas', 'jakarta', '2024-07-04 18:49:39'),
(4, 4, 'diterima', 'glagahsari', '2024-07-04 18:51:21'),
(5, 5, 'dikemas', 'surabaya', '2024-07-05 18:51:21'),
(6, 1, 'dalam perjalanan', 'Jakarta', '2024-07-02 09:00:00'),
(7, 2, 'dalam perjalanan', 'Bandung', '2024-07-03 11:00:00'),
(8, 3, 'dikirim', 'Yogyakarta', '2024-07-04 10:00:00'),
(9, 4, 'diambil', 'Surabaya', '2024-07-05 14:00:00'),
(10, 5, 'dalam perjalanan', 'Bandung', '2024-07-06 08:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telepon` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `alamat`, `email`, `telepon`) VALUES
(1, 'Updated Name', 'condongcatur', 'maulud@gmail.com', '082147483647'),
(2, 'deden', 'maguwo', 'deden@gmail.com', '082137039927'),
(3, 'amelia', 'wates', 'amelia@gmail.com', '085710209529'),
(4, 'gilang', 'monjali', 'gilang@gmail.com', '083123456789'),
(5, 'dImas', 'sedayu', 'dimas@gmail.com', '08912345678'),
(6, 'taufik', 'jl. Harapan No. 8', 'taufik@gmail.com', '08123456789'),
(7, 'sari', 'jl. Kenanga No. 12', 'sari@gmail.com', '08234567890'),
(8, 'dina', 'jl. Mawar No. 14', 'dina@gmail.com', '08345678901'),
(9, 'budi', 'jl. Jati No. 22', 'budi@gmail.com', '08456789012'),
(10, 'Anna', 'Seturan', 'anna@example.com', '081234567891');

-- --------------------------------------------------------

--
-- Table structure for table `pengiriman`
--

CREATE TABLE `pengiriman` (
  `id_pengiriman` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `id_armada` int(11) NOT NULL,
  `tanggal_kirim` datetime NOT NULL,
  `nomor_resi` varchar(255) NOT NULL,
  `status_pengiriman` varchar(255) NOT NULL,
  `alamat_penerima` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengiriman`
--

INSERT INTO `pengiriman` (`id_pengiriman`, `id_pelanggan`, `id_armada`, `tanggal_kirim`, `nomor_resi`, `status_pengiriman`, `alamat_penerima`) VALUES
(1, 1, 1, '2024-07-01 00:00:00', 'JD1234', 'dikirim', 'condongcatur, sleman, yogyakarta'),
(2, 2, 2, '2024-07-02 00:00:00', 'JP0987', 'dikemas', 'maguwo, sleman, jogja'),
(3, 3, 3, '2024-07-03 00:00:00', 'SP1234', 'diterima', 'wates, kulonprogo, jogja'),
(4, 4, 4, '2024-07-04 00:00:00', 'JE7654', 'dikirim', 'monjali, sleman, jogja'),
(5, 5, 5, '2024-07-05 00:00:00', 'SP9876', 'dikemas', 'sedayu, bantul, jogja'),
(6, 2, 3, '2024-07-06 00:00:00', 'JP8765', 'dikirim', 'kawasan industri, Bandung'),
(7, 3, 4, '2024-07-07 00:00:00', 'SP5432', 'dikemas', 'perumahan, Yogyakarta'),
(8, 4, 1, '2024-07-08 00:00:00', 'JD5678', 'dikirim', 'jalan utama, Jakarta'),
(9, 5, 2, '2024-07-09 00:00:00', 'JP2345', 'diterima', 'pusat kota, Surabaya'),
(10, 3, 2, '2024-07-06 00:00:00', 'AB1234', 'dikirim', 'wates, kulonprogo, jogja');

--
-- Triggers `pengiriman`
--
DELIMITER $$
CREATE TRIGGER `after_pengiriman_delete` AFTER DELETE ON `pengiriman` FOR EACH ROW BEGIN
    DELETE FROM pelacakan WHERE id_pengiriman = OLD.id_pengiriman;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pengiriman_insert` AFTER INSERT ON `pengiriman` FOR EACH ROW BEGIN
    INSERT INTO pelacakan (id_pengiriman, status, lokasi, waktu_update)
    VALUES (NEW.id_pengiriman, 'dikirim', NEW.alamat_penerima, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pengiriman_update` AFTER UPDATE ON `pengiriman` FOR EACH ROW BEGIN
    IF OLD.status_pengiriman <> NEW.status_pengiriman THEN
        INSERT INTO pelacakan (id_pengiriman, status, lokasi, waktu_update)
        VALUES (NEW.id_pengiriman, NEW.status_pengiriman, NEW.alamat_penerima, NOW());
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pengiriman_delete` BEFORE DELETE ON `pengiriman` FOR EACH ROW BEGIN
    IF OLD.status_pengiriman = 'dikirim' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pengiriman yang sudah dikirim tidak dapat dihapus.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pengiriman_insert` BEFORE INSERT ON `pengiriman` FOR EACH ROW BEGIN
    IF CHAR_LENGTH(NEW.alamat_penerima) < 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alamat penerima harus memiliki setidaknya 10 karakter.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pengiriman_update` BEFORE UPDATE ON `pengiriman` FOR EACH ROW BEGIN
    IF OLD.status_pengiriman = 'dikirim' AND NEW.status_pengiriman <> 'dikirim' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Status pengiriman tidak dapat diubah setelah dikirim.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_horizontal`
-- (See below for the actual view)
--
CREATE TABLE `view_horizontal` (
`id_pelanggan` int(11)
,`nama` varchar(200)
,`alamat` varchar(255)
,`email` varchar(255)
,`telepon` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_inside`
-- (See below for the actual view)
--
CREATE TABLE `view_inside` (
`id_pelanggan` int(11)
,`nama` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_vertical`
-- (See below for the actual view)
--
CREATE TABLE `view_vertical` (
`id_pelanggan` int(11)
,`nama` varchar(200)
);

-- --------------------------------------------------------

--
-- Structure for view `view_horizontal`
--
DROP TABLE IF EXISTS `view_horizontal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_horizontal`  AS SELECT `pelanggan`.`id_pelanggan` AS `id_pelanggan`, `pelanggan`.`nama` AS `nama`, `pelanggan`.`alamat` AS `alamat`, `pelanggan`.`email` AS `email`, `pelanggan`.`telepon` AS `telepon` FROM `pelanggan` ;

-- --------------------------------------------------------

--
-- Structure for view `view_inside`
--
DROP TABLE IF EXISTS `view_inside`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_inside`  AS SELECT `view_horizontal`.`id_pelanggan` AS `id_pelanggan`, `view_horizontal`.`nama` AS `nama` FROM `view_horizontal` WHERE `view_horizontal`.`nama` like 'A%'WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `view_vertical`
--
DROP TABLE IF EXISTS `view_vertical`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_vertical`  AS SELECT `pelanggan`.`id_pelanggan` AS `id_pelanggan`, `pelanggan`.`nama` AS `nama` FROM `pelanggan` WHERE `pelanggan`.`id_pelanggan` in (select `pengiriman`.`id_pelanggan` from `pengiriman`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `armada`
--
ALTER TABLE `armada`
  ADD PRIMARY KEY (`id_armada`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_pengiriman` (`id_pengiriman`),
  ADD KEY `idx_barang_pengiriman` (`id_barang`,`id_pengiriman`);

--
-- Indexes for table `gudang`
--
ALTER TABLE `gudang`
  ADD PRIMARY KEY (`id_gudang`);

--
-- Indexes for table `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indexes for table `pelacakan`
--
ALTER TABLE `pelacakan`
  ADD PRIMARY KEY (`id_pelacakan`),
  ADD KEY `id_pengiriman` (`id_pengiriman`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD PRIMARY KEY (`id_pengiriman`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_armada` (`id_armada`),
  ADD KEY `idx_pelanggan_tanggal` (`id_pelanggan`,`tanggal_kirim`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `id_pelanggan` (`id_pelanggan`,`id_barang`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `armada`
--
ALTER TABLE `armada`
  MODIFY `id_armada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `gudang`
--
ALTER TABLE `gudang`
  MODIFY `id_gudang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lokasi`
--
ALTER TABLE `lokasi`
  MODIFY `id_lokasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pelacakan`
--
ALTER TABLE `pelacakan`
  MODIFY `id_pelacakan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pengiriman`
--
ALTER TABLE `pengiriman`
  MODIFY `id_pengiriman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_pengiriman`) REFERENCES `pengiriman` (`id_pengiriman`);

--
-- Constraints for table `pelacakan`
--
ALTER TABLE `pelacakan`
  ADD CONSTRAINT `pelacakan_ibfk_1` FOREIGN KEY (`id_pengiriman`) REFERENCES `pengiriman` (`id_pengiriman`);

--
-- Constraints for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD CONSTRAINT `pengiriman_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `pengiriman_ibfk_2` FOREIGN KEY (`id_armada`) REFERENCES `armada` (`id_armada`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
