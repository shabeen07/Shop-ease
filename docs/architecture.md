# Architecture Document

**Project:** Flutter Spec-Driven Development Project  
**Version:** 2.0  
**Platform:** Flutter / Dart  
**Architecture:** Clean Architecture + BLoC  
**Navigation:** go_router  
**Dependency Injection:** get_it  
**Networking:** Dio  
**Serialization:** json_serializable  
**Design System:** Latest Flutter Material 3  
**Primary Color:** Electric Blue  
**Theme Modes:** Light / Dark / System

---

## 1. Purpose

This document defines the technical architecture of the Flutter mobile application.

The assignment requires the Architecture Document to define:

- Application architecture.
- Coding standards.
- Security.
- Folder structure.
- State management.
- Component hierarchy.
- Storage management.
- API architecture. fileciteturn4file0L19-L34

The architecture uses **Clean Architecture + BLoC** with a feature-based organization. The application has now been expanded from the required Login → Home → Detail flow to also include Profile, Settings and Notifications.

The additional features follow the same architectural boundaries as the required features.

---

## 2. Architecture Goals

The architecture is designed to provide:

- Clear separation of responsibilities.
- Testable business logic.
- Independent domain logic.
- Maintainable feature modules.
- Predictable BLoC state management.
- Centralized navigation.
- Centralized dependency injection.
- Controlled API communication.
- Consistent error handling.
- Secure session handling.
- Centralized application theme.
- Support for Light, Dark and System themes.
- Easy extension of additional features.

These goals extend the original architecture goals while preserving its Clean Architecture boundaries. fileciteturn4file0L38-L52

---

## 3. Application Feature Set

The current approved feature set is:

### Core Required Features

```text
Authentication / Login
Home / Products
Product Detail
```

### Additional Features

```text
Profile
Settings
Notifications
```

### Complete Application Flow

```text
                         ┌──────────────┐
                         │    Login     │
                         └──────┬───────┘
                                │
                                ▼
                         ┌──────────────┐
                         │     Home     │
                         │   Products   │
                         └──────┬───────┘
                                │
                    ┌───────────┴───────────┐
                    │                       │
                    ▼                       ▼
             Product Detail          Primary Navigation
                                            │
                               ┌────────────┼────────────┐
                               ▼            ▼            ▼
                            Home      Notifications    Profile
                                                        │
                                              ┌─────────┴─────────┐
                                              ▼                   ▼
                                          Settings          Edit Profile
                                              │
                                         Theme / About /
                                         Notifications /
                                         Privacy / Terms

Profile
  │
  └── Logout
       ↓
     Login
```

The assignment requires Login, Home and Detail, and allows additional functionality. fileciteturn3file5L748-L765

---

## 4. Architectural Pattern

The application uses **Clean Architecture** with a **feature-based project structure**.

Each feature is divided into:

```text
Presentation
    ↓
Domain
    ↓
Data
```

The architectural dependency direction is:

```text
┌───────────────────────────────┐
│         Presentation          │
│  Pages / Widgets / BLoC       │
└───────────────┬───────────────┘
                ↓
┌───────────────────────────────┐
│            Domain             │
│ Entities / Use Cases /        │
│ Repository Contracts          │
└───────────────┬───────────────┘
                ↑
┌───────────────────────────────┐
│             Data              │
│ Repository Impl / DataSource  │
│ Models / API / Local Storage  │
└───────────────────────────────┘
```

The Domain layer owns business abstractions. Data implements those abstractions, while Presentation consumes Domain use cases. This preserves the existing dependency direction. fileciteturn4file0L56-L96

---

## 5. Layer Responsibilities

### 5.1 Presentation

Responsible for:

- Pages/screens.
- Widgets.
- BLoCs.
- Events.
- States.
- Presentation-specific helpers.
- User interaction.
- Navigation triggers where appropriate.

Presentation must not directly communicate with:

- Dio.
- Remote data sources.
- Local storage implementations.
- API DTOs.

This remains a mandatory architectural boundary. fileciteturn4file0L100-L115

### 5.2 Domain

Responsible for:

- Entities.
- Repository contracts.
- Use cases.
- Business rules.
- Domain-level failures where required.

Domain must not depend on:

- Flutter UI widgets.
- Dio.
- API response models.
- Concrete repositories.
- Concrete storage packages.
- Local implementation details.

This preserves the existing Domain isolation. fileciteturn4file0L117-L134

### 5.3 Data

Responsible for:

- Repository implementations.
- Remote data sources.
- Local data sources.
- API models/DTOs.
- Serialization.
- Mapping.
- Persistence implementation.
- External service integration.

The Data layer communicates with APIs and storage through infrastructure abstractions. fileciteturn4file0L136-L148

---

## 6. Feature-Based Organization

Each application capability owns its own:

```text
data/
domain/
presentation/
```

Current feature modules:

```text
features/
├── auth/
├── home/
├── product_detail/
├── profile/
├── settings/
└── notifications/
```

### Feature Responsibilities

| Feature | Responsibility |
|---|---|
| `auth` | Login, authentication session |
| `home` | Product listing, pagination, refresh |
| `product_detail` | Selected product details |
| `profile` | User information, logout, profile entry points |
| `settings` | Application preferences and appearance |
| `notifications` | Notification list/read state |
```

The original architecture used `auth`, `home` and `detail`; the structure is now expanded to reflect the approved features. fileciteturn4file0L190-L209

---

## 7. Project Folder Structure

The proposed Flutter structure is:

```text
lib/
├── app/
│   ├── di/
│   │   └── injection.dart
│   │
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── route_names.dart
│   │   └── auth_redirect.dart
│   │
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       ├── app_typography.dart
│       ├── app_spacing.dart
│       └── app_theme_extensions.dart
│
├── core/
│   ├── constants/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── network_info.dart
│   │   └── interceptors/
│   ├── storage/
│   │   ├── secure_storage.dart
│   │   └── local_storage.dart
│   ├── utils/
│   └── extensions/
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    ├── home/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    ├── product_detail/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    ├── profile/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    ├── settings/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/
    │       └── widgets/
    │
    └── notifications/
        ├── data/
        │   ├── datasources/
        │   ├── models/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   ├── repositories/
        │   └── usecases/
        └── presentation/
            ├── bloc/
            ├── pages/
            └── widgets/

test/
├── core/
├── app/
└── features/
    ├── auth/
    ├── home/
    ├── product_detail/
    ├── profile/
    ├── settings/
    └── notifications/

docs/
├── task.md
├── architecture.md
├── engineering.md
├── design.md
├── navigation.md
└── features/
    ├── authentication.md
    ├── home.md
    ├── product_detail.md
    ├── profile.md
    ├── settings.md
    └── notifications.md
```

---

## 8. State Management

The application uses **BLoC** for feature state management.

The standard flow is:

```text
User Action
    ↓
BLoC Event
    ↓
BLoC
    ↓
Use Case
    ↓
Repository
    ↓
Data Source
    ↓
External Service / Storage
```

Response:

```text
External Service / Storage
    ↓
Data Source
    ↓
Repository
    ↓
Use Case
    ↓
BLoC
    ↓
BLoC State
    ↓
UI
```

This follows the existing BLoC architecture requirement. fileciteturn4file0L301-L350

### 8.1 Authentication BLoC

Responsibilities:

- Login.
- Authentication state.
- Session restoration.
- Logout.
- Authentication failure.

Conceptual states:

```text
AuthInitial
AuthChecking
AuthUnauthenticated
AuthAuthenticating
AuthAuthenticated
AuthFailure
AuthLoggingOut
```

### 8.2 Login BLoC

If Login is kept separate from the global authentication/session BLoC:

```text
LoginInitial
LoginLoading
LoginSuccess
LoginFailure
```

Login success must update the application authentication state.

### 8.3 Home BLoC

```text
HomeInitial
HomeLoading
HomeSuccess
HomeEmpty
HomeFailure
HomeRefreshing
HomePaginationLoading
HomePaginationFailure
```

Responsibilities include:

- Initial product retrieval.
- Refresh.
- Pagination.
- Product list state.

### 8.4 Product Detail BLoC

```text
ProductDetailInitial
ProductDetailLoading
ProductDetailSuccess
ProductDetailNotFound
ProductDetailFailure
```

### 8.5 Profile BLoC

```text
ProfileInitial
ProfileLoading
ProfileSuccess
ProfileFailure
LogoutInProgress
LogoutFailure
```

Responsibilities:

- Display authenticated user information.
- Coordinate logout.
- Expose profile state to the UI.

Profile must not own the global authentication session. Logout should delegate to the authentication/session abstraction.

### 8.6 Settings BLoC

```text
SettingsInitial
SettingsLoading
SettingsLoaded
SettingsFailure
```

Settings BLoC manages:

- Theme mode.
- Notification preference.
- Other approved application preferences.

Theme selection:

```text
System
Light
Dark
```

### 8.7 Notifications BLoC

```text
NotificationsInitial
NotificationsLoading
NotificationsSuccess
NotificationsEmpty
NotificationsFailure
```

Events:

```text
NotificationsRequested
NotificationRead
```

The Notifications specification is currently planned/optional. Since the assignment does not define a notifications API, the architecture must not invent a remote API. A local/mock repository may be used only if the feature is explicitly included in scope. fileciteturn3file2L315-L327 fileciteturn3file2L388-L392

---

## 9. Global Application State

Feature BLoCs must remain focused on their feature responsibilities.

Application-wide concerns should not be duplicated across every BLoC.

A lightweight application/session state may be used for:

```text
Authentication status
Current user
Session availability
Theme mode
Global lifecycle state
```

Conceptual application state:

```text
AppState
├── authentication
├── currentUser
└── session
```

Settings remains responsible for user preference management, while the application theme consumes the resulting theme mode.

The application router observes authentication state for route protection.

---

## 10. Component Hierarchy

The application hierarchy is now:

```text
MyApp
└── MaterialApp.router
    ├── Theme
    ├── AppRouter
    │
    ├── LoginPage
    │   └── LoginForm
    │       ├── UsernameField
    │       ├── PasswordField
    │       └── LoginButton
    │
    └── AuthenticatedShell
        ├── NavigationBar / NavigationRail
        │
        ├── HomePage
        │   ├── HomeHeader
        │   ├── ProductList
        │   │   └── ProductCard
        │   └── HomeStateView
        │
        ├── NotificationsPage
        │   ├── NotificationList
        │   ├── NotificationItem
        │   └── NotificationStateView
        │
        └── ProfilePage
            ├── ProfileHeader
            ├── ProfileInformation
            ├── ProfileActions
            └── LogoutAction

ProductDetailPage
├── ProductImage
├── ProductHeader
├── ProductPrice
├── ProductRating
├── ProductDescription
└── ProductInformation

SettingsPage
├── AppearanceSection
│   └── ThemeSelector
├── NotificationsSection
├── AboutSection
└── LegalSection

EditProfilePage
└── ProfileForm
```

The exact UI component hierarchy remains subject to the Design Document and HTML prototype validation, consistent with the original architecture approach. fileciteturn4file0L379-L404

---

## 11. Navigation Architecture

Navigation uses `go_router`.

The approved route structure is:

```text
/login

/home
/product/:id

/notifications

/profile
/profile/edit

/settings
```

Protected routes:

```text
/home
/product/:id
/notifications
/profile
/profile/edit
/settings
```

Public route:

```text
/login
```

Conceptual flow:

```text
                 ┌─────────┐
                 │  Login  │
                 └────┬────┘
                      │
              Authentication
                      │
                      ▼
                 ┌─────────┐
                 │  Home   │
                 └────┬────┘
                      │
       ┌──────────────┼───────────────┐
       ▼              ▼               ▼
 Product Detail  Notifications     Profile
                                       │
                              ┌────────┴────────┐
                              ▼                 ▼
                          Settings        Edit Profile
```

Logout:

```text
Profile
   ↓
Logout
   ↓
Clear Session
   ↓
Unauthenticated
   ↓
Login
```

Navigation decisions must remain centralized in the application router. The existing architecture already requires centralized routing. fileciteturn4file0L408-L460

---

## 12. Authentication & Route Guard Architecture

Authentication state controls access to protected routes.

Startup:

```text
Application Start
       ↓
Restore Session
       ↓
Authentication State
       ↓
 ┌─────┴─────┐
 ▼           ▼
Valid       Invalid
 │           │
 ▼           ▼
Home       Login
```

If an unauthenticated user accesses:

```text
/home
/settings
/profile
/notifications
/product/1
```

the router redirects to:

```text
/login
```

If an authenticated user accesses:

```text
/login
```

the router redirects to:

```text
/home
```

Logout must clear the session and reset protected navigation state.

---

## 13. API Architecture

The application communicates with the DummyJSON API using Dio.

Architecture:

```text
BLoC
 ↓
Use Case
 ↓
Repository Interface
 ↓
Repository Implementation
 ↓
Remote Data Source
 ↓
Dio Client
 ↓
DummyJSON
```

The original architecture establishes this same API boundary. fileciteturn4file0L464-L484

### API-backed Features

```text
auth
 └── Authentication API

home
 └── Products List API

product_detail
 └── Product Detail API
```

### Profile

Profile initially uses authenticated user/session information where available.

If a dedicated profile API is introduced later:

```text
ProfileBloc
 ↓
GetProfile
 ↓
ProfileRepository
 ↓
ProfileRemoteDataSource
 ↓
Dio
```

### Notifications

No remote notifications API is defined by the assignment.

Therefore:

```text
NotificationsBloc
 ↓
GetNotifications
 ↓
NotificationsRepository
 ↓
NotificationsDataSource
```

The data source may initially be local/mock if Notifications is approved as an optional feature.

It must not introduce an undocumented external API.

---

## 14. Data Models and Domain Entities

API models and Domain entities must remain separate.

Example:

```text
API JSON
   ↓
ProductModel
   ↓
Product Entity
   ↓
Use Case
   ↓
BLoC
   ↓
UI
```

This rule applies to all features:

```text
AuthModel       → Auth/User Entity
ProductModel    → Product Entity
ProfileModel    → Profile Entity
SettingsModel   → AppSettings Entity
NotificationModel → Notification Entity
```

The Domain layer must never depend on API DTOs. This preserves the existing model/entity boundary. fileciteturn4file0L535-L575

---

## 15. Use Cases

Each use case should have one clear responsibility.

### Authentication

```text
LoginUser
RestoreSession
LogoutUser
```

### Home

```text
GetProducts
RefreshProducts
GetNextProductsPage
```

### Product Detail

```text
GetProductDetail
```

### Profile

```text
GetProfile
```

Logout should reuse:

```text
LogoutUser
```

rather than duplicating authentication logic inside Profile.

### Settings

```text
GetSettings
UpdateTheme
UpdateNotificationPreference
```

### Notifications

```text
GetNotifications
MarkNotificationAsRead
```

Use cases must not know about:

- Flutter widgets.
- BLoCs.
- Dio.
- API DTOs.
- Concrete storage packages.

This follows the existing use-case boundary. fileciteturn4file0L579-L610

---

## 16. Dependency Injection

`get_it` will be used for dependency injection.

Registration hierarchy:

```text
External Services
      ↓
Infrastructure
      ↓
Data Sources
      ↓
Repositories
      ↓
Use Cases
      ↓
BLoCs
```

Example:

```text
Dio
 ↓
AuthRemoteDataSource
 ↓
AuthRepositoryImpl
 ↓
LoginUser
 ↓
LoginBloc
```

Additional registrations:

```text
ProductRemoteDataSource
ProductRepositoryImpl
GetProducts
HomeBloc

ProductDetailRemoteDataSource
ProductDetailRepositoryImpl
GetProductDetail
ProductDetailBloc

ProfileRepositoryImpl
GetProfile
ProfileBloc

SettingsLocalDataSource
SettingsRepositoryImpl
GetSettings
UpdateTheme
SettingsBloc

NotificationsDataSource
NotificationsRepositoryImpl
GetNotifications
NotificationsBloc
```

Dependencies must be registered centrally and injected rather than instantiated directly inside features. fileciteturn4file0L613-L647

---

## 17. Storage Architecture

The application now has a legitimate persistence requirement because:

- Authentication/session information may need persistence.
- Theme preference should persist.
- Notification preferences may persist.

Storage must remain abstracted.

Architecture:

```text
Domain
  ↓
Repository Interface
  ↑
Repository Implementation
  ↓
Local Data Source
  ↓
Storage Provider
```

### Secure Storage

Sensitive authentication information must use secure storage.

Potential secure values:

```text
accessToken
refreshToken
```

### Local Preferences

Non-sensitive preferences may use local preference storage:

```text
themeMode
notificationsEnabled
```

The Domain layer must not depend directly on the selected storage package.

This extends the existing storage rule, which requires storage abstraction and secure storage for sensitive session information. fileciteturn3file9L1268-L1288

---

## 18. Theme Architecture

The application uses the latest Material 3 approach.

Primary brand color:

```text
Electric Blue
```

The Electric Blue value should be used as the seed for the Material 3 color system rather than scattering raw color values throughout widgets.

Conceptual theme:

```text
AppTheme
├── Light
└── Dark
```

Theme modes:

```text
System
Light
Dark
```

Default:

```text
System
```

Settings controls the selected theme mode.

The application theme consumes the selected mode:

```text
Settings
   ↓
ThemePreference
   ↓
AppTheme
   ↓
MaterialApp.router
```

The existing Design Document already specifies Electric Blue, Material 3 semantic roles and Light/Dark/System behavior. fileciteturn3file7L1017-L1037 fileciteturn3file7L1073-L1138

---

## 19. Error Architecture

Technical exceptions must be converted into application-level failures.

```text
API / Storage Exception
        ↓
Data Layer
        ↓
Failure
        ↓
Use Case
        ↓
BLoC
        ↓
User-Friendly State
        ↓
UI
```

Potential failures:

```text
NetworkFailure
TimeoutFailure
ServerFailure
UnauthorizedFailure
NotFoundFailure
ParsingFailure
StorageFailure
UnknownFailure
```

Feature-specific UI decides how to present the failure.

Examples:

```text
HomeFailure
ProductDetailNotFound
LoginFailure
ProfileFailure
SettingsFailure
NotificationsFailure
```

The original error architecture already establishes this separation between technical exceptions and user-facing application failures. fileciteturn3file9L1292-L1323

---

## 20. Unauthorized Handling

An unauthorized response should be treated as an authentication/session event rather than a normal screen error.

Flow:

```text
API Request
    ↓
401 Unauthorized
    ↓
UnauthorizedFailure
    ↓
Session Manager / Auth State
    ↓
Clear Session
    ↓
Router
    ↓
Login
```

The application must avoid creating multiple competing logout/navigation actions.

The authentication/session mechanism is the single source of truth for authenticated state.

---

## 21. Security

The application must:

- Never hard-code secrets.
- Never commit access tokens.
- Never log passwords.
- Never log authentication tokens.
- Never expose raw API errors.
- Use HTTPS.
- Avoid plain-text sensitive storage.
- Use secure storage for persisted credentials/tokens.
- Validate external data.
- Keep environment-specific configuration outside business logic.

DummyJSON remains a mock API and must not be treated as a production authentication system. fileciteturn3file9L1327-L1342

---

## 22. Coding Standards

The project follows:

- Dart formatting conventions.
- Flutter recommended practices.
- `flutter_lints`.
- Meaningful names.
- Small focused classes.
- Single Responsibility Principle.
- Immutable BLoC state where practical.
- Explicit error handling.
- Feature-based organization.
- No business logic inside widgets.

Avoid:

- God classes.
- Direct API calls from widgets.
- Business logic in `build()`.
- Unnecessary global mutable state.
- Duplicate API handling.
- Unnecessary abstraction.
- Unused dependencies.

These remain aligned with the existing coding standards. fileciteturn3file9L1346-L1369

---

## 23. Testing Architecture

Testing follows the architectural boundaries.

### Domain

Test:

- Use cases.
- Business rules.
- Failure handling.

### Data

Test:

- Data sources.
- API response parsing.
- Repository implementations.
- Model/entity mapping.
- Local data source behavior.

### Presentation

Test:

- BLoC events.
- State transitions.
- Loading states.
- Success states.
- Empty states.
- Failure states.
- User interactions.

### Router

Test:

- Authentication redirects.
- Protected routes.
- Login redirect.
- Logout navigation.
- Product ID route.
- Back navigation.

### Integration

Critical journeys:

```text
Login
  ↓
Home
  ↓
Product Detail
  ↓
Back
  ↓
Home
```

Additional journeys:

```text
Login
  ↓
Home
  ↓
Profile
  ↓
Settings
  ↓
Change Theme
```

```text
Home
  ↓
Notifications
  ↓
Mark as Read
```

```text
Profile
  ↓
Logout
  ↓
Login
```

The original testing architecture requires testing according to Domain, Data, Presentation and Integration boundaries. fileciteturn3file9L1373-L1417

---

## 24. Architecture Constraints

The following are mandatory:

1. Widgets must not call API clients directly.
2. BLoCs must not depend directly on Dio.
3. Domain entities must not depend on API models.
4. Domain code must not depend on Flutter UI.
5. Repository interfaces belong to Domain.
6. Repository implementations belong to Data.
7. API-specific models belong to Data.
8. Navigation is centralized through `go_router`.
9. Dependencies are injected through `get_it`.
10. Sensitive session data uses secure storage.
11. Application preferences use an abstracted persistence layer.
12. Feature BLoCs must not become global state containers without architectural justification.
13. Authentication state has a single source of truth.
14. Settings must not directly manipulate unrelated feature state.
15. Notifications must not introduce an undocumented remote API.
16. Architecture changes must be documented before implementation.

The original architecture already establishes the first ten core architectural constraints; the additional constraints extend them to the newly approved features. fileciteturn3file9L1421-L1434

---

## 25. Feature Dependency Rules

Features should remain independently testable.

Allowed:

```text
Profile
  ↓
Auth Domain abstraction
```

Allowed:

```text
Settings
  ↓
Application Theme abstraction
```

Allowed:

```text
Home
  ↓
Product Domain
```

Avoid:

```text
Home → ProfilePage
Profile → HomeBloc
Settings → HomeBloc
Notifications → ProfileBloc
```

Features should communicate through:

- Domain abstractions.
- Application-level state.
- Router.
- Shared core abstractions.

They should not directly manipulate another feature's BLoC.

---

## 26. SDD Relationship

Architecture decisions are part of the SDD workflow.

The project flow remains:

```text
Requirement
    ↓
Task Specification
    ↓
Architecture Decision
    ↓
Feature Specification
    ↓
Design Specification
    ↓
Static HTML Prototype
    ↓
UX/UI Validation
    ↓
Flutter Implementation
    ↓
Testing
    ↓
Documentation Update
```

The assignment requires specification, review/approval, HTML prototype, UX/UI validation, implementation, testing and documentation update before considering a feature complete. fileciteturn3file5L837-L845

If implementation reveals an architectural requirement that is not documented, this Architecture Document must be updated before proceeding.

---

## 27. Architecture Decision Summary

| Area | Decision |
|---|---|
| Framework | Flutter |
| Language | Dart |
| Architecture | Clean Architecture |
| Organization | Feature-based |
| State Management | BLoC |
| Networking | Dio |
| Navigation | go_router |
| Dependency Injection | get_it |
| Serialization | json_serializable |
| Design System | Latest Material 3 |
| Primary Color | Electric Blue |
| Theme Modes | Light / Dark / System |
| Authentication | DummyJSON |
| Product API | DummyJSON |
| Session Storage | Secure storage |
| Preferences | Abstracted local storage |
| Notifications | Local/mock initially unless API is approved |
| Testing | Unit + BLoC + Widget + Router + Integration |

---

## 28. Architecture Completion Checklist

- [x] Clean Architecture selected.
- [x] Feature-based structure defined.
- [x] BLoC selected.
- [x] Authentication architecture defined.
- [x] Home/Product architecture defined.
- [x] Product Detail architecture defined.
- [x] Profile architecture defined.
- [x] Settings architecture defined.
- [x] Notifications architecture defined.
- [x] Navigation architecture defined.
- [x] Authentication guards defined.
- [x] Storage architecture defined.
- [x] Theme architecture defined.
- [x] API architecture defined.
- [x] Error architecture defined.
- [x] Security constraints defined.
- [x] Testing architecture defined.
- [x] Feature dependency rules defined.

---

## 29. Future Extensibility

The architecture must allow additional features without restructuring existing modules.

Potential future modules:

```text
features/
├── auth/
├── home/
├── product_detail/
├── profile/
├── settings/
├── notifications/
├── search/
├── favorites/
├── cart/
└── checkout/
```

Each feature should continue to follow:

```text
data/
domain/
presentation/
```

New features must not introduce dependencies that violate the architectural boundaries defined in this document.
