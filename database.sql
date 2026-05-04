-- ================================================
-- EduBridge Rwanda Database Schema — v1.0
-- Offline & Online Opportunity System
-- ================================================

CREATE DATABASE IF NOT EXISTS edubridge_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE edubridge_db;

-- ── Table 1: users ───────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(255)  NOT NULL,
  email      VARCHAR(255)  NOT NULL UNIQUE,
  password   VARCHAR(255)  NOT NULL,
  role       ENUM('student','school','employer','scholarship_provider','admin') NOT NULL DEFAULT 'student',
  created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ── Table 2: student_profiles ────────────────────
CREATE TABLE IF NOT EXISTS student_profiles (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  user_id    INT  NOT NULL UNIQUE,
  education  TEXT,
  skills     TEXT,
  projects   TEXT,
  bio        TEXT,
  avatar     VARCHAR(300),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ── Table 3: institutions ────────────────────────
CREATE TABLE IF NOT EXISTS institutions (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT          NOT NULL UNIQUE,
  name        VARCHAR(255) NOT NULL,
  location    VARCHAR(255),
  description TEXT,
  website     VARCHAR(300),
  logo        VARCHAR(300),
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ── Table 4: opportunities ───────────────────────
CREATE TABLE IF NOT EXISTS opportunities (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(255) NOT NULL,
  type        ENUM('job','internship','scholarship') NOT NULL,
  description TEXT         NOT NULL,
  deadline    DATE         NOT NULL,
  provider_id INT          NOT NULL,
  location    VARCHAR(255),
  category    VARCHAR(100),
  is_active   TINYINT(1)   DEFAULT 1,
  created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (provider_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ── Table 5: applications ────────────────────────
CREATE TABLE IF NOT EXISTS applications (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  student_id     INT NOT NULL,
  opportunity_id INT NOT NULL,
  status         ENUM('pending','reviewed','accepted','rejected') NOT NULL DEFAULT 'pending',
  cover_letter   TEXT,
  applied_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_application (student_id, opportunity_id),
  FOREIGN KEY (student_id)     REFERENCES users(id)         ON DELETE CASCADE,
  FOREIGN KEY (opportunity_id) REFERENCES opportunities(id) ON DELETE CASCADE
);

-- ── Indexes for performance ──────────────────────
CREATE INDEX IF NOT EXISTS idx_users_email         ON users(email);
CREATE INDEX IF NOT EXISTS idx_opp_type            ON opportunities(type);
CREATE INDEX IF NOT EXISTS idx_opp_active          ON opportunities(is_active);
CREATE INDEX IF NOT EXISTS idx_opp_deadline        ON opportunities(deadline);
CREATE INDEX IF NOT EXISTS idx_apps_student        ON applications(student_id);
CREATE INDEX IF NOT EXISTS idx_apps_opportunity    ON applications(opportunity_id);
