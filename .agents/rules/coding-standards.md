---
trigger: always_on
---

# Coding Standards

Day-to-day rules for writing Dart and Flutter code. Partly enforced by `analysis_options.yaml` and the pre-commit hook.

## Enforced by Analyzer

These are auto-checked by `flutter analyze`. Generated code must already pass:

- No `print()` in production
- Prefer `const` constructors
- `final` for non-reassigned locals
- Use `isEmpty` / `isNotEmpty`, not `length == 0`
- No return types on setters
- Sorted imports
- No unused imports or variables

## Naming

- **Files:** `snake_case.dart`, match primary class name
- **Classes:** `PascalCase`, nouns
- **Methods/variables:** `camelCase`, methods are verbs
- **Booleans:** read as questions — `isEmpty`, `hasError`, `canSubmit`
- **Constants:** `camelCase` (Dart convention, not `SCREAMING_CASE`)
- **Private members:** `_underscorePrefix`

### Required Suffixes

- `Bloc`, `Cubit`, `Event`, `State`
- `UseCase`
- `Repository` / `RepositoryImpl`
- `RemoteDataSource` / `LocalDataSource`

### Avoid

Avoid vague suffixes: `Helper`, `Manager`, `Util`, `Common`, `Service` (except platform wrappers like `BiometricService`).

Prefer specific names: `LoginValidator`, `AppointmentMapper`, `TokenRefresher`.

### BLoC Naming

- Class: `<Feature>Bloc` (e.g., `LoginBloc`)
- Events: `<Feature>Event` abstract, concrete like `LoginSubmitted`
- States: `<Feature>State` abstract, concrete like `LoginLoading`, `LoginSuccess`
- Files: `login_bloc.dart`, `login_event.dart`, `login_state.dart`

## Code Style

- Line length under 80 chars when reasonable
- Run `dart format` before commit (not enforced — your responsibility)
- Trailing commas on multi-line calls (helps formatter)
- Doc comments (`///`) on public classes and methods
- Inline comments (`//`) explain _why_, not _what_
- Never leave commented-out code. Git remembers.

## Const Usage

Use `const` aggressively. If a widget or value can be `const`, make it `const`. Especially in widget builds — `const Text(...)` is far cheaper than non-const.

## Null Safety

- Use nullable types (`String?`) only when genuinely needed
- Prefer non-nullable with defaults
- Use `late` sparingly, only with guaranteed initialization
- Avoid `!` bang operator — it crashes at runtime. Prefer `?.`, `??`, explicit null checks.

## Async

- Use `async`/`await` — avoid raw `Future.then` chains
- Always handle errors in async code — return `Failure` via `Either<Failure, T>`
- Never swallow errors silently

## Error Handling

Use `Either<Failure, T>` pattern.

- Repositories return `Future<Either<Failure, T>>`
- Exceptions converted to `Failure` in data layer
- BLoCs consume `Either`, never catch exceptions
- UI never shows raw backend errors

## Logging

- Use the project logger (under `lib/src/core/utils/` or similar)
- Never `print()` in production

## Localization

All user-facing strings go through the localization system.

- Strings live in `lib/src/l10n/` ARB files
- Access: `AppLocalizations.of(context)`
- When adding a string, update ALL language ARB files, not just one
- Key naming: `camelCase`, descriptive — `loginSubmitButton`, `errorNetworkUnavailable`
- When generating code with new strings, list the keys developer must add

## Validation

Two levels:

- **UI validation:** immediate feedback via helper functions
- **Business validation:** lives in use cases / domain layer

Rules:

- All validation messages must be localized
- Never hardcode validation messages
- Business rules must not rely only on UI validation

## Testing

Every new code change includes appropriate tests.

### Coverage

- **Use cases:** unit tests with mocked repository
- **Repositories:** unit tests with mocked datasources
- **BLoCs:** `bloc_test` package or equivalent state-transition tests
- **Widgets:** widget tests for non-trivial UI (forms, conditionals, lists with state)
- **Models:** only if they have non-trivial logic (factories, custom equality)

### Conventions

- Test file: `<source_file>_test.dart`
- Location mirrors source: `lib/src/features/auth/...` → `test/features/auth/...`
- Use `group()` for related tests
- Descriptive names: `'should return failure when network is unavailable'`
- Use existing mocking library (`mocktail` or `mockito`) — don't introduce a new one

### Don't Test

- Third-party library behavior
- Pure UI styling (exact colors/spacing)
- Generated code

## Imports

Order (blank line between groups):

1. Dart SDK (`dart:async`)
2. Flutter (`package:flutter/...`)
3. Third-party packages
4. Project imports (`package:<project>/...`)
5. Relative imports (`./`, `../`)

Analyzer enforces sorting.

## Code Generation

Project uses `json_serializable`.

- Never manually edit `*.g.dart` files
- If generated files are missing, flag to developer to run `flutter pub run build_runner build`

## Performance

- Use `const` widely
- Avoid heavy work in `build()`
- Extract reusable widgets
- Dispose controllers properly
- Optimize only after profiling

## Deviating From These Rules

Sometimes a rule doesn't fit. When deviating:

1. Explain why in a code comment
2. Flag it in your response
3. Never break rules silently

## Comments

- **Only comment code logic**, not functional details
- Keep comments **one line, simple**
- If code is clear, no comment needed