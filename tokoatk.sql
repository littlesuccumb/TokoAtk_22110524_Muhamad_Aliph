-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Jul 2025 pada 09.15
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tokoatk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id` varchar(10) NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `jenis` varchar(16) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id`, `nama`, `jenis`, `harga`, `stok`) VALUES
('BRG2038', 'Stapler', 'Perlengkapan', 12000, 28),
('BRG3904', 'Tip-Ex', 'Alat Tulis', 6000, 30),
('BRG3R7ZE', 'Busur Derajat', 'Alat Ukur', 2000, 40),
('BRG4932', 'Pensil 2B', 'Alat Tulis', 5000, 10),
('BRG5821', 'Buku Tulis', 'Kertas', 8000, 40),
('BRG6774', 'Kertas HVS', 'Kertas', 15000, -11),
('BRG7489', 'Penggaris', 'Alat Ukur', 4500, 25),
('BRG8125', 'Pulpen', 'Alat Tulis', 4000, 30),
('BRG8842', 'Amplop Coklat', 'Kertas', 2000, 44),
('BRG8QN4H', 'Penghapus', 'Alat Tulis', 1000, 33),
('BRG9613', 'Map Folder', 'Perlengkapan', 7000, 7),
('BRGF6PJ6', 'Jangka', 'Alat Ukur', 10000, 25),
('BRGFB50S', 'Spidol', 'Alat Tulis', 5000, 40),
('BRGV6A0F', 'Tas', 'Perlengkapan', 30000, 60);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `aksi` text DEFAULT NULL,
  `waktu` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id`, `username`, `aksi`, `waktu`) VALUES
(1, 'Aliph', 'Menambahkan barang baru: Jangka (BRGF6PJ6)', '2025-06-26 21:37:39'),
(2, 'Rinda', 'Login ke sistem', '2025-06-26 21:51:15'),
(3, 'Rinda', 'Login ke sistem', '2025-06-26 21:53:12'),
(4, 'Rinda', 'Menambahkan barang baru: Tas (BRGV6A0F)', '2025-06-26 22:02:40'),
(5, 'Aliph', 'Login ke sistem', '2025-06-26 22:28:20'),
(6, 'Aliph', 'Login ke sistem', '2025-06-26 22:59:59'),
(7, 'Aliph', 'Login ke sistem', '2025-06-26 23:07:45'),
(8, 'Aliph', 'Login ke sistem', '2025-06-26 23:43:24'),
(9, 'Aliph', 'Login ke sistem', '2025-06-27 00:15:27'),
(10, 'Rinda', 'Login ke sistem', '2025-06-27 00:21:10'),
(11, 'Rinda', 'Login ke sistem', '2025-06-27 00:21:58'),
(12, 'Aliph', 'Login ke sistem', '2025-06-27 00:29:33'),
(13, 'Rinda', 'Login ke sistem', '2025-06-27 00:37:50'),
(14, 'Aliph', 'Login ke sistem', '2025-06-27 00:39:31'),
(15, 'Rinda', 'Login ke sistem', '2025-06-27 00:58:45'),
(16, 'Rinda', 'Menambahkan barang baru: Spidol (BRGFB50S)', '2025-06-27 01:18:28'),
(17, 'Rinda', 'Login ke sistem', '2025-06-27 17:08:31'),
(18, 'Aliph', 'Login ke sistem', '2025-06-27 20:38:58'),
(19, 'Aliph', 'Login ke sistem', '2025-06-27 20:42:45'),
(20, 'Aliph', 'Login ke sistem', '2025-06-27 20:48:28'),
(21, 'Aliph', 'Login ke sistem', '2025-07-01 11:36:16'),
(22, 'Aliph', 'Login ke sistem', '2025-07-01 12:11:12'),
(23, 'Aliph', 'Login ke sistem', '2025-07-01 12:14:53'),
(24, 'Aliph', 'Login ke sistem', '2025-07-01 12:15:19'),
(25, 'Aliph', 'Login ke sistem', '2025-07-04 09:14:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `salesd`
--

CREATE TABLE `salesd` (
  `id` int(11) NOT NULL,
  `salesId` varchar(20) DEFAULT NULL,
  `barangId` varchar(10) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `salesd`
--

INSERT INTO `salesd` (`id`, `salesId`, `barangId`, `qty`, `harga`) VALUES
(11, 'TRX20250625013434', 'BRG9613', 12, 7000),
(12, 'TRX20250625013504', 'BRG2038', 15, 12000),
(13, 'TRX20250625013526', 'BRG4932', 20, 5000),
(14, 'TRX20250625013605', 'BRG8QN4H', 17, 1000),
(15, 'TRX20250626022955', 'BRG2038', 17, 12000),
(16, 'TRX20250626212640', 'BRG5821', 8, 8000),
(17, 'TRX20250626212653', 'BRG7489', 10, 4500),
(18, 'TRX20250626212737', 'BRG6774', 15, 15000),
(19, 'TRX20250627001924', 'BRG2038', 2, 12000),
(20, 'TRX20250701121643', 'BRG9613', 10, 7000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `salesm`
--

CREATE TABLE `salesm` (
  `id` varchar(20) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `salesm`
--

INSERT INTO `salesm` (`id`, `waktu`, `username`) VALUES
('TRX20250625013434', '2025-06-25 01:34:34', 'Aliph'),
('TRX20250625013504', '2025-06-25 01:35:04', 'Aliph'),
('TRX20250625013526', '2025-06-25 01:35:26', 'Aliph'),
('TRX20250625013605', '2025-06-25 01:36:05', 'Aliph'),
('TRX20250626022955', '2025-06-26 02:29:55', 'admin'),
('TRX20250626212640', '2025-06-26 21:26:40', 'Aliph'),
('TRX20250626212653', '2025-06-26 21:26:53', 'Aliph'),
('TRX20250626212737', '2025-06-26 21:27:37', 'Aliph'),
('TRX20250627001924', '2025-06-27 00:19:24', 'Aliph'),
('TRX20250701121643', '2025-07-01 12:16:43', 'Aliph');

-- --------------------------------------------------------

--
-- Struktur dari tabel `stockd`
--

CREATE TABLE `stockd` (
  `id` int(11) NOT NULL,
  `stockId` varchar(16) DEFAULT NULL,
  `barangId` varchar(10) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `stockd`
--

INSERT INTO `stockd` (`id`, `stockId`, `barangId`, `qty`, `harga`) VALUES
(9, 'IN20250625014156', 'BRG5821', 15, 8000),
(10, 'IN20250626023019', 'BRG2038', 20, 12000),
(11, 'IN20250626204721', 'BRG4932', 20, 5000),
(12, 'IN20250626204730', 'BRG9613', 20, 7000),
(13, 'IN20250701121658', 'BRGV6A0F', 10, 30000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `stockm`
--

CREATE TABLE `stockm` (
  `id` varchar(16) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `stockm`
--

INSERT INTO `stockm` (`id`, `waktu`, `username`) VALUES
('IN20250625014156', '2025-06-25 01:41:56', 'Aliph'),
('IN20250626023019', '2025-06-26 02:30:19', 'admin'),
('IN20250626204721', '2025-06-26 20:47:21', 'Aliph'),
('IN20250626204730', '2025-06-26 20:47:30', 'Aliph'),
('IN20250701121658', '2025-07-01 12:16:58', 'Aliph');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `fullname` varchar(30) DEFAULT NULL,
  `password` char(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`username`, `fullname`, `password`) VALUES
('admin', 'Muhamad Aliph Fauzansyah', '0192023a7bbd73250516f069df18b500'),
('Aliph', 'Muhamad Aliph F', '0192023a7bbd73250516f069df18b500'),
('All', 'Muhamad Aliph Ganteng', '0c909a141f1f2c0a1cb602b0b2d7d050'),
('Rinda', 'Rinda Tiara', '21232f297a57a5a743894a0e4a801fc3');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `salesd`
--
ALTER TABLE `salesd`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_salesd_barang` (`barangId`),
  ADD KEY `salesd_ibfk_1` (`salesId`);

--
-- Indeks untuk tabel `salesm`
--
ALTER TABLE `salesm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indeks untuk tabel `stockd`
--
ALTER TABLE `stockd`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stockId` (`stockId`),
  ADD KEY `fk_stockd_barang` (`barangId`);

--
-- Indeks untuk tabel `stockm`
--
ALTER TABLE `stockm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `salesd`
--
ALTER TABLE `salesd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `stockd`
--
ALTER TABLE `stockd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `salesd`
--
ALTER TABLE `salesd`
  ADD CONSTRAINT `fk_salesd_barang` FOREIGN KEY (`barangId`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salesd_ibfk_1` FOREIGN KEY (`salesId`) REFERENCES `salesm` (`id`);

--
-- Ketidakleluasaan untuk tabel `salesm`
--
ALTER TABLE `salesm`
  ADD CONSTRAINT `salesm_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Ketidakleluasaan untuk tabel `stockd`
--
ALTER TABLE `stockd`
  ADD CONSTRAINT `fk_stockd_barang` FOREIGN KEY (`barangId`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stockd_ibfk_1` FOREIGN KEY (`stockId`) REFERENCES `stockm` (`id`);

--
-- Ketidakleluasaan untuk tabel `stockm`
--
ALTER TABLE `stockm`
  ADD CONSTRAINT `stockm_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
