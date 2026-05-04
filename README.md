# EduBridge Rwanda 🌍📚
### Offline & Online Opportunity System

> Connecting students, schools, employers, and scholarship providers — with or without internet.

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20SMS-blue)](https://github.com)
[![Stage](https://img.shields.io/badge/Stage-Prototype-orange)](https://github.com)
[![Location](https://img.shields.io/badge/Location-Rwanda-green)](https://github.com)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

---

## 📖 Table of Contents

- [About the Project](#about-the-project)
- [The Problem](#the-problem)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Roadmap](#roadmap)
- [Target Beneficiaries](#target-beneficiaries)
- [Expected Impact](#expected-impact)
- [Contributing](#contributing)
- [Contact](#contact)

---

## 🌐 About the Project

**EduBridge Rwanda** is a smart digital platform designed to bridge the opportunity gap for students across Rwanda and Africa. It connects students with scholarships, internships, and jobs through a unified ecosystem — accessible via **mobile app**, **web platform**, and **SMS** for users with or without smartphones.

Built with Rwanda's realities in mind: reliable performance on slow connections, offline capability, and SMS reach for non-smartphone users.

---

## ❗ The Problem

Many students in Rwanda miss life-changing opportunities because of:

| Problem | Impact |
|---|---|
| Limited or no internet access | Students miss scholarship and job deadlines |
| Lack of centralized information | Opportunities are scattered and hard to find |
| Poor school-student communication | Announcements and updates don't reach students in time |

---

## ✨ Key Features

- **📱 Mobile App (Android & iOS)** — Register, build a profile, and search for scholarships, internships, and jobs directly from your phone.
- **💻 Web Platform** — Full-featured dashboard for schools, employers, and organizations to manage profiles and post opportunities.
- **📩 SMS API Integration** — Students with basic phones receive alerts, updates, and deadline reminders via SMS — no smartphone needed.
- **📶 Offline Mode** — Browse saved content and prepare applications offline; everything syncs when the internet returns.
- **🏫 School & Employer Portal** — Schools can showcase programs; employers can recruit talented youth.
- **⚡ SSD Cloud Hosting** — Fast, secure platform performance even on low-bandwidth connections.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Android (Java/Kotlin) / iOS (Swift) |
| Web Frontend | HTML, CSS, JavaScript (React or Vue) |
| Backend | Node.js / Python (Django or FastAPI) |
| Database | PostgreSQL / Firebase |
| SMS Integration | Africa's Talking SMS API / Twilio |
| Cloud Hosting | SSD-based cloud server (AWS / DigitalOcean) |
| Offline Sync | Service Workers / Local SQLite |

> **Note:** Final stack will be confirmed during Month 1 (May 2026) design phase.

---

## 🚀 Getting Started

### Prerequisites

- Node.js v18+
- Python 3.10+
- Android Studio (for mobile development)
- PostgreSQL or Firebase account
- SMS API credentials (Africa's Talking or Twilio)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/edubridge-rwanda.git
cd edubridge-rwanda

# Install backend dependencies
cd backend
pip install -r requirements.txt

# Install frontend dependencies
cd ../frontend
npm install

# Set up environment variables
cp .env.example .env
# Fill in your database, SMS API, and cloud credentials

# Run the development server
npm run dev
```

### SMS Integration Setup

```bash
# Configure SMS gateway in .env
SMS_API_KEY=your_api_key
SMS_SENDER_ID=EduBridge
SMS_GATEWAY=africastalking  # or twilio
```

---

## 📁 Project Structure

```
edubridge-rwanda/
├── mobile/              # Android & iOS app source
│   ├── android/
│   └── ios/
├── web/                 # Web platform frontend
│   ├── src/
│   ├── public/
│   └── package.json
├── backend/             # API server & business logic
│   ├── api/
│   ├── models/
│   ├── sms/             # SMS integration module
│   └── requirements.txt
├── docs/                # Documentation & design files
└── README.md
```

---

## 🗺️ Roadmap

| Month | Milestone |
|---|---|
| **May 2026** | Finalize system design, database schema, hosting setup, SMS API planning |
| **June 2026** | Develop mobile app prototype and student registration module |
| **July 2026** | Build web platform and opportunity management system |
| **August 2026** | Integrate SMS notifications, offline features, and full testing |
| **September 2026** | Final prototype, documentation, and competition presentation |

**Project Duration:** May 1, 2026 → September 30, 2026

---

## 👥 Target Beneficiaries

- 🎓 **Students** — seeking scholarships, jobs, internships, and career guidance
- 🏫 **Secondary schools, colleges, and universities** — looking to connect with students and partners
- 🏢 **Employers** — recruiting interns and graduates
- 🌍 **NGOs & scholarship organizations** — reaching students efficiently
- 👨‍👩‍👧 **Parents and guardians** — staying informed through SMS updates

---

## 📊 Expected Impact

**Phase 1 Target:** 5,000+ students and 50+ institutions

| Impact Area | Expected Outcome |
|---|---|
| 🤝 Social | Equal opportunity access for rural and urban students |
| 💼 Economic | Increased youth employment and internship uptake |
| 🎓 Educational | Better school-employer partnerships |
| 📡 Digital Inclusion | Reach students on basic phones via SMS |
| 🇷🇼 National | Stronger education-to-employment pipeline in Rwanda |

### Sustainability

- Subscription plans for schools and organizations
- Premium recruitment services for employers
- Sponsored listings and educational partnerships
- Continuous platform updates based on user feedback

---

## 🤝 Contributing

Contributions are welcome! Here's how to get involved:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for our code of conduct and contribution guidelines.

---

## 📬 Contact

**HAVUGIMANA Muhamadi**
- 📧 Email: [muhamadihavugimana@gmail.com](mailto:muhamadihavugimana@gmail.com)
- 📞 Phone: +250 789 519 135
- 📍 Location: Karongi District, Western Province, Rwanda

---

<div align="center">
  <strong>EduBridge Rwanda</strong> — Bridging the opportunity gap, one student at a time. 🌱
</div>
