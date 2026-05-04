-- EduBridge Rwanda Sample Seed Data

USE edubridge_db;

-- 1. Clear existing data (optional, but good for clean seed)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE applications;
TRUNCATE TABLE opportunities;
TRUNCATE TABLE student_profiles;
TRUNCATE TABLE institutions;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. Insert Users (Password is 'password123' for all)
-- Password Hash for 'password123': $2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm
INSERT INTO users (id, name, email, password, role) VALUES
(1, 'Admin EduBridge', 'admin@edubridge.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'admin'),
(2, 'Jean Bosco', 'jean@example.com', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'student'),
(3, 'Alice Umutoni', 'alice@example.com', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'student'),
(4, 'University of Rwanda', 'info@ur.ac.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'school'),
(5, 'IPRC Karongi', 'info@iprckarongi.ac.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'school'),
(6, 'Bank of Kigali', 'hr@bk.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'employer'),
(7, 'MTN Rwanda', 'careers@mtn.rw', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'employer'),
(8, 'Mastercard Foundation', 'scholarships@mastercard.org', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'scholarship_provider'),
(9, 'Africa-Oxford Initiative', 'afox@ox.ac.uk', '$2y$10$8A4YpywDm4ntmXWmbV7.J.s.6IyOBubKYeGqCBWbgHSy50cb/vafm', 'scholarship_provider');

-- 3. Insert Student Profiles
INSERT INTO student_profiles (user_id, education, skills, projects, bio) VALUES
(2, 'B.Sc. Computer Engineering - UR', 'PHP, MySQL, React, Python', 'E-commerce Platform, Health Tracking App', 'Passionate developer focusing on fintech solutions for East Africa.'),
(3, 'Advanced Diploma in IT - IPRC', 'Java, Networking, Technical Support', 'Library Management System', 'Tech enthusiast eager to learn more about cloud computing.');

-- 4. Insert Institutions
INSERT INTO institutions (user_id, name, location, description, website) VALUES
(4, 'University of Rwanda', 'Kigali, Rwanda', 'The largest public university in Rwanda, offering diverse programs.', 'https://ur.ac.rw'),
(5, 'IPRC Karongi', 'Karongi, Rwanda', 'Integrated Polytechnic Regional College focusing on technical education.', 'https://iprckarongi.rp.ac.rw');

-- 5. Insert Opportunities
INSERT INTO opportunities (id, title, type, description, deadline, provider_id, location, category) VALUES
(1, 'Mastercard Foundation Scholarship 2026', 'scholarship', 'Fully funded scholarship for undergraduate studies in top African universities.', '2026-06-30', 8, 'Across Africa', 'Education'),
(2, 'BK Tech Intern Program', 'internship', '3-month internship for computer science students to work on banking systems.', '2026-05-15', 6, 'Kigali, Rwanda', 'Technology'),
(3, 'MTN Graduate Trainee 2026', 'job', 'A 12-month program for fresh graduates to build careers in telecommunications.', '2026-08-20', 7, 'Kigali, Rwanda', 'Telecom'),
(4, 'AfOx Graduate Scholarship', 'scholarship', 'Scholarship for African students to pursue postgraduate studies at Oxford.', '2026-04-30', 9, 'United Kingdom', 'Education'),
(5, 'UR Research Assistant', 'internship', 'Assist in the data science research lab at the University of Rwanda.', '2026-05-30', 4, 'Kigali', 'Research');

-- 6. Insert Applications
INSERT INTO applications (student_id, opportunity_id, status) VALUES
(2, 2, 'pending'),
(2, 3, 'reviewed'),
(3, 1, 'accepted'),
(3, 5, 'rejected');
