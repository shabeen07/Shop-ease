# Task Document v2 — Expanded Scope

**Project:** Shop Ease (Flutter SDD Project)  
**Version:** 2.0  
**Status:** In Progress (Core Features Implemented)  
**Architecture:** Clean Architecture + BLoC  
**Mock API Base URL:** `https://dummyjson.com/`

---

## 1. Objective

Develop a full-featured e-commerce mobile application following the **Spec-Driven Development (SDD)** workflow. Version 2.0 expands the initial scope to include advanced shopping features, profile management, and global application settings.

---

## 2. Development Methodology (SDD)

Every feature follows the strict SDD lifecycle:
1. **Spec:** `docs/features/<feature>.md`
2. **Prototype:** `docs/prototype.html` (Pixel-accurate target)
3. **Implementation:** Flutter (Clean Architecture)
4. **Analysis:** `flutter analyze` (Zero issues mandate)
5. **Testing:** Unit/BLoC tests (`flutter test`)
6. **Review:** [Review & Repair Workflow](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/workflows/review-workflow.agent.md)

---

## 3. Application Scope

### 3.1 Core Features (v1.0)
- **Login:** Username-based authentication.
- **Home:** Product listing with infinite scroll.
- **Product Detail:** Comprehensive product information and pricing.

### 3.2 Expanded Features (v2.0)
- **Search & Filtering:** Real-time search and category-based filtering.
- **Profile:** User information display and secure logout.
- **Settings:** Global theme switching (Light/Dark/System) with persistence.
- **Notifications:** Temporal-grouped alerts (Today, Yesterday, Older).
- **Session Persistence:** Auto-restore session from local storage.

---

## 4. Functional Requirements (Updated)

### FR-015 — Product Search
The Home screen shall allow users to search for products by title using a real-time query interface.

### FR-016 — Category Filtering
The application shall provide horizontal category chips to filter products by their respective types.

### FR-017 — Profile Overview
The application shall provide a Profile screen displaying the authenticated user's name, email, and a personalized brand gradient header.

### FR-018 — Settings & Theming
The application shall allow users to toggle between Light, Dark, and System theme modes. The selection MUST persist across app restarts using `SharedPreferences`.

### FR-019 — Notification Center
The application shall display a list of notifications grouped by date (Today, Yesterday, Older) with distinct visual indicators for read/unread states.

### FR-020 — Session Restoration
The application shall securely cache the user's authentication session and automatically restore it on startup to bypass the login screen.

---

## 5. Non-Functional Requirements

- **Modern API Compliance:** Zero tolerance for deprecated Flutter/Dart members.
- **Adaptive Layout:** Responsive grid and card system using `LayoutBuilder`.
- **High Contrast:** Mandatory WCAG-compliant text contrast in both Light and Dark modes.
- **Zero Technical Debt:** Clean `flutter analyze` results for every commit.

---

## 6. Implementation Status

### 6.1 Feature Checklist
- [x] **Login:** Fully functional with validation and error handling.
- [x] **Product Listing:** Optimized grid with dynamic aspect ratios.
- [x] **Search & Filter:** Integrated with DummyJSON search and category endpoints.
- [x] **Product Detail:** Implemented with M3 design tokens.
- [x] **Profile:** Implemented with brand gradient and secure logout.
- [x] **Settings:** Theme persistence fully functional.
- [x] **Notifications:** Mock repository with temporal grouping logic.
- [x] **Session Persistence:** Implemented via `AuthLocalDataSource`.

---

## 7. Traceability (Artifacts)

- **UI Ground Truth:** [prototype.html](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/docs/prototype.html)
- **Architecture:** [architecture.md](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/docs/architecture.md)
- **AI Governance:** [.agents/rules/rules.agent.md](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/rules/rules.agent.md)
- **Verification Logic:** [project-verifier](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/skills/verifier/SKILL.md)

---

## 8. Next Steps (Roadmap)

1. **Cart Logic:** Persistent cart storage and "Add to Cart" interactions.
2. **Image Gallery:** Enhanced multi-image viewer for product details.
3. **Checkout Simulation:** Mock checkout flow with success/failure animations.
