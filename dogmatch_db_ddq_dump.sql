-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: May 18, 2020 at 07:34 PM
-- Server version: 10.4.11-MariaDB-log
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_marcojoc`
--

-- --------------------------------------------------------

--
-- Table structure for table `Adopters`
--

CREATE TABLE `Adopters` (
  `adopterID` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` char(9) NOT NULL,
  `phone` char(10) NOT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Adopters`
--

INSERT INTO `Adopters` (`adopterID`, `first_name`, `last_name`, `street`, `city`, `state`, `zip`, `phone`, `email`) VALUES
(1, 'Jenny', 'Tutone', '1882 Gerard Street', 'San Francisco', 'CA', '34567', '4158675309', 'j.tutone@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `AdoptionDetails`
--

CREATE TABLE `AdoptionDetails` (
  `app_num` int(11) NOT NULL,
  `petID` int(11) NOT NULL,
  `app_status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AdoptionDetails`
--

INSERT INTO `AdoptionDetails` (`app_num`, `petID`, `app_status`) VALUES
(100, 1, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `Applications`
--

CREATE TABLE `Applications` (
  `app_num` int(11) NOT NULL,
  `app_date` date NOT NULL,
  `shelterID` int(11) NOT NULL,
  `counselorID` int(11) NOT NULL,
  `adopterID` int(11) NOT NULL,
  `petID1` int(11) DEFAULT NULL,
  `petID2` int(11) DEFAULT NULL,
  `petID3` int(11) DEFAULT NULL,
  `meet_greet` varchar(255) NOT NULL,
  `num_adults` int(11) DEFAULT NULL,
  `num_children` int(11) DEFAULT NULL,
  `num_pets` int(11) DEFAULT NULL,
  `home_type` varchar(255) NOT NULL,
  `home_status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Applications`
--

INSERT INTO `Applications` (`app_num`, `app_date`, `shelterID`, `counselorID`, `adopterID`, `petID1`, `petID2`, `petID3`, `meet_greet`, `num_adults`, `num_children`, `num_pets`, `home_type`, `home_status`) VALUES
(100, '2020-03-12', 1, 2332, 1, 1, NULL, NULL, 'Required', 2, 0, 1, 'Single-family home', 'Homeowner');

-- --------------------------------------------------------

--
-- Table structure for table `Counselors`
--

CREATE TABLE `Counselors` (
  `counselorID` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `shelterID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Counselors`
--

INSERT INTO `Counselors` (`counselorID`, `first_name`, `last_name`, `shelterID`) VALUES
(2332, 'Matt', 'Brown', 1),
(4567, 'Cynthia', 'Green', 1),
(6789, 'Adam', 'Apple', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Dogs`
--

CREATE TABLE `Dogs` (
  `petID` int(11) NOT NULL,
  `shelterID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `gender` varchar(255) NOT NULL,
  `breed` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `adoption_status` varchar(255) NOT NULL,
  `energy_level` varchar(255) DEFAULT NULL,
  `coat_type` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `dogs_ok` char(1) NOT NULL,
  `cats_ok` char(1) NOT NULL,
  `kids_ok` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Dogs`
--

INSERT INTO `Dogs` (`petID`, `shelterID`, `name`, `birthday`, `gender`, `breed`, `size`, `adoption_status`, `energy_level`, `coat_type`, `color`, `dogs_ok`, `cats_ok`, `kids_ok`) VALUES
(1, 1, 'Bane', '2014-05-18', 'Male', 'Boxer', 'Large', 'Available', 'Medium', 'Short-Haired', 'Brindle', 'Y', 'N', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `Shelters`
--

CREATE TABLE `Shelters` (
  `shelterID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` char(9) NOT NULL,
  `phone` char(10) NOT NULL,
  `website` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Shelters`
--

INSERT INTO `Shelters` (`shelterID`, `name`, `street`, `city`, `state`, `zip`, `phone`, `website`) VALUES
(1, 'Ultimutt Dog Rescue', '12345 Bark Street', 'Pasadena', 'CA', '91106', '6261234567', 'www.UltimuttDogRescue.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Adopters`
--
ALTER TABLE `Adopters`
  ADD PRIMARY KEY (`adopterID`);

--
-- Indexes for table `AdoptionDetails`
--
ALTER TABLE `AdoptionDetails`
  ADD PRIMARY KEY (`app_num`,`petID`),
  ADD KEY `fk_pet` (`petID`);

--
-- Indexes for table `Applications`
--
ALTER TABLE `Applications`
  ADD PRIMARY KEY (`app_num`),
  ADD KEY `Applications_Shelters_fk` (`shelterID`),
  ADD KEY `Applications_Counselors_fk` (`counselorID`),
  ADD KEY `Applications_Adopters_fk` (`adopterID`),
  ADD KEY `Applications_petID_1_fk` (`petID1`),
  ADD KEY `Applications_petID_2_fk` (`petID2`),
  ADD KEY `Applications_petID_3_fk` (`petID3`);

--
-- Indexes for table `Counselors`
--
ALTER TABLE `Counselors`
  ADD PRIMARY KEY (`counselorID`),
  ADD KEY `Counselors_Shelters_fk` (`shelterID`);

--
-- Indexes for table `Dogs`
--
ALTER TABLE `Dogs`
  ADD PRIMARY KEY (`petID`),
  ADD KEY `Dogs_Shelters_fk` (`shelterID`);

--
-- Indexes for table `Shelters`
--
ALTER TABLE `Shelters`
  ADD PRIMARY KEY (`shelterID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Adopters`
--
ALTER TABLE `Adopters`
  MODIFY `adopterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Applications`
--
ALTER TABLE `Applications`
  MODIFY `app_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `Counselors`
--
ALTER TABLE `Counselors`
  MODIFY `counselorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6790;

--
-- AUTO_INCREMENT for table `Dogs`
--
ALTER TABLE `Dogs`
  MODIFY `petID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Shelters`
--
ALTER TABLE `Shelters`
  MODIFY `shelterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AdoptionDetails`
--
ALTER TABLE `AdoptionDetails`
  ADD CONSTRAINT `fk_app` FOREIGN KEY (`app_num`) REFERENCES `Applications` (`app_num`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pet` FOREIGN KEY (`petID`) REFERENCES `Dogs` (`petID`) ON DELETE CASCADE;

--
-- Constraints for table `Applications`
--
ALTER TABLE `Applications`
  ADD CONSTRAINT `Applications_Adopters_fk` FOREIGN KEY (`adopterID`) REFERENCES `Adopters` (`adopterID`),
  ADD CONSTRAINT `Applications_Counselors_fk` FOREIGN KEY (`counselorID`) REFERENCES `Counselors` (`counselorID`),
  ADD CONSTRAINT `Applications_Shelters_fk` FOREIGN KEY (`shelterID`) REFERENCES `Shelters` (`shelterID`),
  ADD CONSTRAINT `Applications_petID_1_fk` FOREIGN KEY (`petID1`) REFERENCES `Dogs` (`petID`),
  ADD CONSTRAINT `Applications_petID_2_fk` FOREIGN KEY (`petID2`) REFERENCES `Dogs` (`petID`),
  ADD CONSTRAINT `Applications_petID_3_fk` FOREIGN KEY (`petID3`) REFERENCES `Dogs` (`petID`);

--
-- Constraints for table `Counselors`
--
ALTER TABLE `Counselors`
  ADD CONSTRAINT `Counselors_Shelters_fk` FOREIGN KEY (`shelterID`) REFERENCES `Shelters` (`shelterID`);

--
-- Constraints for table `Dogs`
--
ALTER TABLE `Dogs`
  ADD CONSTRAINT `Dogs_Shelters_fk` FOREIGN KEY (`shelterID`) REFERENCES `Shelters` (`shelterID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
