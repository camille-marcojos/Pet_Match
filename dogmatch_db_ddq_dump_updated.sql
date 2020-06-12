-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Jun 11, 2020 at 06:40 PM
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
(4, 'Frederick', 'Jimenez', '10791 Sonora Ave', 'Rancho Cucamonga', 'CA', '91737', '5555555555', 'fredj@hotmail.com'),
(5, 'Tay', 'Duke', '555 Collier Street', 'Austin', 'TX', '78704', '9095555555', 'tduke@gmail.com'),
(7, 'John', 'Wick', '12345 Earth Rd', 'Mars', 'KY', '00000', '9093456789', 'johnwick@gmail.com'),
(12, 'Jane', 'Doe', '1111 main st', 'pleasantville', 'HI', '99999', '5551110000', 'jane.d@hotmail.com'),
(15, 'Henry', 'Smith', '12345 Nowhere St', 'City', 'CA', '91737', '1234567890', 'hsmith@gmail.com');

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
(125, 11, 'Pending'),
(126, 12, 'Pending'),
(128, 11, 'Pending'),
(128, 12, 'Pending'),
(129, 13, 'Pending'),
(129, 14, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `Applications`
--

CREATE TABLE `Applications` (
  `app_num` int(11) NOT NULL,
  `app_date` date NOT NULL,
  `shelterID` int(11) NOT NULL,
  `counselorID` int(11) DEFAULT NULL,
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
(125, '2020-01-02', 1, 6798, 4, 11, NULL, NULL, 'Required', 1, 1, 1, 'Single-family home', 'Homeowner'),
(126, '2019-05-12', 1, 6800, 5, 12, NULL, NULL, 'N/A', 1, 2, 0, 'Multi-family home', 'Renter'),
(128, '2019-11-12', 1, 6801, 7, 11, 12, NULL, 'N/A', 2, 0, 1, 'Multi-family home', 'Live with Parents'),
(129, '2019-11-12', 1, 6803, 15, 14, 13, NULL, 'N/A', 2, 0, 0, 'Single-family home', 'Homeowner');

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
(6798, 'Luna', 'Lovegood', 1),
(6800, 'Tom', 'Riddle', 1),
(6801, 'Harry', 'Potter', 1),
(6803, 'Ron', 'Weasley', 1);

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
(11, 1, 'Abbey', '2010-01-02', 'Female', 'Chorkie', 'Small', 'Available', 'High', 'Short-Haired', 'Brown', 'Y', 'Y', 'Y'),
(12, 1, 'Foxy', '2011-01-02', 'Male', 'Chihuahua', 'Small', 'Available', 'Low', 'Short', 'Brown', 'Y', 'Y', 'Y'),
(13, 1, 'Samson', '2019-02-05', 'Male', 'Golden Retriever', 'Large', 'Available', 'High', 'Long', 'Yellow', 'Y', 'Y', 'Y'),
(14, 1, 'Bane', '2015-05-05', 'Male', 'Boxer', 'Large', 'Available', 'High', 'Brindle', 'brown', 'N', 'N', 'N');

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
  ADD KEY `Applications_Adopters_fk` (`adopterID`),
  ADD KEY `Applications_petID_1_fk` (`petID1`),
  ADD KEY `Applications_petID_2_fk` (`petID2`),
  ADD KEY `Applications_petID_3_fk` (`petID3`),
  ADD KEY `Applications_Counselors_fk` (`counselorID`);

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
  MODIFY `adopterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `Applications`
--
ALTER TABLE `Applications`
  MODIFY `app_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `Counselors`
--
ALTER TABLE `Counselors`
  MODIFY `counselorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6805;

--
-- AUTO_INCREMENT for table `Dogs`
--
ALTER TABLE `Dogs`
  MODIFY `petID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  ADD CONSTRAINT `fk_app` FOREIGN KEY (`app_num`) REFERENCES `Applications` (`app_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pet` FOREIGN KEY (`petID`) REFERENCES `Dogs` (`petID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Applications`
--
ALTER TABLE `Applications`
  ADD CONSTRAINT `Applications_Adopters_fk` FOREIGN KEY (`adopterID`) REFERENCES `Adopters` (`adopterID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Applications_Counselors_fk` FOREIGN KEY (`counselorID`) REFERENCES `Counselors` (`counselorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Applications_Shelters_fk` FOREIGN KEY (`shelterID`) REFERENCES `Shelters` (`shelterID`),
  ADD CONSTRAINT `Applications_petID_1_fk` FOREIGN KEY (`petID1`) REFERENCES `Dogs` (`petID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Applications_petID_2_fk` FOREIGN KEY (`petID2`) REFERENCES `Dogs` (`petID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Applications_petID_3_fk` FOREIGN KEY (`petID3`) REFERENCES `Dogs` (`petID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Counselors`
--
ALTER TABLE `Counselors`
  ADD CONSTRAINT `Counselors_Shelters_fk` FOREIGN KEY (`shelterID`) REFERENCES `Shelters` (`shelterID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
