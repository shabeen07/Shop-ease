# Engineering Document

**Project:** Flutter Spec-Driven Development Project  
**Version:** 1.0  
**Platform:** Flutter / Dart  
**Architecture:** Clean Architecture + BLoC

---

## 1. Purpose

This document defines the engineering standards and implementation approach for the Flutter application.

The assignment requires the Engineering Document to describe:

- Mobile implementation
- Libraries
- Build tools
- Coding standards
- Development workflow
- Environment setup
- External API integrations

The implementation described here is adapted from the assignment's React Native requirements to Flutter.

---

## 2. Technology Stack

### 2.1 Core Technology

| Technology | Purpose |
|---|---|
| Flutter | Mobile application framework |
| Dart | Programming language |
| BLoC | State management |
| Clean Architecture | Application architecture |

### 2.2 Planned Libraries

| Library | Purpose |
|---|---|
| `flutter_bloc` | BLoC integration with Flutter |
| `bloc` | Core BLoC implementation |
| `dio` | HTTP networking |
| `go_router` | Application navigation |
| `get_it` | Dependency injection |
| `json_annotation` | JSON serialization annotations |
| `json_serializable` | Generated JSON serialization |
| `build_runner` | Code generation |

The final versions must be recorded in `pubspec.yaml`.

Dependencies should only be added when they satisfy a documented requirement.

---

## 3. Development Environment

The development environment must provide:

- Flutter SDK
- Dart SDK supplied with the selected Flutter SDK
- Android development environment for Android builds
- Xcode for iOS development where iOS builds are required
- Git
- IDE/editor with Flutter and Dart support

The project should use a consistent Flutter SDK version across the development team.

The selected Flutter version must be documented in the project README and CI environment.

---

## 4. Project Initialization

The project should be created as a Flutter application and then organized according to the approved Architecture Document.

Initial setup:

```bash
flutter create <project_name>
cd <project_name>
```

Dependencies should then be added through `pubspec.yaml`.

Example:

```bash
flutter pub add flutter_bloc
flutter pub add dio
flutter pub add go_router
flutter pub add get_it
flutter pub add json_annotation
flutter pub add dev:json_serializable
flutter pub add dev:build_runner
```

The exact dependency list may change during implementation if the corresponding requirement is documented.

---

## 5. Application Structure

The engineering implementation must follow the architecture defined in `architecture.md`.

```text
lib/
├── app/
├── core/
└── features/
    ├── auth/
    ├── home/
    └── detail/
```

Feature implementation follows:

```text
feature/
├── data/
├── domain/
└── presentation/
```

Technical responsibilities must remain within their defined architectural layers.

---

## 6. Coding Standards

The project must follow Dart and Flutter coding conventions.

### 6.1 General Rules

The project must follow Dart and Flutter coding conventions, as well as the AI-specific guidelines defined in the `.agents/` directory:

- [AI Project Rules](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/rules/rules.agent.md)
- [SDD Workflow](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/workflows/sdd-workflow.agent.md)
- [Review Workflow](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/workflows/review-workflow.agent.md)
- [Analysis Protocol](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/workflows/analysis-protocol.agent.md)
- [Best Practices](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/rules/best_practices.agent.md)
- [Testing Rules](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/rules/testing.agent.md)
- [Project Core Skill](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/skills/project_core/SKILL.md)
- [Testing Skill](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/skills/testing/SKILL.md)
- [Legacy Rules (AGENTS.md)](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/rules/AGENTS.md)

General rules:
- Use `dart format .`.
- Use `flutter analyze`.
- Follow the project's lint configuration.
- Use meaningful names.
- Keep classes focused.
- Keep methods small and understandable.
- Prefer immutable objects.
- Avoid unnecessary global state.
- Avoid duplicated business logic.
- Remove unused code and dependencies.
- Keep comments focused on explaining intent rather than obvious implementation.

### 6.2 Naming

Use standard Dart naming conventions:

```text
Classes       → PascalCase
Methods       → camelCase
Variables      → camelCase
Constants     → lowerCamelCase
Files         → snake_case
```

Examples:

```dart
class LoginBloc {}

Future<void> loadProducts() {}

final selectedProduct = product;

const defaultTimeout = Duration(seconds: 30);
```

### 6.3 Widget Guidelines

Widgets should:

- Focus on presentation.
- Receive data/state from the appropriate state-management layer.
- Avoid direct API access.
- Avoid business rules.
- Avoid unnecessary rebuilds.
- Be reusable when there is a genuine reuse requirement.

---

## 7. BLoC Engineering Standards

BLoC is the selected state-management solution.

The typical implementation is:

```text
Page
  ↓
BlocProvider
  ↓
BlocBuilder / BlocListener
  ↓
BLoC
  ↓
Use Case
  ↓
Repository
```

### 7.1 Events

Events represent actions or triggers.

Examples:

```text
LoginSubmitted
HomeItemsRequested
DetailRequested
```

### 7.2 States

States represent the observable state of a feature.

Examples:

```text
Initial
Loading
Success
Empty
Failure
```

### 7.3 BLoC Rules

BLoCs must:

- Contain presentation state-management logic.
- Call use cases rather than repositories directly where the use-case layer is applicable.
- Emit predictable states.
- Handle failures.
- Avoid direct widget manipulation.
- Avoid direct HTTP calls.

---

## 8. Domain Engineering

The Domain layer contains:

```text
entities/
repositories/
usecases/
```

### 8.1 Entities

Entities represent application-level concepts.

They must not depend on API-specific models.

### 8.2 Repository Contracts

Repository interfaces define what the application requires from data access.

Example:

```dart
abstract class AuthRepository {
  Future<Result<User>> login({
    required String username,
    required String password,
  });
}
```

The exact result/failure approach will be finalized during implementation.

### 8.3 Use Cases

Each use case should have a single responsibility.

Examples:

```text
LoginUser
GetHomeItems
GetDetailItem
```

A use case must not depend on Flutter widgets or concrete infrastructure classes.

---

## 9. Data Engineering

The Data layer contains:

```text
datasources/
models/
repositories/
```

### 9.1 Remote Data Sources

Remote data sources are responsible for API communication.

Examples:

```text
AuthRemoteDataSource
HomeRemoteDataSource
DetailRemoteDataSource
```

They must not contain UI or presentation logic.

### 9.2 Models

Models represent external API structures.

Example:

```text
ProductModel
UserModel
```

JSON serialization should use `json_serializable` where appropriate.

### 9.3 Repository Implementations

Repositories transform external data into domain-level data.

Example:

```text
Remote API
    ↓
ProductModel
    ↓
ProductRepositoryImpl
    ↓
Product Entity
    ↓
Use Case
```

---

## 10. Networking

`Dio` will be used as the HTTP client.

The networking layer should provide:

- Configurable base URL.
- Connection timeout.
- Send timeout.
- Receive timeout.
- Common headers.
- Error conversion.
- Optional interceptors.

Example conceptual configuration:

```dart
BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 30),
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
)
```

Actual timeout values should be finalized based on application requirements.

---

## 11. API Integration

The assignment provides:

```text
https://dummyjson.com/
```

API integration must be isolated from presentation code.

The expected flow is:

```text
BLoC
 ↓
Use Case
 ↓
Repository
 ↓
Remote Data Source
 ↓
Dio
 ↓
DummyJSON
```

### 11.1 API Requirements

The implementation must:

- Use a centralized base URL.
- Avoid hard-coded endpoint URLs throughout the codebase.
- Handle HTTP errors.
- Handle timeout failures.
- Handle network failures.
- Validate/parse responses.
- Map API data to domain entities.
- Avoid exposing raw API exceptions to the UI.

---

## 12. Error Handling

Technical exceptions should be converted into application-level failures.

Conceptual structure:

```text
DioException
    ↓
Data Layer Exception
    ↓
Repository
    ↓
Failure
    ↓
Use Case
    ↓
BLoC State
    ↓
UI
```

Potential failure types:

```text
NetworkFailure
TimeoutFailure
ServerFailure
UnauthorizedFailure
ParsingFailure
UnknownFailure
```

The exact hierarchy will be finalized during implementation.

---

## 13. Environment Configuration

The API base URL and environment-specific configuration must not be duplicated throughout the application.

The project should support environment-specific configuration such as:

```text
Development
QA/Test
Production
```

A conceptual structure is:

```text
config/
├── dev
├── qas
└── prod
```

The exact implementation mechanism will be selected during project setup.

Sensitive configuration must not be committed to source control.

---

## 14. Build Configuration

The project must support standard Flutter build commands.

### Android

```bash
flutter build apk
flutter build appbundle
```

### iOS

```bash
flutter build ios
```

Production builds must use the appropriate signing and release configuration.

Build-specific configuration should remain outside feature/business logic.

---

## 15. Code Generation

Where `json_serializable` is used, generated files must be produced through `build_runner`.

Example:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files should not be manually edited.

---

## 16. Dependency Injection

`get_it` will be used to register dependencies.

The registration order should follow the dependency hierarchy:

```text
Dio
 ↓
Data Source
 ↓
Repository
 ↓
Use Case
 ↓
BLoC
```

Feature dependencies should be registered in a predictable and centralized manner.

---

## 17. Navigation

`go_router` will manage application routing.

Initial routes:

```text
/login
/home
/home/detail/:id
```

Navigation should not be implemented by manually pushing routes from unrelated business logic.

Authentication-related redirects should be centralized in the routing configuration.

---

## 18. Storage

Persistent storage is not required by the initial task unless authentication/session persistence is introduced.

If storage is required:

- Define an abstraction.
- Keep the concrete storage implementation outside the Domain layer.
- Use secure storage for sensitive authentication/session information.
- Do not store passwords.
- Do not log stored credentials or tokens.

---

## 19. Security Engineering

The implementation must:

- Use HTTPS.
- Never hard-code secrets.
- Never commit credentials.
- Never log passwords.
- Never log access tokens.
- Avoid exposing sensitive API responses.
- Avoid storing sensitive values in plain text.
- Validate external data.
- Keep production configuration separate from source code where appropriate.

DummyJSON is a mock service and must not be treated as a production authentication provider.

---

## 20. Testing

Testing must be implemented alongside feature development.

### 20.1 Unit Tests

Unit tests should cover:

- Use cases.
- Business rules.
- Failure handling.
- Data transformations where appropriate.

### 20.2 BLoC Tests

BLoC tests should verify:

```text
Event
  ↓
Expected State(s)
```

Examples:

```text
LoginSubmitted
→ LoginLoading
→ LoginSuccess
```

or:

```text
LoginSubmitted
→ LoginLoading
→ LoginFailure
```

### 20.3 Widget Tests

Widget tests should cover important UI behavior such as:

- Form validation.
- Loading states.
- Error states.
- Successful rendering.
- User interactions.

### 20.4 Integration Tests

Critical user journeys should be tested where practical:

```text
Login
  ↓
Home
  ↓
Select Item
  ↓
Detail
```

---

## 21. Static Analysis and Formatting

Before a feature is considered complete, the following should pass:

```bash
dart format .
flutter analyze
flutter test
```

Any analyzer errors should be resolved before the feature is considered complete.

Warnings should be reviewed rather than ignored.

---

## 22. Git and Branching

Development should use feature branches.

Example:

```text
main
  │
  ├── feature/auth
  ├── feature/home
  └── feature/detail
```

Commits should represent focused changes.

Examples:

```text
feat: add login specification
feat: implement login bloc
feat: add home repository
test: add login bloc tests
docs: update architecture
```

---

## 23. SDD Engineering Workflow

Engineering work must follow the approved specification.

```text
Task Specification
       ↓
Architecture
       ↓
Feature Specification
       ↓
HTML Prototype
       ↓
UX/UI Approval
       ↓
Flutter Implementation
       ↓
Unit/BLoC/Widget Tests
       ↓
Integration Testing
       ↓
Documentation Update
```

Implementation should not introduce undocumented behavior.

If implementation requires a change to the specification, update the relevant document first.

---

## 24. Definition of Done

A feature is engineering-complete when:

- [ ] Approved specification exists.
- [ ] Approved HTML prototype exists.
- [ ] Architecture requirements are satisfied.
- [ ] Flutter implementation is complete.
- [ ] BLoC state transitions are implemented.
- [ ] API integration is implemented through the approved architecture.
- [ ] Error handling is implemented.
- [ ] Required tests pass.
- [ ] `dart format` passes.
- [ ] `flutter analyze` passes.
- [ ] Documentation is updated.
- [ ] No undocumented feature behavior has been introduced.

---

## 25. Engineering Constraints

The following rules are mandatory:

1. Do not call APIs directly from widgets.
2. Do not put business logic inside widgets.
3. Do not make BLoCs depend directly on Dio.
4. Do not expose API models to the Domain layer.
5. Do not put Flutter UI dependencies inside Domain entities/use cases.
6. Do not hard-code environment-specific API configuration throughout the codebase.
7. Do not commit secrets.
8. Do not skip the approved SDD workflow.
9. Do not implement a feature before its specification and prototype are approved.
10. Update documentation whenever an approved requirement or architecture decision changes.

---

## 26. Relationship With Other Documents

This Engineering Document works together with:

```text
task.md
    ↓
architecture.md
    ↓
design.md
    ↓
feature specifications
    ↓
implementation
```

Each implementation decision must be traceable to the approved project documentation.

