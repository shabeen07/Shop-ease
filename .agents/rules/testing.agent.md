# Shop Ease - Testing Rules

These rules define the standards for testing in the Shop Ease project.

## 1. General Principles
- **Test-Driven Development (TDD):** Prefer writing tests before or alongside implementation.
- **Isolation:** Tests should be isolated. Use mocks for dependencies (Repositories, DataSources, etc.).
- **Naming:** Test files must end with `_test.dart` and reside in the `test/` directory, mirroring the `lib/` structure.
- **Coverage:** Aim for 100% coverage of business logic in the Domain layer (Use Cases) and critical paths in the Data layer.

## 2. Test Types
- **Unit Tests:** For Use Cases, Repositories, and Utility classes.
- **BLoC Tests:** Specialized unit tests for BLoC state transitions using `bloc_test`.
- **Widget Tests:** For verifying UI components and interaction logic.
- **Integration Tests:** For end-to-end user journeys (e.g., Login -> Home -> Detail).

## 3. Mocking Policy
- **Strict Mocking:** Use `mocktail` for all mocking needs.
- **No Real Network/Storage:** Never use real APIs or storage in unit/widget tests.
- **Mock Verification:** Always verify that the expected methods were called on the mocks.

## 4. BLoC Testing Standards
- **Event-State Integrity:** Every BLoC test must verify the exact sequence of states emitted for a given event.
- **Error Handling:** Always include tests for failure states (e.g., `HomeFailure`, `LoginFailure`).
- **Initial State:** Verify the initial state of the BLoC before any events are added.

## 5. Verification Requirements
- All tests MUST pass before a feature is considered complete.
- Run `flutter test` regularly during development.
