# 🎙️ Vernita

## AI-Powered Virtual Interview Coach

**Practice. Perform. Improve.**

Vernita is an AI-powered virtual interview platform designed to help users practice job interviews in a realistic and interactive environment.

Instead of only evaluating what the user says, Vernita goes beyond the answer by combining interview answer analysis with non-verbal communication analysis to provide more comprehensive and actionable feedback.

---

## 📌 Overview

Job interviews can be stressful, especially when candidates struggle to structure their answers, communicate confidently, or maintain effective non-verbal communication.

Vernita provides a realistic interview practice experience where the interview scenario is generated based on the user's CV, extracted job role, and selected interview topics.

The user interacts with a virtual HR interviewer, answers questions in real time, and receives feedback to identify weaknesses and improve future performance.

---

## ❗ The Problem

Traditional interview preparation often focuses mainly on:

- Reading common interview questions
- Preparing predefined answers
- Practicing with friends
- Watching interview tutorials

These approaches may not fully reproduce the pressure and interaction of a real interview.

They also often overlook important aspects such as:

- Answer structure and relevance
- Eye contact
- Body language
- Facial expressions
- Overall communication performance

---

## 💡 The Solution

Vernita provides an interactive virtual interview experience that combines:

- CV-based job role identification
- Custom interview setup
- AI-generated interview questions
- A virtual HR interviewer
- Real-time interview interaction
- Answer analysis
- Non-verbal communication analysis
- Personalized feedback
- Continuous improvement

The goal is to make interview preparation more realistic, measurable, and personalized.

---

## ✨ Key Features

### 📄 CV-Based Job Role

The user's job role is derived from their CV rather than being manually selected.

### ⚙️ Interview Setup

Before starting the interview, the user can configure the interview and add specific topics they want to be asked about.

### 🤖 AI-Generated Questions

Interview questions are generated based on the user's CV, extracted job role, and selected topics.

### 👨‍💼 Virtual HR Interviewer

A 3D virtual interviewer creates a more realistic and engaging interview environment.

### 🎤 Real-Time Interview

The user participates in an interactive interview and answers questions in real time.

### 📝 Answer Analysis

The system evaluates the user's answers based on relevant factors such as:

- Relevance
- Structure
- Clarity
- Overall answer quality

### 👀 Non-Verbal Communication Analysis

Vernita goes beyond the spoken answer by analyzing aspects of the user's non-verbal communication, including:

- Eye contact
- Body language
- Facial expressions

### 📊 Personalized Feedback

After the interview, the user receives feedback highlighting strengths, weaknesses, and areas for improvement.

### 🔄 Continuous Improvement

The feedback is intended to help users improve their interview performance through repeated practice.

---

## 🔄 How It Works

```text
CV
 │
 ▼
Job Role Extraction
 │
 ▼
Interview Setup
 │
 ├── Selected Topics
 │
 ▼
AI Question Generation
 │
 ▼
Virtual Interview
 │
 ├── Verbal Answer
 └── Non-Verbal Communication
 │
 ▼
Analysis
 │
 ▼
Feedback
 │
 ▼
Improvement
```

---

## 🎯 The Interview Experience

The interview experience is designed to simulate a realistic interview scenario.

The process includes:

1. The user provides their CV.
2. The system identifies the relevant job role from the CV.
3. The user configures the interview and adds preferred topics.
4. AI generates suitable interview questions.
5. The virtual HR interviewer conducts the interview.
6. The user answers questions in real time.
7. The system analyzes the interview performance.
8. The user receives personalized feedback.

---

## 🧠 Beyond the Answer

A strong interview performance is not only about having the correct answer.

Vernita considers both:

```text
                    Interview Performance
                            │
              ┌─────────────┴─────────────┐
              │                           │
        Verbal Performance        Non-Verbal Performance
              │                           │
       Answer Quality              Eye Contact
       Relevance                   Body Language
       Structure                   Facial Expressions
       Clarity
```

This allows the system to provide a more complete view of the user's interview performance.

---

## 🏗️ Architecture

Vernita follows a feature-based and modular architecture designed to keep the application maintainable and scalable as development progresses.

### Project Structure

```text
vernita/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── network/
│   │   ├── routing/
│   │   ├── services/
│   │   ├── storage/
│   │   ├── theme/
│   │   ├── utils/
│   │   ├── widgets/
│   │   └── di/
│   │
│   ├── features/
│   │   ├── authentication/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   ├── profile/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   ├── interview_setup/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   ├── interview/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   ├── virtual_interviewer/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   ├── analysis/
│   │   │   ├── ui/
│   │   │   ├── data/
│   │   │   └── logic/
│   │   │
│   │   └── feedback/
│   │       ├── ui/
│   │       ├── data/
│   │       └── logic/
│   │
│   └── main.dart
│
├── unity/
├── assets/
├── test/
└── README.md
```

### Core

The `core` directory contains reusable application-level components that are independent from specific business features.

| Folder       | Purpose                                         |
| ------------ | ----------------------------------------------- |
| `constants/` | App-wide constants and configuration            |
| `errors/`    | Exceptions and failure handling                 |
| `network/`   | Network and API configuration                   |
| `routing/`   | Application navigation and routes               |
| `services/`  | Reusable application-level services             |
| `storage/`   | Local storage, caching, and persistent data     |
| `theme/`     | Global styling, colors, and typography          |
| `utils/`     | Common utilities and helpers                    |
| `widgets/`   | Shared reusable UI components                   |
| `di/`        | Dependency injection and app-level dependencies |

The `core` layer should remain independent from specific business features.

### Features

Each feature follows a modular structure:

```text
feature/
├── ui/
├── data/
└── logic/
```

- **UI** — Screens, widgets, and user interaction.
- **Data** — Models, data sources, repositories, and data mapping.
- **Logic** — State management, controllers, business rules, and feature-specific logic.

This structure keeps each feature relatively self-contained and makes the project easier to maintain and scale.

### Example

```text
features/
└── interview/
    ├── ui/
    │   ├── screens/
    │   └── widgets/
    │
    ├── data/
    │   ├── models/
    │   ├── data_sources/
    │   └── repositories/
    │
    └── logic/
        ├── cubit/
        └── states/
```

---

## 🛠️ Technology Stack

### Mobile Application

- Flutter
- Dart

### Virtual Interviewer

- Unity
- 3D Avatar
- Flutter ↔ Unity integration

### AI & Backend

The backend technologies, APIs, AI services, and external integrations will be documented as the implementation progresses.

---

## 📱 Application Flow

```text
Authentication
      │
      ▼
Profile / CV
      │
      ▼
Job Role
      │
      ▼
Interview Setup
      │
      ├── Topics
      │
      ▼
Question Generation
      │
      ▼
Virtual Interview
      │
      ▼
Analysis
      │
      ▼
Feedback
```

---

## 🔗 Flutter & Unity Integration

Flutter acts as the main application layer, while Unity is responsible for the virtual interviewer and 3D interaction.

The integration will allow the Flutter application and Unity environment to communicate during the interview experience.

The exact communication mechanism and message flow will be documented as the integration is implemented.

---

## 📸 Screenshots

Screenshots will be added as the application UI and interview experience are developed.

---

## 🚀 Getting Started

### Prerequisites

Before running Vernita, make sure you have the required development environment installed.

The exact Flutter, Dart, Unity, and Android/iOS requirements will be documented as the project setup is finalized.

### Installation

Clone the repository:

```bash
git clone <repository-url>
```

Navigate to the project:

```bash
cd vernita
```

Install Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

The Unity project and integration setup will be documented separately as development progresses.

---

## ⚙️ Environment Configuration

Any required API keys, environment variables, credentials, or external service configuration should be provided through local configuration files or environment-specific settings.

Sensitive credentials should **never** be committed to the repository.

The required environment configuration will be documented as the corresponding services are integrated.

---

## 🧪 Testing

Testing will cover the application's core functionality and individual features as development progresses.

The project will gradually include:

- Unit tests
- Widget tests
- Feature-level tests
- Integration testing

---

## 🔮 Future Improvements

Potential future improvements include:

- More advanced interview personalization
- Improved answer evaluation
- More detailed communication analysis
- Enhanced facial expression analysis
- More realistic virtual interviewer interactions
- Interview performance history
- Progress tracking
- Additional interview scenarios
- Improved AI-driven feedback

---

## 👥 Team

Vernita is developed as a university graduation project by a collaborative student team.

Team members and their responsibilities will be documented here as the project progresses.

---

## 🎓 Academic Project

Vernita is developed as a university graduation project focused on combining:

- Artificial Intelligence
- Mobile Application Development
- 3D Virtual Interaction
- Interview Performance Analysis

---

## 📄 License

This project is developed as an academic project.

License information will be added when the project licensing decision is finalized.

---

## 🚧 Project Status

**Status: In Development**

Vernita is currently under active development. Architecture, integrations, and implementation details may evolve throughout the project lifecycle.
