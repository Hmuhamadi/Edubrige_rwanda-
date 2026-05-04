-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2026 at 02:27 PM
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
-- Database: `edubridge_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `opportunity_id` int(11) NOT NULL,
  `status` enum('pending','reviewed','accepted','rejected') NOT NULL DEFAULT 'pending',
  `cover_letter` text DEFAULT NULL,
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `student_id`, `opportunity_id`, `status`, `cover_letter`, `applied_at`) VALUES
(1, 2, 2, 'pending', NULL, '2026-04-29 10:33:49'),
(2, 2, 3, 'accepted', NULL, '2026-04-29 10:33:49'),
(3, 3, 1, 'reviewed', NULL, '2026-04-29 10:33:49'),
(4, 3, 5, 'rejected', NULL, '2026-04-29 10:33:49'),
(5, 2, 1, 'rejected', NULL, '2026-04-29 11:15:59'),
(6, 2, 5, 'pending', NULL, '2026-04-29 11:16:10');

-- --------------------------------------------------------

--
-- Table structure for table `institutions`
--

CREATE TABLE `institutions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `website` varchar(300) DEFAULT NULL,
  `logo` varchar(300) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `institutions`
--

INSERT INTO `institutions` (`id`, `user_id`, `name`, `location`, `description`, `website`, `logo`, `created_at`) VALUES
(1, 4, 'University of Rwanda', 'Kigali, Rwanda', 'The largest public university in Rwanda, offering diverse programs.', 'https://ur.ac.rw', NULL, '2026-04-29 10:33:49'),
(2, 5, 'IPRC Karongi', 'Karongi, Rwanda', 'Integrated Polytechnic Regional College focusing on technical education.', 'https://iprckarongi.rp.ac.rw', NULL, '2026-04-29 10:33:49');

-- --------------------------------------------------------

--
-- Table structure for table `opportunities`
--

CREATE TABLE `opportunities` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('job','internship','scholarship') NOT NULL,
  `description` text NOT NULL,
  `deadline` date NOT NULL,
  `provider_id` int(11) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opportunities`
--

INSERT INTO `opportunities` (`id`, `title`, `type`, `description`, `deadline`, `provider_id`, `location`, `category`, `is_active`, `created_at`) VALUES
(1, 'Mastercard Foundation Scholarship 2026', 'scholarship', 'Fully funded scholarship for undergraduate studies in top African universities.', '2026-06-30', 8, 'Across Africa', 'Education', 1, '2026-04-29 10:33:49'),
(2, 'BK Tech Intern Program', 'internship', '3-month internship for computer science students to work on banking systems.', '2026-05-15', 6, 'Kigali, Rwanda', 'Technology', 1, '2026-04-29 10:33:49'),
(3, 'MTN Graduate Trainee 2026', 'job', 'A 12-month program for fresh graduates to build careers in telecommunications.', '2026-08-20', 7, 'Kigali, Rwanda', 'Telecom', 1, '2026-04-29 10:33:49'),
(4, 'AfOx Graduate Scholarship', 'scholarship', 'Scholarship for African students to pursue postgraduate studies at Oxford.', '2026-04-30', 9, 'United Kingdom', 'Education', 1, '2026-04-29 10:33:49'),
(5, 'UR Research Assistant', 'internship', 'Assist in the data science research lab at the University of Rwanda.', '2026-05-30', 4, 'Kigali', 'Research', 1, '2026-04-29 10:33:49');

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `education` text DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `projects` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `avatar` varchar(300) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_profiles`
--

INSERT INTO `student_profiles` (`id`, `user_id`, `education`, `skills`, `projects`, `bio`, `avatar`, `created_at`) VALUES
(1, 2, 'B.Sc. Computer Engineering - UR', 'PHP, MySQL, React, Python', 'E-commerce Platform, Health Tracking App', 'Passionate developer focusing on fintech solutions for East Africa.', NULL, '2026-04-29 10:33:49'),
(2, 3, 'Advanced Diploma in IT - IPRC', 'Java, Networking, Technical Support', 'Library Management System', 'Tech enthusiast eager to learn more about cloud computing.', NULL, '2026-04-29 10:33:49'),
(3, 10, NULL, NULL, NULL, NULL, NULL, '2026-04-29 11:21:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','school','employer','scholarship_provider','admin') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Admin EduBridge', 'admin@edubridge.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'admin', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(2, 'Jean Bosco', 'jean@example.com', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'student', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(3, 'Alice Umutoni', 'alice@example.com', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'student', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(4, 'University of Rwanda', 'info@ur.ac.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'school', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(5, 'IPRC Karongi', 'info@iprckarongi.ac.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'school', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(6, 'Bank of Kigali', 'hr@bk.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'employer', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(7, 'MTN Rwanda', 'careers@mtn.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'employer', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(8, 'Mastercard Foundation', 'scholarships@mastercard.org', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'scholarship_provider', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(9, 'Africa-Oxford Initiative', 'afox@ox.ac.uk', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'scholarship_provider', '2026-04-29 10:33:49', '2026-04-29 10:33:49'),
(10, 'muhamadi', 'muhamadihavugimana@gmail.com', '$2y$10$gRxLBn6I/kVUtippjcx8zuYXmR2aRsNzK3f3a64ARELtLbLc3nOxu', 'student', '2026-04-29 11:21:20', '2026-04-29 11:21:20'),
(12, 'sammy', 'muhamadihavugimana1@gmail.com', '$2y$10$oVu/x3PS7FOsMdq6AzY/sOStXsDF6qGiNCdg.VC8SmQFaTZ9QaNcK', 'employer', '2026-04-30 14:45:09', '2026-04-30 14:45:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_application` (`student_id`,`opportunity_id`),
  ADD KEY `idx_apps_student` (`student_id`),
  ADD KEY `idx_apps_opportunity` (`opportunity_id`);

--
-- Indexes for table `institutions`
--
ALTER TABLE `institutions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `opportunities`
--
ALTER TABLE `opportunities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `idx_opp_type` (`type`),
  ADD KEY `idx_opp_active` (`is_active`),
  ADD KEY `idx_opp_deadline` (`deadline`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `institutions`
--
ALTER TABLE `institutions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `opportunities`
--
ALTER TABLE `opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `student_profiles`
--
ALTER TABLE `student_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `institutions`
--
ALTER TABLE `institutions`
  ADD CONSTRAINT `institutions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `opportunities`
--
ALTER TABLE `opportunities`
  ADD CONSTRAINT `opportunities_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `student_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
