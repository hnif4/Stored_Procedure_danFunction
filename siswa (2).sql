-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3310
-- Generation Time: Aug 05, 2024 at 07:48 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siswa`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSiswaByBorn` (IN `placeOfBirth` VARCHAR(50))   BEGIN
    SELECT * FROM data_siswa WHERE tempat_lahir = placeOfBirth;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isiNilaiSiswa` (IN `siswa_nis` VARCHAR(10), IN `nilai_ipa` INT, IN `nilai_ips` INT, IN `nilai_matematika` INT)   BEGIN
    INSERT INTO nilai_siswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA) 
    VALUES (siswa_nis, nilai_ipa, nilai_ips, nilai_matematika);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validSiswa` (IN `nis` CHAR(5), IN `nilai_IPA` INT, IN `nilai_IPS` INT, IN `nilai_MATEMATIKA` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO nilai_siswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA) 
    VALUES (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA);
    COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getJmlByGender` (`gender_param` VARCHAR(10)) RETURNS INT DETERMINISTIC BEGIN
    DECLARE jumlah INT;
    SELECT COUNT(*) INTO jumlah FROM data_siswa WHERE gender = gender_param;
    RETURN jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `data_siswa`
--

CREATE TABLE `data_siswa` (
  `nis` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `tempat_lahir` varchar(50) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `gender` varchar(11) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `data_siswa`
--

INSERT INTO `data_siswa` (`nis`, `nama`, `tempat_lahir`, `tgl_lahir`, `gender`, `alamat`) VALUES
(1233, 'Kamila', 'Asahan', '1980-01-25', 'P', 'dekeng'),
(89120, 'Fahmi', 'Asahan', '1983-07-12', 'L', 'Jl. Medan 17'),
(89121, 'Toni', 'Bogor', '1980-01-25', 'L', 'Jl. Bogor 21'),
(89122, 'Mona', 'Jakarta', '1984-08-01', 'P', 'Jl. Danau Toba 34'),
(89123, 'Monika', 'Bandung', '1982-02-13', 'P', 'Jl. Samosir 39'),
(89124, 'Eno', 'Surabaya', '1984-04-01', 'P', 'Jl. Siantar 66'),
(89125, 'Fitri', 'Jakarta', '1983-08-01', 'P', 'Jl. Sei rempah 45'),
(89127, 'Hotdi', 'Bogor', '1983-09-01', 'P', 'Jl. Kartika 3'),
(89129, 'Yuni', 'Malang', '1984-10-18', 'P', 'Jl. Kisaran 56');

--
-- Triggers `data_siswa`
--
DELIMITER $$
CREATE TRIGGER `after_siswa_delete` AFTER DELETE ON `data_siswa` FOR EACH ROW BEGIN
    INSERT INTO SiswaKeluar (nis, tgl_hapus) VALUES (OLD.nis, CURDATE());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nilai_siswa`
--

CREATE TABLE `nilai_siswa` (
  `nis` int NOT NULL,
  `nilai_IPA` int NOT NULL,
  `nilai_IPS` int NOT NULL,
  `nilai_MATEMATIKA` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `nilai_siswa`
--

INSERT INTO `nilai_siswa` (`nis`, `nilai_IPA`, `nilai_IPS`, `nilai_MATEMATIKA`) VALUES
(999, 90, 90, 90),
(19000, 90, 100, 100),
(89121, 85, 90, 88),
(89122, 70, 60, 90),
(89123, 60, 60, 90),
(89124, 80, 50, 100),
(89125, 40, 60, 80),
(89126, 50, 65, 90),
(89127, 70, 80, 90),
(89128, 100, 60, 40),
(89129, 90, 100, 95),
(89130, 85, 75, 90),
(89131, 85, 90, 23),
(89133, 85, 90, 88);

-- --------------------------------------------------------

--
-- Table structure for table `siswakeluar`
--

CREATE TABLE `siswakeluar` (
  `nis` char(5) NOT NULL,
  `tgl_hapus` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswakeluar`
--

INSERT INTO `siswakeluar` (`nis`, `tgl_hapus`) VALUES
('89121', '2024-08-05'),
('89126', '2024-08-05'),
('2222', '2024-08-05'),
('22222', '2024-08-05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_siswa`
--
ALTER TABLE `data_siswa`
  ADD PRIMARY KEY (`nis`);

--
-- Indexes for table `nilai_siswa`
--
ALTER TABLE `nilai_siswa`
  ADD PRIMARY KEY (`nis`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_siswa`
--
ALTER TABLE `data_siswa`
  MODIFY `nis` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89130;

--
-- AUTO_INCREMENT for table `nilai_siswa`
--
ALTER TABLE `nilai_siswa`
  MODIFY `nis` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89134;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
