-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.39 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.17.0.7270
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for narcissushotel
CREATE DATABASE IF NOT EXISTS `narcissushotel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `narcissushotel`;

-- Dumping structure for table narcissushotel.booking
CREATE TABLE IF NOT EXISTS `booking` (
  `Booking_id` int NOT NULL,
  `Guest_id` int NOT NULL,
  `Room_id` int NOT NULL,
  `Booking_date` date NOT NULL,
  `Check_in_date` date NOT NULL,
  `Check_out_date` date NOT NULL,
  `Booking_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Number_of_guests` int NOT NULL,
  PRIMARY KEY (`Booking_id`),
  KEY `FK_  BOOKING_guest` (`Guest_id`),
  KEY `FK_  BOOKING_room` (`Room_id`),
  CONSTRAINT `FK_  BOOKING_guest` FOREIGN KEY (`Guest_id`) REFERENCES `guest` (`Guest_id`),
  CONSTRAINT `FK_  BOOKING_room` FOREIGN KEY (`Room_id`) REFERENCES `room` (`Room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.booking: ~1 rows (approximately)
INSERT INTO `booking` (`Booking_id`, `Guest_id`, `Room_id`, `Booking_date`, `Check_in_date`, `Check_out_date`, `Booking_status`, `Number_of_guests`) VALUES
	(401, 1, 301, '2026-05-15', '2026-05-20', '2026-05-22', 'Confirmed', 1);

-- Dumping structure for table narcissushotel.branch
CREATE TABLE IF NOT EXISTS `branch` (
  `Branch_id` int NOT NULL,
  `Branch_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `City` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Address` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Manager_id` int DEFAULT NULL,
  PRIMARY KEY (`Branch_id`),
  KEY `Manager_id` (`Manager_id`),
  CONSTRAINT `Manager_id` FOREIGN KEY (`Manager_id`) REFERENCES `employee` (`Employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.branch: ~1 rows (approximately)
INSERT INTO `branch` (`Branch_id`, `Branch_name`, `City`, `Address`, `Phone`, `Email`, `Manager_id`) VALUES
	(1, 'Narcissus Hotel Riyadh', 'Riyadh', 'Al Olaya', '+966112946300', 'reservations.riyadh@narcissushotels.com', 101);

-- Dumping structure for table narcissushotel.employee
CREATE TABLE IF NOT EXISTS `employee` (
  `Employee_id` int NOT NULL,
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Job_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Salary` decimal(10,2) NOT NULL,
  `Branch_id` int NOT NULL,
  PRIMARY KEY (`Employee_id`),
  KEY `FK_EMPLOYEE_branch` (`Branch_id`),
  CONSTRAINT `FK_employee_branch` FOREIGN KEY (`Branch_id`) REFERENCES `branch` (`Branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.employee: ~1 rows (approximately)
INSERT INTO `employee` (`Employee_id`, `Name`, `Job_title`, `Phone_number`, `Email`, `Salary`, `Branch_id`) VALUES
	(101, 'Sara Ahmed', 'Manager', '0501112233', 'sara@narcissus.com', 12000.00, 1);

-- Dumping structure for table narcissushotel.guest
CREATE TABLE IF NOT EXISTS `guest` (
  `Guest_id` int NOT NULL,
  `National_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `First_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Nationality` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Guest_id`),
  UNIQUE KEY `National_id` (`National_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.guest: ~1 rows (approximately)
INSERT INTO `guest` (`Guest_id`, `National_id`, `First_name`, `Last_name`, `Phone_number`, `Email`, `Nationality`) VALUES
	(1, NULL, 'Lujain', 'Abdullah', '0512345678', NULL, 'saudi'),
	(2, '1111111111', 'Aryam', 'Almutairi', '0502694455', NULL, NULL);

-- Dumping structure for table narcissushotel.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `Payment_id` int NOT NULL,
  `Payment_date` date NOT NULL,
  `Payment_amount` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `Payment_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `Payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `BookingId` int NOT NULL DEFAULT (0),
  PRIMARY KEY (`Payment_id`),
  KEY `BookingId` (`BookingId`),
  CONSTRAINT `BookingId` FOREIGN KEY (`BookingId`) REFERENCES `booking` (`Booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.payment: ~1 rows (approximately)
INSERT INTO `payment` (`Payment_id`, `Payment_date`, `Payment_amount`, `Payment_status`, `Payment_method`, `BookingId`) VALUES
	(501, '2026-05-15', 350.000000, 'Paid', 'Card', 401);

-- Dumping structure for table narcissushotel.room
CREATE TABLE IF NOT EXISTS `room` (
  `Room_id` int NOT NULL,
  `Room_number` int NOT NULL,
  `Room_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Price_per_night` decimal(10,2) NOT NULL,
  `Capacity` int NOT NULL,
  `Room_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Branch_id` int NOT NULL,
  PRIMARY KEY (`Room_id`),
  UNIQUE KEY `Room_number` (`Room_number`),
  KEY `FK_ROOM_branch` (`Branch_id`),
  CONSTRAINT `FK_ROOM_branch` FOREIGN KEY (`Branch_id`) REFERENCES `branch` (`Branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table narcissushotel.room: ~1 rows (approximately)
INSERT INTO `room` (`Room_id`, `Room_number`, `Room_type`, `Price_per_night`, `Capacity`, `Room_status`, `Branch_id`) VALUES
	(301, 101, 'Single', 350.00, 1, 'Available', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
