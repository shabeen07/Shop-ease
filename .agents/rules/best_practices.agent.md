# Dart & Flutter Best Practices

## 1. Code Quality & Style
- **Lints:** Follow `flutter_lints` and project-specific rules in `analysis_options.yaml`.
- **Deprecations:** Never ignore `deprecated_member_use` warnings. Follow the "Try replacing the use..." suggestion in the analyzer output.
- **Formatting:** Use `dart format .` before every commit.
- **Immutability:** Use `final` and `const` wherever possible.
- **Null Safety:** Leverage Dart's sound null safety; avoid `!`.

## 2. Advanced Clean Code
- **DRY (Don't Repeat Yourself):** Extract common logic into utils or shared widgets.
- **SOLID:** Adhere to Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion.
- **Modern Syntax:** 
    - Prefer **Records** for multiple return values instead of custom classes for trivial pairs.
    - Use **Switch expressions** for exhaustive enum checks.
    - Leverage **Super parameters** to reduce boilerplate.

## 3. Performance Optimization
- **Widget Trees:** Keep `build` methods pure and lightweight.
- **Repaint Boundaries:** Use `RepaintBoundary` for complex or frequently changing widgets.
- **List Optimization:** Always use `ListView.builder` for dynamic or large lists.
- **Const Constructors:** Use `const` constructors aggressively in widget builds.

## 4. Memory & Resource Management
- **Disposal:** Mandatory disposal of `ChangeNotifier`, `StreamController`, `AnimationController`, and `ScrollController` in `dispose()`.
- **Streams:** Always close `StreamController` and cancel `StreamSubscription` to prevent memory leaks.

## 5. State Management Best Practices
- **UI Logic vs Business Logic:** Never perform business logic inside a `StatefulWidget`.
- **Bloc Selection:** Only provide BLoCs where they are needed to minimize the scope of state changes.

## 6. Security & Testing
- **Sensitive Data:** Never store PII or tokens in local storage without encryption.
- **Mocks:** Use `mocktail` for testing components in isolation.
- **Test Coverage:** Aim for high coverage in Domain and Data layers.
