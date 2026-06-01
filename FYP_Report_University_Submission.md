# Final Year Project Report

## Project Title
Architectural Audit, Quality Evaluation, and Engineering Improvement Plan for an Owner-Facing Salon and Shop Management Flutter Application

## Student Information
- **Student Name:** [YOUR NAME]
- **Student ID:** [YOUR ID]
- **Supervisor:** [SUPERVISOR NAME]
- **Institution:** [UNIVERSITY NAME]
- **Department:** Computer Science / Software Engineering
- **Submission Date:** [DATE]
- **Academic Year:** [YEAR]

---

## Declaration
This report is submitted in partial fulfillment of the requirements for the degree program in Computer Science / Software Engineering. The work presented in this document is based on a technical audit and engineering analysis of the referenced software workspace.

---

## Acknowledgement
The author gratefully acknowledges the guidance of the project supervisor, the support of the department, and the availability of open-source technologies that enabled this work.

---

## Abstract

This Final Year Project report presented a comprehensive technical analysis and engineering evaluation of a production-oriented Flutter application developed for salon and shop owners. The system addressed the operational complexity faced by owner-side stakeholders in service businesses, including appointment administration, product catalog control, order management, analytics, customer communication, and profile maintenance. The project adopted a code-centric audit methodology that combined architectural decomposition, static analysis, module-level inspection, security review, maintainability assessment, and test-readiness evaluation.

The study identified that the application had implemented a layered GetX-based architecture with clear folder-level separation into views, controllers, parsers, bindings, and models, supported by REST APIs and local state persistence. The technology stack was modern and practical for cross-platform deployment, including Flutter, GetX, SharedPreferences, Firebase Messaging, and Syncfusion components. However, the audit also discovered significant engineering risks, including extensive controller-level duplication, heavy reliance on dynamic typing, weak automated testing coverage, and security concerns such as token exposure in logs and URL query parameters. Static analysis reported 193 issues, mostly relating to missing type annotations, deprecated API usage, and style-level inconsistencies.

The outcome of the project was a structured quality baseline, a quantified scorecard across eight engineering dimensions, and a prioritized roadmap for improvement. The report concluded that the application was functionally substantial and architecturally recoverable, but required focused refactoring, security hardening, and systematic testing expansion before reaching high-assurance enterprise-grade quality.

---

## Table of Contents
1. Chapter 1: Introduction  
   1.1 Background and Motivation  
   1.2 Problem Statement  
   1.3 Project Objectives  
   1.4 Scope and Limitations  
   1.5 Report Structure  
2. Chapter 2: Literature Review  
   2.1 Overview of Existing Systems  
   2.2 Technology Comparison  
   2.3 Research Gap  
3. Chapter 3: System Analysis and Requirements  
   3.1 Stakeholder Analysis  
   3.2 Functional Requirements  
   3.3 Non-Functional Requirements  
   3.4 Use Case Diagram Description  
4. Chapter 4: System Design  
   4.1 Architecture Overview  
   4.2 Folder Structure and Module Breakdown  
   4.3 Database Design  
   4.4 API Design  
   4.5 UI/UX Design Principles  
5. Chapter 5: Implementation  
   5.1 Development Environment Setup  
   5.2 Module-by-Module Implementation  
   5.3 Third-Party Integrations  
   5.4 Security Implementation  
6. Chapter 6: Testing  
   6.1 Testing Strategy  
   6.2 Test Cases  
   6.3 Bug Log  
   6.4 Testing Limitations  
7. Chapter 7: Results and Evaluation  
   7.1 Achievement of Objectives  
   7.2 Scorecard Analysis  
   7.3 Performance Analysis  
   7.4 User Acceptance Testing  
8. Chapter 8: Conclusion and Future Work  
   8.1 Summary of Contributions  
   8.2 Lessons Learned  
   8.3 Future Enhancements  
9. References  
10. Appendices

---

# Chapter 1: Introduction

## 1.1 Background and Motivation
Small and medium service businesses, especially salons and personal care providers, increasingly rely on digital systems to manage appointments, staff availability, customer communication, inventory-linked product sales, and performance analytics. Historically, many such businesses handled these workflows using fragmented tools such as messaging applications, spreadsheets, paper registers, and point-of-sale systems with limited service-awareness. This fragmented approach often led to scheduling errors, delayed updates, poor financial visibility, and inconsistent customer experience.

The audited project, a Flutter-based owner-facing application, was motivated by the need to centralize operational control into one mobile-first platform. The system integrated role-aware authentication, booking and order processing, product and package management, service catalog workflows, profile maintenance, language handling, and support communication. The relevance of this project in today’s context is strong because multi-channel service businesses require real-time responsiveness and data-driven decision support while maintaining low operational overhead.

From a software engineering perspective, the application represented a realistic industrial codebase rather than a tutorial prototype. It included multi-platform targets, third-party SDKs, production-like API integration, and modular organization. Consequently, it offered a suitable case for a final-year architectural and quality audit exercise, where the objective was not merely to deliver features, but to evaluate engineering maturity, reliability risks, and maintainability trajectory.

## 1.2 Problem Statement
The primary problem addressed by this report was that the owner-side salon/shop application, while functionally broad, exhibited uneven engineering quality that could reduce long-term scalability, security posture, and maintainability. The codebase required systematic evaluation to identify architectural strengths, implementation weaknesses, and prioritized improvements based on evidence from real modules and files. Without such analysis, future feature expansion risked compounding technical debt, increasing defect probability, and raising operational risk in production.

## 1.3 Project Objectives
1. To design and execute a complete codebase scan that identifies architecture, technology stack, module boundaries, and configuration assets.
2. To implement a structured quality assessment framework covering code quality, architecture consistency, state management, API layer robustness, security, testing, performance, and documentation.
3. To evaluate concrete implementation risks through file-level and line-level inspection of representative modules such as routing, authentication, API handling, splash initialization, and order workflows.
4. To produce a quantitative engineering scorecard (1–10 scale) for major software quality dimensions.
5. To formulate a prioritized set of high-impact technical recommendations with effort estimates and implementation rationale.
6. To document the system and findings in formal academic format suitable for software engineering review and future project governance.

## 1.4 Scope and Limitations
This project’s scope included static code analysis, structural mapping, architectural interpretation, dependency review, security observation, and testing-readiness assessment of the full workspace. The assessment was grounded in actual repository contents, including `lib/`, platform folders, configuration files, and available test artifacts.

In scope were architecture evaluation, API and parser design inspection, state management and dependency injection analysis, security red-flag identification, maintainability appraisal, and test coverage estimation. Out of scope were backend server modification, live penetration testing, full telemetry-based runtime profiling, legal compliance certification, and large-scale user studies.

A further limitation was that backend source code and production infrastructure artifacts were unavailable; therefore, server-side constraints were inferred from client-side contracts.

## 1.5 Report Structure
This report was organized into eight chapters plus references and appendices. Chapter 1 introduced context and objectives. Chapter 2 reviewed related systems and technology choices. Chapter 3 documented stakeholders and requirements. Chapter 4 described architecture, module design, API, and data model perspectives. Chapter 5 detailed implementation evidence and integrations. Chapter 6 covered testing and defect observations. Chapter 7 presented objective achievement and scorecard analysis. Chapter 8 concluded with contributions and future improvements.

---

# Chapter 2: Literature Review

## 2.1 Overview of Existing Systems
Owner-facing business management systems for salons commonly appear in generalized booking platforms, vertical salon SaaS suites, marketplace-linked dashboards, and POS-centric retail systems. General booking systems provide scheduling but often lack deep service-product workflow support. Vertical salon suites provide rich domain features but can impose platform lock-in. Marketplace dashboards improve lead channels but may constrain owner autonomy. POS-oriented systems excel at transaction handling but underperform in specialist scheduling and appointment lifecycle management.

The audited system positioned itself as a hybrid, combining service workflows, product operations, analytics, communication, and localization. This made it highly relevant for modern service businesses that operate both appointment-driven and product-driven revenue streams.

## 2.2 Technology Comparison
Flutter was chosen for cross-platform delivery and UI consistency. Compared with native development, Flutter reduced duplicated code and maintenance overhead. GetX provided integrated state management, routing, and dependency injection with low boilerplate. Compared with BLoC or Riverpod, GetX offered rapid implementation speed at the cost of requiring stricter discipline for large-scale maintainability.

REST API integration via `http` was straightforward and broadly compatible. A GraphQL approach could offer stronger schema-driven typing but would require backend adoption and additional client complexity. SharedPreferences met lightweight persistence needs but is less suitable for sensitive credentials than secure storage.

## 2.3 Research Gap
The gap addressed by this project was the transition from feature completeness to engineering readiness. Many systems in this domain deliver broad functionality but underinvest in security hardening, type safety, test automation, and long-term maintainability. This report filled that gap through a quantified, evidence-based audit and a practical improvement roadmap.

---

# Chapter 3: System Analysis and Requirements

## 3.1 Stakeholder Analysis
The primary stakeholder was the business owner/administrator requiring centralized control of appointments, orders, services, products, and analytics. Secondary stakeholders included staff/specialists managed through owner workflows, end customers indirectly affected by reliability and status communication, management decision-makers relying on reporting, and technical maintainers responsible for sustainability of the codebase.

## 3.2 Functional Requirements
- FR-01: The system shall authenticate owners via email/password.
- FR-02: The system shall support phone login via password and OTP.
- FR-03: The system shall support Firebase-based verification when configured.
- FR-04: The system shall persist session/profile metadata locally.
- FR-05: The system shall manage owner profile and category settings.
- FR-06: The system shall manage products, services, packages, and stylists.
- FR-07: The system shall manage appointments and product orders, including status updates.
- FR-08: The system shall provide invoice access for orders/appointments.
- FR-09: The system shall provide analytics in daily, monthly, and yearly views.
- FR-10: The system shall provide chat/inbox and support contact workflows.
- FR-11: The system shall support language switching.
- FR-12: The system shall initialize app settings from backend defaults.

## 3.3 Non-Functional Requirements
- NFR-01: Cross-platform compatibility.
- NFR-02: Responsive startup and interaction performance.
- NFR-03: Maintainable modular architecture.
- NFR-04: Robust error handling and graceful failure feedback.
- NFR-05: Secure token handling and sensitive data protection.
- NFR-06: Type-safe and lint-compliant code quality standards.
- NFR-07: Scalable feature extension with low duplication.
- NFR-08: Testability at unit/integration/widget levels.

## 3.4 Use Case Diagram Description
| Actor | Use Case | Description | Precondition | Postcondition |
|---|---|---|---|---|
| Owner | Login and Session Start | Authenticates and initializes session | Valid credentials | Dashboard access granted |
| Owner | Manage Appointments | Views details and updates status | Authenticated user | Status synced to backend |
| Owner | Manage Product Orders | Reviews order and updates lifecycle state | Authenticated user | Order state updated |
| Owner | Manage Catalog | Creates/updates/deletes products/services/packages | Authenticated user | Catalog data updated |
| Owner | View Analytics | Reviews trend and earnings charts | Data available | Visual insights displayed |

---

# Chapter 4: System Design

## 4.1 Architecture Overview
The application used a layered GetX architecture with views, controllers, parsers, models, and bindings. This pattern separated responsibilities at folder level and provided predictable feature scaffolding. Initialization and dependency wiring were centralized in `lib/app/helper/init.dart`, while route registration was centralized in `lib/app/helper/router.dart`.

The architecture favored rapid development and clear directory conventions. However, some implementation practices (large controllers, repeated flow logic) reduced the full benefits of modular design.

## 4.2 Folder Structure and Module Breakdown
The `lib/app` directory contained backend abstractions (`api`, `parse`, `models`, `binding`), presentation logic (`controller`), shared utilities (`helper`, `util`), and UI (`view`). The module distribution showed heavy concentration in view and controller layers, indicating strong feature coverage with high UI/business-flow complexity.

## 4.3 Database Design
No client-side relational database schema was present. The app used backend-managed domain data and local key-value persistence through SharedPreferences. Key entities inferred from models included users, profiles, appointments, product orders, products, services, packages, categories, cities, analytics metrics, and chat objects.

## 4.4 API Design
Endpoints were centralized in `lib/app/util/constance.dart`. API transport methods in `api.dart` provided public/private GET/POST and multipart upload. Bearer token headers were used for private APIs, but invoice generation included tokens in query strings in detail controllers, which should be redesigned.

## 4.5 UI/UX Design Principles
The UI followed mobile-admin patterns: splash initialization, authenticated dashboard navigation, form-centric CRUD, detail views, and chart-driven analytics. Localization support existed via runtime language switching. Accessibility support relied on default Flutter widget behavior, with opportunities to improve semantics and micro-interactions.

---

# Chapter 5: Implementation

## 5.1 Development Environment Setup
The implementation used Flutter with Dart 3 constraints, platform runners for mobile/web/desktop, dependency configuration in `pubspec.yaml`, and lint baseline in `analysis_options.yaml`. Firebase integration was configured in `lib/firebase_options.dart`.

## 5.2 Module-by-Module Implementation

### API Layer
`ApiService` in `lib/app/backend/api/api.dart` implemented transport wrappers and response parsing. It handled timeout logic and JSON decode fallback. Security-sensitive logs were identified and marked for removal.

### Dependency Injection and Startup
`MainBinding` in `lib/app/helper/init.dart` registered shared preferences, API service, and per-feature parsers/controllers. The pattern was consistent but highly centralized, increasing maintenance overhead as feature count grew.

### Routing
`AppRouter` in `lib/app/helper/router.dart` mapped route constants to `GetPage` definitions and bindings. A duplicate route entry was discovered for `reviewRoutes`.

### Authentication Flows
`LoginController` implemented email/password and phone/OTP flows with multiple asynchronous branches, session persistence, and post-login navigation. Repeated logic for loading dialogs and status handling was observed.

### Splash and Settings Bootstrapping
`SplashController` and `SplashScreen` handled app config fetch, FCM token capture, locale setup, and route selection. A potential late initialization risk existed for language fallback handling.

### Domain Modules (Products/Orders/Analytics)
Product and order controllers performed fetch, parse, update, and navigation actions. Analytics views provided segmented chart/table rendering. Lifecycle cleanup patterns were inconsistent in large stateful views.

## 5.3 Third-Party Integrations
Primary integrations included GetX, HTTP, SharedPreferences, Firebase Core/Messaging, Syncfusion chart/calendar, Connectivity Plus, Image Picker, URL Launcher, and country/language utility packages. Integration choices were suitable for the feature set and platform goals.

## 5.4 Security Implementation
The system implemented token-based private API access and session persistence. However, token logging and token-in-URL patterns were identified as critical issues. Input validation existed in major forms but required stronger centralization and consistency.

---

# Chapter 6: Testing

## 6.1 Testing Strategy
Testing evidence in the repository was limited to a default widget test. Therefore, the evaluation relied heavily on static analysis (`flutter analyze`), structural inspection, and code-path reasoning for high-risk flows.

## 6.2 Test Cases
| Test ID | Description | Input | Expected Output | Result | Status |
|---|---|---|---|---|---|
| TC-01 | Email login validation | Invalid email | Validation message shown | Observed in controller logic | Pass (logic) |
| TC-02 | Empty login fields | Empty form | Required fields message | Observed in controller logic | Pass (logic) |
| TC-03 | Route uniqueness | Route map scan | Unique route names | Duplicate found | Fail |
| TC-04 | Token confidentiality in logs | Private request | No token logs | Token logged | Fail |
| TC-05 | Invoice auth handling | Open invoice URL | Secure auth channel | Token in query string | Fail |
| TC-06 | Splash locale fallback safety | No stored language | Safe fallback locale | Late init risk present | Fail risk |
| TC-07 | Analyzer compliance | `flutter analyze` | No major issues | 193 issues detected | Fail |
| TC-08 | Automated test readiness | `test/` review | Unit/integration tests present | Minimal tests only | Fail |

## 6.3 Bug Log
Critical and major issues included route duplication, token leakage in logs and URLs, splash initialization risk, weak connectivity check condition, missing lifecycle cleanup patterns, and broad lint/type-safety issues.

## 6.4 Testing Limitations
No backend runtime environment, production telemetry, or full integration harness was available during the audit. As a result, findings focused on source-level evidence and static quality indicators.

---

# Chapter 7: Results and Evaluation

## 7.1 Achievement of Objectives
All planned audit objectives were achieved: full workspace scan, architecture mapping, risk identification, scorecard generation, and prioritized recommendations.

## 7.2 Scorecard Analysis
| Area | Score | Note |
|------|-------|------|
| Code Quality | 5/10 | Strong structure, but duplication and weak typing reduce quality. |
| Architecture | 6/10 | Layering exists; controller-level complexity is high. |
| State Management | 5/10 | GetX consistency exists; update patterns are broad and imperative. |
| API Layer | 6/10 | Centralized API service, but weak error model and security flaws. |
| Security | 4/10 | Token leakage concerns require immediate remediation. |
| Testing | 2/10 | Minimal automated testing present. |
| Documentation | 3/10 | README is generic and onboarding support is low. |
| Performance | 5/10 | Potential rebuild and lifecycle inefficiencies. |

## 7.3 Performance Analysis
The codebase showed acceptable baseline patterns for moderate workloads but exposed risks in broad rebuild triggers, large widget trees, and incomplete resource disposal. Optimization efforts should target granular state updates and lifecycle cleanup.

## 7.4 User Acceptance Testing
Formal UAT records were not available in the repository. Based on module breadth, the application likely satisfied key owner workflows, but reliability and maintainability concerns may affect long-term acceptance.

---

# Chapter 8: Conclusion and Future Work

## 8.1 Summary of Contributions
This project produced a comprehensive engineering audit of a real-world owner-facing Flutter application. It provided an evidence-based quality baseline, identified high-priority technical risks, and delivered a practical improvement plan.

## 8.2 Lessons Learned
Key lessons included the need for security hygiene from early stages, the importance of reducing duplicated controller logic, the value of strict typing in Dart, and the necessity of automated tests for sustainable feature evolution.

## 8.3 Future Enhancements
1. Remove token logging and token-in-query-string patterns; adopt secure token channels.
2. Refactor duplicated auth and status-update flows into reusable abstractions.
3. Introduce typed API request/response contracts and strict lint gates.
4. Build unit/integration/widget test suites for critical flows.
5. Add lifecycle cleanup (`onClose`/`dispose`) across controllers and views.
6. Replace boilerplate README with complete onboarding and architecture documentation.

---

# References (IEEE)
[1] Flutter Documentation, “Flutter,” Google, 2026. [Online]. Available: https://docs.flutter.dev/  
[2] Dart Documentation, “Dart language and tools,” Google, 2026. [Online]. Available: https://dart.dev/  
[3] J. Borges et al., “GetX Package,” pub.dev, 2026. [Online]. Available: https://pub.dev/packages/get  
[4] Dart Team, “http package,” pub.dev, 2026. [Online]. Available: https://pub.dev/packages/http  
[5] Flutter Team, “shared_preferences package,” pub.dev, 2026. [Online]. Available: https://pub.dev/packages/shared_preferences  
[6] Firebase, “FlutterFire Documentation,” Google, 2026. [Online]. Available: https://firebase.flutter.dev/  
[7] Syncfusion, “Flutter Charts Documentation,” 2026. [Online]. Available: https://help.syncfusion.com/flutter/cartesian-charts/overview  
[8] Syncfusion, “Flutter Calendar Documentation,” 2026. [Online]. Available: https://help.syncfusion.com/flutter/calendar/overview  
[9] Flutter Team, “connectivity_plus package,” pub.dev, 2026. [Online]. Available: https://pub.dev/packages/connectivity_plus  
[10] Flutter Team, “url_launcher package,” pub.dev, 2026. [Online]. Available: https://pub.dev/packages/url_launcher

---

# Appendices

## Appendix A: Folder Structure (Condensed)
```text
Owner_app/
├── android/
├── assets/
├── ios/
├── lib/
│   ├── app/
│   │   ├── backend/
│   │   ├── controller/
│   │   ├── helper/
│   │   ├── util/
│   │   └── view/
│   ├── firebase_options.dart
│   └── main.dart
├── test/
├── web/
└── windows/
```

## Appendix B: API Endpoint Domains
Authentication, Profile, Categories/Cities, Products, Orders, Appointments, Services/Packages/Stylist, Chat/Notification, Analytics, Contact/Support endpoints were centralized in `lib/app/util/constance.dart`.

## Appendix C: Setup Guide
1. Install Flutter SDK and platform prerequisites.
2. Run `flutter pub get`.
3. Run `flutter analyze`.
4. Run `flutter test`.
5. Launch with `flutter run`.

## Appendix D: Glossary
- API: Application Programming Interface
- DTO: Data Transfer Object
- DI: Dependency Injection
- FCM: Firebase Cloud Messaging
- NFR: Non-Functional Requirement
- UAT: User Acceptance Testing

