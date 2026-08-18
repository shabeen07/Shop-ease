# AI Post-Implementation Review & Repair Workflow

This workflow is MANDATORY for the AI agent to execute immediately after any code changes. A task is not considered "Done" until this review is complete and all identified issues are repaired.

## Step 1: Structural Integrity Audit
Verify that the changes adhere to **Clean Architecture** and **BLoC** patterns:
- [ ] **Presentation:** Widgets are stateless/purely UI; logic is moved to BLoCs.
- [ ] **Domain:** Use Cases and Entities have NO external dependencies (Dio, UI, DTOs).
- [ ] **Data:** Models handle JSON serialization; Repositories implement domain contracts.
- [ ] **State Management:** States are exhaustive; Events represent user intent.

## Step 2: Technical Quality Check (Analysis Protocol)
Execute the mandatory analysis steps defined in [Analysis Protocol](file:///C:/Users/Opentrends/StudioProjects/AI-assignment/.agents/workflows/analysis-protocol.agent.md):
1.  **Format:** `dart format .`
2.  **Fix:** `dart fix --apply`
3.  **Analyze:** `flutter analyze`
- [ ] **Zero Errors & Zero Warnings:** All reported issues must be resolved or justified.

## Step 3: Feature & Design Compliance
Cross-reference the implementation with project documentation:
- [ ] **Requirements:** Matches the spec in `docs/features/*.md`.
- [ ] **Design:** Matches the UI/UX defined in `docs/prototype.html` and `docs/design.md`.
- [ ] **Theme:** Uses M3 semantic tokens (e.g., `colorScheme.primary`) instead of hardcoded hex values.

## Step 4: Verification Loop (Testing)
Ensure the reliability of the new/modified code:
- [ ] **Unit/BLoC Tests:** Run `flutter test`. All tests must pass.
- [ ] **Coverage:** Verify that critical paths and edge cases (error states, empty states) are covered.

## Step 5: Dependency & Plumbing Audit
Check the "wiring" of the application:
- [ ] **DI Registration:** New dependencies are registered in `lib/app/di/injection.dart`.
- [ ] **Routing:** New pages/flows are correctly mapped in `lib/app/router/app_router.dart`.
- [ ] **Imports:** No relative imports in `lib/` (use `package:` style).

## Repair Cycle
If any of the above checks fail:
1.  **Locate:** Identify the root cause.
2.  **Repair:** Fix the code using the appropriate project skills.
3.  **Re-verify:** Repeat the review workflow from Step 1 until all checks pass.
