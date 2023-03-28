-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 22 Jan 2023 pada 05.10
-- Versi Server: 10.1.19-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jgrp`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL DEFAULT '-',
  `ownerid` int(11) NOT NULL DEFAULT '0',
  `address` varchar(50) DEFAULT 'None',
  `price` int(11) NOT NULL DEFAULT '500000',
  `type` int(11) NOT NULL DEFAULT '1',
  `locked` int(11) NOT NULL DEFAULT '1',
  `money` int(11) NOT NULL DEFAULT '0',
  `houseint` int(11) NOT NULL DEFAULT '0',
  `extvw` int(11) NOT NULL DEFAULT '0',
  `extint` int(11) NOT NULL DEFAULT '0',
  `extposx` float NOT NULL DEFAULT '0',
  `extposy` float NOT NULL DEFAULT '0',
  `extposz` float NOT NULL DEFAULT '0',
  `extposa` float NOT NULL DEFAULT '0',
  `intposx` float NOT NULL DEFAULT '0',
  `intposy` float NOT NULL DEFAULT '0',
  `intposz` float NOT NULL DEFAULT '0',
  `intposa` float NOT NULL DEFAULT '0',
  `visit` bigint(16) DEFAULT '0',
  `garage` int(11) NOT NULL DEFAULT '0',
  `garageposx` float NOT NULL DEFAULT '0',
  `garageposy` float NOT NULL DEFAULT '0',
  `garageposz` float NOT NULL DEFAULT '0',
  `houseBuilder` int(11) NOT NULL DEFAULT '0',
  `houseBuilderTime` int(11) NOT NULL DEFAULT '0',
  `houseWeapon1` int(12) DEFAULT '0',
  `houseAmmo1` int(12) DEFAULT '0',
  `houseWeapon2` int(12) DEFAULT '0',
  `houseAmmo2` int(12) DEFAULT '0',
  `houseWeapon3` int(12) DEFAULT '0',
  `houseAmmo3` int(12) DEFAULT '0',
  `houseWeapon4` int(12) DEFAULT '0',
  `houseAmmo4` int(12) DEFAULT '0',
  `houseWeapon5` int(12) DEFAULT '0',
  `houseAmmo5` int(12) DEFAULT '0',
  `houseWeapon6` int(12) DEFAULT '0',
  `houseAmmo6` int(12) DEFAULT '0',
  `houseWeapon7` int(12) DEFAULT '0',
  `houseAmmo7` int(12) DEFAULT '0',
  `houseWeapon8` int(12) DEFAULT '0',
  `houseAmmo8` int(12) DEFAULT '0',
  `houseWeapon9` int(12) DEFAULT '0',
  `houseAmmo9` int(12) DEFAULT '0',
  `houseWeapon10` int(12) DEFAULT '0',
  `houseAmmo10` int(12) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `houses`
--

INSERT INTO `houses` (`ID`, `owner`, `ownerid`, `address`, `price`, `type`, `locked`, `money`, `houseint`, `extvw`, `extint`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `visit`, `garage`, `garageposx`, `garageposy`, `garageposz`, `houseBuilder`, `houseBuilderTime`, `houseWeapon1`, `houseAmmo1`, `houseWeapon2`, `houseAmmo2`, `houseWeapon3`, `houseAmmo3`, `houseWeapon4`, `houseAmmo4`, `houseWeapon5`, `houseAmmo5`, `houseWeapon6`, `houseAmmo6`, `houseWeapon7`, `houseAmmo7`, `houseWeapon8`, `houseAmmo8`, `houseWeapon9`, `houseAmmo9`, `houseWeapon10`, `houseAmmo10`) VALUES
(0, 'Kyle_Garrick', 25, 'Richman', 11500000, 3, 0, 0, 5, 0, 0, 254.383, -1367.13, 53.1094, 308.929, 1384.5, 1518.17, 10.95, 270.38, 1674312284, 0, 248.51, -1358.53, 53.1094, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2514.34, -1691.59, 14.046, 229.906, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, '-', 0, 'Ganton', 7500000, 1, 1, 0, 3, 0, 0, 2523.27, -1679.39, 15.497, 275.339, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2520.28, -1673.85, 14.7769, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2524.71, -1658.61, 15.824, 270.302, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2513.72, -1650.28, 14.3557, 313.519, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2498.44, -1642.25, 14.1131, 0.519263, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, '-', 0, 'Ganton', 7500000, 2, 1, 0, 4, 0, 0, 2486.47, -1644.54, 14.0772, 0.220285, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2469.5, -1646.36, 13.7801, 359.266, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2451.89, -1641.41, 14.0662, 4.00511, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2459.48, -1691.65, 13.5454, 176.967, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2413.89, -1646.82, 14.0119, 3.20448, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2393.17, -1646.04, 13.9051, 357.251, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2362.92, -1643.15, 14.3516, 1.92783, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2409, -1674.92, 14.375, 179.88, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2384.65, -1675.83, 15.2457, 179.253, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2368.32, -1675.34, 14.1682, 178.313, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, '-', 0, 'Ganton', 7500000, 1, 1, 0, 3, 0, 0, 2326.89, -1681.98, 14.9297, 89.6387, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2325.47, -1677.28, 14.4219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, '-', 0, 'Ganton', 7500000, 1, 1, 0, 3, 0, 0, 2385.42, -1711.67, 14.2422, 3.69983, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2390.02, -1710.45, 13.6237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2326.83, -1716.7, 14.2379, 4.92978, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2308.9, -1714.33, 14.9801, 0.206532, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2307.01, -1679.19, 14.3316, 183.775, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2282.31, -1641.22, 15.8898, 359.534, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2257.16, -1643.99, 15.8082, 351.073, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, '-', 0, 'Ganton', 6000000, 1, 1, 0, 3, 0, 0, 2244.51, -1637.63, 16.2379, 339.479, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, '-', 0, 'East Los Santos', 7500000, 2, 1, 0, 4, 0, 0, 2439.59, -1357.16, 24.1006, 86.6713, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, '-', 0, 'East Los Santos', 7500000, 2, 1, 0, 4, 0, 0, 2439.59, -1338.86, 24.1016, 93.2514, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, '-', 0, 'East Los Santos', 7500000, 2, 1, 0, 4, 0, 0, 2433.94, -1320.72, 25.3234, 87.298, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, '-', 0, 'East Los Santos', 7500000, 2, 1, 0, 4, 0, 0, 2433.93, -1303.39, 25.3234, 92.9381, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2434.81, -1289.35, 25.3479, 91.6847, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2433.63, -1274.98, 24.7567, 94.5047, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2470.37, -1295.53, 30.2332, 270.31, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2469.18, -1278.34, 30.3664, 273.13, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, '-', 0, 'East Los Santos', 7500000, 1, 1, 0, 3, 0, 0, 2550.93, -1233.81, 49.3318, 359.297, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2547.29, -1245.87, 42.0919, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, '-', 0, 'East Los Santos', 9000000, 2, 1, 0, 4, 0, 0, 2529.67, -1243.32, 43.9719, 359.923, 431, 612.65, 1000.22, 89.33, 0, 1, 2530.91, -1246.01, 37.5727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, '-', 0, 'East Los Santos', 9000000, 2, 1, 0, 4, 0, 0, 2514.55, -1240.46, 39.3406, 356.743, 431, 612.65, 1000.22, 89.33, 0, 1, 2518.82, -1248.73, 35.0625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, '-', 0, 'East Los Santos', 7500000, 1, 1, 0, 3, 0, 0, 2492.15, -1239.01, 37.9054, 2.64952, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2486.57, -1246.1, 30.955, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, '-', 0, 'East Los Santos', 7500000, 1, 1, 0, 3, 0, 0, 2472.99, -1238.15, 32.5695, 3.56628, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2466.45, -1245.99, 25.5106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2467.63, -1200.41, 36.8117, 177.421, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, '-', 0, 'Las Colinas', 7500000, 1, 1, 0, 3, 0, 0, 2394.94, -1133.54, 30.7188, 3.0732, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2399.49, -1132.89, 30.1495, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2373.99, -1138.94, 29.0588, 358.686, 387.78, 634.47, 1009.67, 91.58, 0, 0, 2399.43, -1132.86, 30.1491, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2427.41, -1135.77, 34.7109, 359, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, '-', 0, 'East Los Santos', 6000000, 1, 1, 0, 3, 0, 0, 2488.15, -1135.24, 39.5859, 3.38657, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2510.57, -1132.66, 41.6207, 272.832, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, '-', 0, 'Las Colinas', 7500000, 2, 1, 0, 4, 0, 0, 2625.96, -1112.63, 67.9953, 87.3606, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, '-', 0, 'Las Colinas', 7500000, 2, 1, 0, 4, 0, 0, 2625.95, -1098.75, 69.3566, 91.7473, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, '-', 0, 'Las Colinas', 7500000, 2, 1, 0, 4, 0, 0, 2627.64, -1085.22, 69.7156, 92.0606, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, '-', 0, 'Las Colinas', 7500000, 2, 1, 0, 4, 0, 0, 2628.11, -1067.9, 69.7156, 90.8073, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2576.67, -1070.68, 69.8322, 268.469, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2572.39, -1091.75, 67.2257, 225.855, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2519.04, -1113.08, 56.5926, 91.7473, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2470.63, -1105.3, 44.4879, 180.422, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2457.03, -1102.5, 43.8672, 180.108, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2438.65, -1105.74, 43.0816, 177.602, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(53, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2407.89, -1106.94, 40.2957, 181.675, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(54, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2579.68, -1033.21, 69.5798, 356.713, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(55, '-', 0, 'Las Colinas', 6000000, 1, 1, 0, 3, 0, 0, 2512.77, -1027.17, 70.0859, 358.017, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2250.27, -1280.06, 25.4766, 0.935235, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(57, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2230.14, -1280.07, 25.6285, 3.41862, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2208, -1280.83, 25.1207, 356.839, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(59, '-', 0, 'Jefferson', 7500000, 1, 1, 0, 3, 0, 0, 2191.62, -1275.6, 25.1562, 355.562, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2196.22, -1274.94, 24.5371, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(60, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2191.78, -1239.23, 24.4879, 185.107, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(61, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2209.76, -1240.23, 24.4801, 180.407, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(62, '-', 0, 'Jefferson', 7500000, 1, 1, 0, 3, 0, 0, 2229.61, -1241.61, 25.6562, 176.31, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2225.01, -1242.47, 25.3716, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(63, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2249.85, -1238.91, 25.8984, 170.983, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(64, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2150.24, -1285.06, 24.5269, 4.28843, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(65, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2132.29, -1280.05, 25.8906, 1.4682, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(66, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2111.3, -1278.98, 25.8359, 10.8685, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(67, '-', 0, 'Jefferson', 7500000, 1, 1, 0, 3, 0, 0, 2091.01, -1277.84, 26.1797, 3.34843, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2095.69, -1276.93, 25.4932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(68, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2153.76, -1243.8, 25.3672, 187.253, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(69, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2133.38, -1232.99, 24.4219, 176.287, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(70, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2110.9, -1244.39, 25.8516, 187.253, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(71, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2090.77, -1235.17, 26.0191, 178.77, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(72, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2148.51, -1320.08, 26.0738, 183.784, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(73, '-', 0, 'Jefferson', 7500000, 2, 1, 0, 4, 0, 0, 2126.67, -1320.86, 26.6241, 187.544, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(74, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2100.89, -1321.86, 25.9531, 185.663, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(75, '-', 0, 'Jefferson', 7500000, 2, 1, 0, 4, 0, 0, 2148.93, -1484.89, 26.6241, 268.338, 431, 612.65, 1000.22, 89.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(76, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2146.8, -1470.47, 26.0426, 270.218, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(77, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2152.21, -1446.35, 26.1051, 264.867, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2149.85, -1433.74, 26.0703, 271.737, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2150.92, -1419.07, 25.9219, 273.931, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(80, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2151.18, -1400.65, 26.1285, 268.604, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(81, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2147.68, -1366.12, 25.9723, 7.28155, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(82, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2129.65, -1361.7, 26.1363, 2.89475, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(83, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2202.72, -1363.68, 26.191, 356.001, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(84, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2185.16, -1363.71, 26.1598, 5.08823, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(85, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2196.21, -1404.15, 25.9488, 89.0389, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(86, '-', 0, 'Jefferson', 7500000, 1, 1, 0, 3, 0, 0, 2188.58, -1419.32, 26.1562, 88.0989, 387.78, 634.47, 1009.67, 91.58, 0, 1, 2187.87, -1414.6, 25.5391, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(87, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2194.35, -1442.9, 26.0738, 94.0289, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(88, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2191.1, -1455.82, 26, 91.8356, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(89, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2190.45, -1470.4, 25.9141, 94.3423, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(90, '-', 0, 'Jefferson', 6000000, 1, 1, 0, 3, 0, 0, 2190.32, -1487.66, 26.1051, 87.7622, 387.78, 634.47, 1009.67, 91.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
