# Dart & Flutter Best Practices

## 1. Code Quality & Style
- **Lints:** Follow `flutter_lints` and project-specific rules in `analysis_options.yaml`.
- **Formatting:** Use `dart format .` before every commit.
- **Immutability:** Use `final` and `const` wherever possible.
- **Null Safety:** Leverage Dart's sound null safety; avoid `!`.

## 2. Clean Code Principles
- **DRY (Don't Repeat Yourself):** Extract common logic into utils or shared widgets.
- **KISS (Keep It Simple, Stupid):** Avoid over-engineering; use the simplest solution that works.
- **SOLID:** Adhere to Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion.

## 3. Performance Optimization
- **Widget Trees:** Keep `build` methods pure and lightweight.
- **Repaint Boundaries:** Use `RepaintBoundary` for complex or frequently changing widgets.
- **List Optimization:** Use `ListView.builder` for large lists to lazily load items.
- **Image Optimization:** Use appropriate image formats and sizes; cache network images.

## 4. State Management Best Practices
- **UI Logic vs Business Logic:** Never perform business logic inside a `StatefulWidget`.
- **Bloc Selection:** Only provide BLoCs where they are needed to minimize the scope of state changes.
- **Streams:** Always close `StreamController` and cancel `StreamSubscription` to prevent memory leaks.

## 5. Security Best Practices
- **Sensitive Data:** Never store PII or tokens in local storage without encryption.
- **Input Validation:** Sanitize all user input on the client-side, but never trust it without server-side validation.
- **Permissions:** Request only the minimum necessary permissions.

## 6. Testing
- **Test Coverage:** Aim for high coverage in Domain and Data layers.
- **Mocks:** Use `mockito` or `mocktail` for testing components in isolation.
- **Goldens:** Use Golden Tests to prevent regression in UI layout.
