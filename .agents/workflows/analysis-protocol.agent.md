# AI Static Analysis Protocol

This document establishes the mandatory workflow for all AI-generated or modified code to ensure maximum engineering quality and "zero-issue" delivery.

## Mandatory Development Lifecycle

For every code change, the AI agent MUST follow these steps in sequence:

1.  **Generate/Modify Code:** Apply the requested changes while adhering to Clean Architecture and BLoC standards.
2.  **Run Code Formatter:** Ensure consistent style.
    ```bash
    dart format .
    ```
3.  **Apply Automated Fixes:** Automatically resolve mechanical lint issues.
    ```bash
    dart fix --apply
    ```
4.  **Execute Static Analysis:** Check for type safety and lint violations.
    ```bash
    flutter analyze
    ```
5.  **Manual Resolution:** If `flutter analyze` reports any remaining issues (e.g., type mismatches, missing required parameters), resolve them manually before considering the task complete.

## Analysis Expectations

- **Zero Errors:** Code MUST NOT have any analyzer errors.
- **Zero Warnings:** All linter warnings must be addressed (fixed or suppressed with valid justification).
- **Strict Typing:** Leverage the `strict-casts`, `strict-inference`, and `strict-raw-types` flags in `analysis_options.yaml` to prevent runtime bugs.

## When to Deviate
If a specific lint rule conflicts with an essential architectural pattern:
1.  Explain the conflict to the user.
2.  Add an inline ignore (e.g., `// ignore: <lint_rule>`) with a brief explanatory comment.
3.  NEVER ignore errors or critical security lints.
