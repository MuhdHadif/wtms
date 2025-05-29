-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2025 at 03:52 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wtms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNum` varchar(20) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`id`, `fullName`, `email`, `password`, `phoneNum`, `address`) VALUES
(1, 'Muhammad Hadif bin Azri ', 'muhdhadif.azri@gmail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0123456789', 'A1, Jalan Test 1/10, 10000, Selangor'),
(2, 'Test Worker 2', 'worker2@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0122222222', 'N2, Jalan 2/22, 20000'),
(3, 'Worker Jones 3', 'worker3@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0133333333', 'N3, Jalan 3/33, 30000'),
(4, 'John Worker 4', 'worker4@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0144444444', 'N4, Jalan 4/44, 40000'),
(5, 'Jimmy Worker 5', 'worker5@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0155555555', 'N5, Jalan 5/55, 50000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
