# Shop Ease

A modern Flutter e-commerce application developed using **Spec-Driven Development (SDD)**, **Clean Architecture**, and **BLoC**.

## 🚀 Overview

Shop Ease is a high-performance mobile application that focuses on technical excellence and maintainable architecture. It consumes the [DummyJSON API](https://dummyjson.com/) to provide a seamless product browsing and authentication experience.

## 🛠 Tech Stack

- **Framework:** Flutter / Dart
- **State Management:** `flutter_bloc`
- **Navigation:** `go_router`
- **Dependency Injection:** `get_it`
- **Networking:** `dio`
- **Serialization:** `json_serializable`
- **UI System:** Material 3 (Expressive)
- **Primary Color:** Electric Blue (#2563EB)

## 🏗 Architecture

The project strictly follows **Clean Architecture** principles, separated into three distinct layers:
- **Presentation:** UI Widgets and BLoCs.
- **Domain:** Pure business logic, Entities, and Repository contracts.
- **Data:** Repository implementations, Data Sources, and Models.

## 🤖 AI-Assisted Development

This project is optimized for AI-assisted engineering. Mandatory rules and workflows are established in the `.agents/` directory:
- **[AI Project Rules](.agents/rules/rules.agent.md):** Mandatory behavioral and technical standards.
- **[SDD Workflow](.agents/workflows/sdd-workflow.agent.md):** The step-by-step feature implementation process.
- **[Post-Implementation Review](.agents/workflows/review-workflow.agent.md):** Quality gates for code verification.
- **[Analysis Protocol](.agents/workflows/analysis-protocol.agent.md):** Mandatory static analysis and repair cycle.

## 📖 Documentation

Detailed specifications and guides are located in the `docs/` directory:
- [Architecture Details](docs/architecture.md)
- [Engineering Standards](docs/engineering.md)
- [Design System & UI](docs/design.md)
- [Task Baseline v1.0](docs/task.md)
- [Task Document v2.0 (Current)](docs/task_v2.md)
- [Feature Specs](docs/features/)

## 🏁 Getting Started

### Prerequisites
- Flutter SDK (Channel stable)
- Dart SDK

### Installation
1. Clone the repository.
2. Run `flutter pub get`.
3. Run code generation:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the application:
   ```bash
   flutter run
   ```

### Running Tests
Execute all unit and BLoC tests:
```bash
flutter test
```

### Static Analysis
Ensure code quality before committing:
```bash
flutter analyze
```
