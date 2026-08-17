# Shop Ease - AI Project Rules

These rules are derived from the project's core documentation and define the mandatory standards for all AI-assisted development.

## 1. Architectural Integrity (Clean Architecture)
- **Layer Separation:** Strictly adhere to Presentation -> Domain <- Data dependency flow.
- **Domain Purity:** Domain entities and use cases MUST NOT depend on Flutter UI, Dio, or API DTOs.
- **Repository Contracts:** Defined in the Domain layer, implemented in the Data layer.
- **State Management:** strictly `flutter_bloc`. Business logic stays in BLoCs/Use Cases, not in Widgets.

## 2. Spec-Driven Development (SDD)
- **No Hallucinations:** Never guess business logic. Refer to `docs/` and `docs/features/`.
- **Protocol First:** If a feature lacks a spec or prototype, draft it and get approval BEFORE coding.
- **Traceability:** All code must link back to an approved spec or UI prototype (e.g., `docs/prototype.html`).

## 3. Technology Stack & Packages
- **State Management:** `flutter_bloc`
- **Networking:** `dio` (Centralized client in `core/network/`)
- **Routing:** `go_router` (Centralized in `app/router/`)
- **Dependency Injection:** `get_it` (Centralized in `app/di/`)
- **Serialization:** `json_serializable` & `json_annotation` (Use `build_runner`)

## 4. Engineering & Coding Standards
- **Naming:** Classes (PascalCase), Methods/Variables (camelCase), Files (snake_case).
- **Widgets:** Focus on presentation only. Receive state via `BlocBuilder`/`BlocListener`.
- **Error Handling:** Technical exceptions (Dio, Storage) -> Application Failures -> User-friendly State.
- **DI Registration:** External -> Infrastructure -> DataSources -> Repositories -> UseCases -> BLoCs.

## 5. Security & Safety
- **Secrets Management:** NO hardcoded keys, tokens, or sensitive configs in source code.
- **Logging:** Do not log sensitive payloads, passwords, or raw auth responses.
- **Secure Storage:** Sensitive session data (tokens) MUST use secure storage abstractions.

## 6. Design System
- **Theme:** Latest Material 3.
- **Primary Color:** Electric Blue (`#2563EB`).
- **Modes:** Support Light, Dark, and System modes via `AppTheme`.
