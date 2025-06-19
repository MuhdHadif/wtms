-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2025 at 08:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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

CREATE DATABASE `wtms_db`;
USE `wtms_db`;

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` int(11) NOT NULL,
  `workId` int(11) NOT NULL,
  `workerId` int(11) NOT NULL,
  `submissionText` text NOT NULL,
  `submittedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `workId`, `workerId`, `submissionText`, `submittedAt`) VALUES
(12, 1, 1, 'Prepared raw material A, configured machine Alpha for Step 2.', '2025-06-18 00:22:55'),
(13, 6, 1, 'Checked booths, cleaned residual paint off surfaces, wiped environment clean for next use.', '2025-06-18 00:23:27'),
(14, 2, 2, 'Inspected machine X, found minor defects, ordered spare parts for scheduled maintenance.', '2025-06-18 00:24:39'),
(15, 7, 2, 'Labelled all boxes in Section C, sorted through all inventory, should be organised.', '2025-06-18 00:25:05'),
(16, 3, 3, 'Performed deep clean at area B, prepared audit procedures for relevant officers.', '2025-06-18 00:26:19'),
(17, 8, 3, 'Updated all records of inventory in the database system, backups copied to remote site.', '2025-06-18 00:26:49'),
(18, 4, 4, 'Performed unit tests for batch 4, packaged all circuits for further assembly.', '2025-06-18 00:31:33'),
(19, 9, 4, 'Cutting machine inspected and tuned, replaced oil before completing service.', '2025-06-18 00:32:01'),
(24, 5, 5, 'Wrote SOP for packaging unit.', '2025-06-18 00:50:11'),
(25, 10, 5, 'Collated operations data and prepared performance report, uploaded to dashboard.', '2025-06-18 00:51:15');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`id`, `fullName`, `email`, `password`, `phoneNum`, `address`) VALUES
(1, 'Muhammad Hadif bin Azri', 'muhdhadif.azri@gmail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0123456789', 'A1, Jalan Test 1/10, 10000'),
(2, 'Test Worker 2', 'worker2@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0122222222', 'N2, Jalan 2/22, 20000'),
(3, 'Worker Jones 3', 'worker3@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0133333333', 'N3, Jalan 3/33, 30000'),
(4, 'John Worker 4', 'worker4@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0144444444', 'N4, Jalan 4/44, 40000'),
(5, 'Jimmy Worker 5', 'worker5@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0155555555', 'N5, Jalan 5/55, 50000');

-- --------------------------------------------------------

--
-- Table structure for table `works`
--

CREATE TABLE `works` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `assignedTo` int(11) NOT NULL,
  `dateAssigned` date NOT NULL,
  `dueDate` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `works`
--

INSERT INTO `works` (`id`, `title`, `description`, `assignedTo`, `dateAssigned`, `dueDate`, `status`) VALUES
(1, 'Prepare Material A', 'Prepare raw material A for assembly.', 1, '2025-05-25', '2025-05-28', 'complete'),
(2, 'Inspect Machine X', 'Conduct inspection for machine X.', 2, '2025-05-25', '2025-05-29', 'complete'),
(3, 'Clean Area B', 'Deep clean work area B before audit.', 3, '2025-05-25', '2025-05-30', 'complete'),
(4, 'Test Circuit Board', 'Perform unit test for circuit batch 4.', 4, '2025-05-25', '2025-05-28', 'complete'),
(5, 'Document Process', 'Write SOP for packaging unit.', 5, '2025-05-25', '2025-05-29', 'complete'),
(6, 'Paint Booth Check', 'Routine check on painting booth.', 1, '2025-05-25', '2025-05-30', 'complete'),
(7, 'Label Inventory', 'Label all boxes in section C.', 2, '2025-05-25', '2025-05-28', 'complete'),
(8, 'Update Database', 'Update inventory in MySQL system.', 3, '2025-05-25', '2025-05-29', 'complete'),
(9, 'Maintain Equipment', 'Oil and tune cutting machine.', 4, '2025-05-25', '2025-05-30', 'complete'),
(10, 'Prepare Report', 'Prepare monthly performance report.', 5, '2025-05-25', '2025-05-30', 'complete');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_workId` (`workId`),
  ADD KEY `FK_workerId` (`workerId`);

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_assignedTo` (`assignedTo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `works`
--
ALTER TABLE `works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `FK_workId` FOREIGN KEY (`workId`) REFERENCES `works` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_workerId` FOREIGN KEY (`workerId`) REFERENCES `workers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `works`
--
ALTER TABLE `works`
  ADD CONSTRAINT `FK_assignedTo` FOREIGN KEY (`assignedTo`) REFERENCES `workers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
