-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 10.123.0.222:3307
-- Generation Time: Jan 04, 2021 at 03:57 PM
-- Server version: 8.0.21
-- PHP Version: 7.0.33-0+deb9u10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `togetherweca_lexus`
--

-- --------------------------------------------------------

--
-- Table structure for table `credits`
--

CREATE TABLE `credits` (
  `user_id` int NOT NULL,
  `credits` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `credits`
--

INSERT INTO `credits` (`user_id`, `credits`) VALUES
(1, 998),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `credit_additions`
--

CREATE TABLE `credit_additions` (
  `user_id` int NOT NULL,
  `credits_added` int NOT NULL,
  `DateTime` datetime NOT NULL,
  `bywho` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `credit_additions`
--

INSERT INTO `credit_additions` (`user_id`, `credits_added`, `DateTime`, `bywho`) VALUES
(1, 500, '2021-01-04 15:33:44', 1);

-- --------------------------------------------------------

--
-- Table structure for table `message_info`
--

CREATE TABLE `message_info` (
  `DateTime` datetime NOT NULL,
  `sender_id` varchar(16) NOT NULL,
  `recepient_id` varchar(16) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `message_sent` varchar(160) NOT NULL,
  `credit_balance_before` int NOT NULL,
  `credit_balance_after` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `message_info`
--

INSERT INTO `message_info` (`DateTime`, `sender_id`, `recepient_id`, `user_id`, `message_sent`, `credit_balance_before`, `credit_balance_after`) VALUES
('2017-04-16 00:41:59', '00444787151854', '00256783313038', '1', 'Send Mr Opio Joseph 3,000,000 on this number, please dont forget as am currently in the meeting , Thanks', 500, 499),
('2021-01-04 15:40:45', '+256751114001', '+31687760004', '1', 'Checking api online', 999, 998);

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `mod_modulegroupcode` varchar(25) NOT NULL,
  `mod_modulegroupname` varchar(50) NOT NULL,
  `mod_modulecode` varchar(25) NOT NULL,
  `mod_modulename` varchar(50) NOT NULL,
  `mod_modulegrouporder` int NOT NULL,
  `mod_moduleorder` int NOT NULL,
  `mod_modulepagename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`mod_modulegroupcode`, `mod_modulegroupname`, `mod_modulecode`, `mod_modulename`, `mod_modulegrouporder`, `mod_moduleorder`, `mod_modulepagename`) VALUES
('CHECKOUT', 'Checkout', 'PAYMENT', 'Payment', 3, 2, 'users.php'),
('CHECKOUT', 'Checkout', 'SHIPPING', 'Shipping', 3, 1, 'shipping.php'),
('CHECKOUT', 'Checkout', 'TAX', 'Tax', 3, 3, 'tax.php'),
('INVT', 'Inventory', 'PURCHASES', 'Purchases', 2, 1, 'purchases.php'),
('INVT', 'Inventory', 'SALES', 'Sales', 2, 3, 'sales.php'),
('INVT', 'Inventory', 'STOCKS', 'Stocks', 2, 2, 'stocks.php');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_rolecode` varchar(50) NOT NULL,
  `role_rolename` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_rolecode`, `role_rolename`) VALUES
('ADMIN', 'Administrator'),
('SUPERADMIN', 'Super Admin');

-- --------------------------------------------------------

--
-- Table structure for table `role_rights`
--

CREATE TABLE `role_rights` (
  `rr_rolecode` varchar(50) NOT NULL,
  `rr_modulecode` varchar(25) NOT NULL,
  `rr_create` enum('yes','no') NOT NULL DEFAULT 'no',
  `rr_edit` enum('yes','no') NOT NULL DEFAULT 'no',
  `rr_delete` enum('yes','no') NOT NULL DEFAULT 'no',
  `rr_view` enum('yes','no') NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `role_rights`
--

INSERT INTO `role_rights` (`rr_rolecode`, `rr_modulecode`, `rr_create`, `rr_edit`, `rr_delete`, `rr_view`) VALUES
('ADMIN', 'PAYMENT', 'no', 'no', 'no', 'yes'),
('ADMIN', 'PURCHASES', 'yes', 'yes', 'yes', 'yes'),
('ADMIN', 'SALES', 'no', 'no', 'no', 'no'),
('ADMIN', 'SHIPPING', 'yes', 'yes', 'yes', 'yes'),
('ADMIN', 'STOCKS', 'no', 'no', 'no', 'yes'),
('ADMIN', 'TAX', 'no', 'no', 'no', 'no'),
('SUPERADMIN', 'PAYMENT', 'yes', 'yes', 'yes', 'yes'),
('SUPERADMIN', 'PURCHASES', 'yes', 'yes', 'yes', 'yes'),
('SUPERADMIN', 'SALES', 'yes', 'yes', 'yes', 'yes'),
('SUPERADMIN', 'SHIPPING', 'yes', 'yes', 'yes', 'yes'),
('SUPERADMIN', 'STOCKS', 'yes', 'yes', 'yes', 'yes'),
('SUPERADMIN', 'TAX', 'yes', 'yes', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `system_users`
--

CREATE TABLE `system_users` (
  `u_userid` int NOT NULL,
  `u_username` varchar(100) NOT NULL,
  `u_password` varchar(255) NOT NULL,
  `u_rolecode` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 TABLESPACE `togetherweca_lexus`;

--
-- Dumping data for table `system_users`
--

INSERT INTO `system_users` (`u_userid`, `u_username`, `u_password`, `u_rolecode`) VALUES
(1, 'admin@smsapp.com', 'cc025499ce0e60dd5a16a4a60c5abae2', 'SUPERADMIN'),
(3, 'opio.charles@smsapp.com', 'cc025499ce0e60dd5a16a4a60c5abae2', 'ADMIN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `credits`
--
ALTER TABLE `credits`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `credit_additions`
--
ALTER TABLE `credit_additions`
  ADD PRIMARY KEY (`user_id`,`credits_added`,`DateTime`,`bywho`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`mod_modulegroupcode`,`mod_modulecode`),
  ADD UNIQUE KEY `mod_modulecode` (`mod_modulecode`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_rolecode`);

--
-- Indexes for table `role_rights`
--
ALTER TABLE `role_rights`
  ADD PRIMARY KEY (`rr_rolecode`,`rr_modulecode`),
  ADD KEY `rr_modulecode` (`rr_modulecode`);

--
-- Indexes for table `system_users`
--
ALTER TABLE `system_users`
  ADD PRIMARY KEY (`u_userid`),
  ADD KEY `u_rolecode` (`u_rolecode`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `system_users`
--
ALTER TABLE `system_users`
  MODIFY `u_userid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_rights`
--
ALTER TABLE `role_rights`
  ADD CONSTRAINT `role_rights_ibfk_1` FOREIGN KEY (`rr_rolecode`) REFERENCES `role` (`role_rolecode`) ON UPDATE CASCADE,
  ADD CONSTRAINT `role_rights_ibfk_2` FOREIGN KEY (`rr_modulecode`) REFERENCES `module` (`mod_modulecode`) ON UPDATE CASCADE;

--
-- Constraints for table `system_users`
--
ALTER TABLE `system_users`
  ADD CONSTRAINT `system_users_ibfk_1` FOREIGN KEY (`u_rolecode`) REFERENCES `role` (`role_rolecode`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
