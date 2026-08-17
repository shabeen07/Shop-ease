# Spec-Driven Development (SDD) Workflow Guide

This workflow is MANDATORY for all feature implementations.

## Phase 1: Specification
1. **Analyze Requirements:** Read `docs/task.md` and any relevant user input.
2. **Draft Feature Spec:** Create/Update `docs/features/<feature_name>.md`.
   - Include Functional Requirements, Acceptance Criteria, and Edge Cases.
3. **Draft Architecture Decision:** If new patterns are needed, update `docs/architecture.md`.
4. **USER APPROVAL:** Present the spec to the user. DO NOT proceed until approved.

## Phase 2: Design & Prototyping
1. **Draft Design Spec:** Update `docs/design.md` if UI components change.
2. **Create HTML Prototype:** Update/Create `docs/prototype.html` or specialized prototypes in `docs/prototypes/`.
3. **UX/UI Validation:** Verify the prototype matches requirements and Material 3 standards.
4. **USER APPROVAL:** Present the prototype to the user.

## Phase 3: Implementation
1. **Layered Implementation:**
   - **Domain:** Entities, Repository Interfaces, Use Cases.
   - **Data:** Models (DTOs), DataSources, Repository Implementations.
   - **Presentation:** BLoC (Events, States), Pages, Widgets.
2. **DI Registration:** Update `injection.dart`.
3. **Navigation:** Update `app_router.dart`.
4. **Code Generation:** Run `build_runner` if using `json_serializable`.

## Phase 4: Verification
1. **Testing:**
   - Unit tests for Use Cases and Business Logic.
   - BLoC tests for state transitions.
   - Widget tests for UI behavior.
2. **Static Analysis:** Run `flutter analyze` and `dart format .`.
3. **Documentation Update:** Update `README.md` or feature docs with implementation details.
4. **Final Walkthrough:** Create a `walkthrough.artifact.md` showing changes and verification results.
