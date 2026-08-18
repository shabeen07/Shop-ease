---
name: project-verifier
description: A comprehensive auditing skill to ensure implementation exactly matches project protocols (Clean Architecture, SDD, BLoC, and M3).
---

# Project Implementation Verifier

Use this skill to perform a rigorous audit of any feature or the entire codebase.

## 1. Protocol Match (SDD & Workflow)
- [ ] **Traceability:** Can every file be traced back to a requirement in `docs/task.md` or a feature spec?
- [ ] **Phase Completion:** Does the implementation reflect the approved `docs/prototype.html`?
- [ ] **Documentation:** Are the engineering and architecture docs up-to-date with recent changes?

## 2. Structural Match (Clean Architecture)
- [ ] **Domain Isolation:** Run `grep -r "import.*package:flutter/" lib/features/*/domain` and ensure ZERO matches (except for foundation/meta).
- [ ] **Data Boundaries:** Ensure Repositories in the Data layer return `Either<Failure, Entity>` and use Models for JSON parsing.
- [ ] **Presentation Purity:** Ensure Widgets do not contain business logic or direct repository calls.

## 3. Tech Stack Match (BLoC & DI)
- [ ] **BLoC Pattern:** Verify sealed classes for States and Events. Verify that state is only changed via `emit()`.
- [ ] **DI Integrity:** Check `lib/app/di/injection.dart` for correct registration of all layers.
- [ ] **Router Guard:** Verify that protected routes are correctly guarded in `lib/app/router/app_router.dart`.

## 4. Visual Match (Material 3)
- [ ] **Semantic Tokens:** Check for hardcoded hex colors. Everything should use `Theme.of(context).colorScheme`.
- [ ] **Typography:** Verify that all text uses `Theme.of(context).textTheme` with the Inter font.
- [ ] **Responsiveness:** Verify the use of `LayoutBuilder` or `MaxCrossAxisExtent` for grids.

## 5. Quality Match (Analysis & Testing)
- [ ] **Analysis:** Run `flutter analyze` and verify **0 issues**.
- [ ] **Deprecation:** Verify zero `deprecated_member_use` warnings.
- [ ] **Testing:** Run `flutter test` and verify all pass. Check that tests mirror the `lib/` structure.

## Audit Command
When asked to "verify implementation," execute the following:
1. `flutter analyze`
2. `flutter test`
3. Scan DI and Router registrations.
4. Spot-check 1 file per layer (Presentation/Domain/Data) for dependency violations.
