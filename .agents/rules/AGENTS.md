# Shop Ease - AI Rules

These rules apply specifically to this project and define the standard for AI-assisted development.

## 1. Prevent AI Blind Development
- **No Hallucinated Implementations:** Never guess business logic or architectural patterns. You must always search for and read the project's specification documents, prototypes, and existing source code before creating or modifying features.
- **Traceability:** Every piece of generated code must be traceable back to an approved technical specification, user story, or UI/UX prototype.
- **Specification First:** If tasked with a feature that lacks documentation or design prototypes, you MUST first draft the specification and obtain user approval BEFORE writing application code.

## 2. Security First Principles
- **Secrets Management:** Never commit hardcoded tokens, passwords, API keys, or any sensitive configuration data to source code.
- **Logging Safety:** Do not add print or log statements that expose sensitive payloads or raw authentication responses.
- **Secure Defaults:** Always default to secure connections (HTTPS) and enforce authorization checks on protected routes or actions.

## 3. Engineering Rigor
- **Architecture Compliance:** Strictly adhere to the established architectural patterns of the repository (Clean Architecture, BLoC). Do not introduce rogue patterns.
- **Testability:** Write code that is testable in isolation. Dependency Injection should be preferred over hardcoded dependencies.
- **State Segregation:** Keep business logic strictly separated from UI logic. UI components must only consume and react to state.

## 4. Documentation Paths (Project Specific)
- You MUST explicitly reference the `docs/` directory for specifications.
- Architecture: `docs/architecture.md`
- Engineering/DevOps: `docs/engineering.md`
- Design/UI: `docs/design.md`
- Feature Specs: `docs/features/*.md`

## 5. Technology Stack & Packages (Project Specific)
- **State Management:** strictly `flutter_bloc`.
- **Networking:** strictly `dio`.
- **Routing:** strictly `go_router`.
- **Dependency Injection:** strictly `get_it`.
- **Data Serialization:** strictly `json_serializable` and `json_annotation`.

## 6. Design System Enforcement (Project Specific)
- The primary theme color MUST be **Electric Blue (`#2563EB`)**.
- The application must support Light, Dark, and System modes.
- UI implementations must accurately reflect `docs/prototype.html`.
