# Implementation Verification Rule

This rule ensures that the AI agent's internal logic and the project's external implementation remain in perfect synchronization.

## 1. Mandatory Self-Audit
- After completing any significant milestone (e.g., a full feature or architectural refactor), the agent MUST invoke the `project-verifier` skill.
- The agent should present a "Verification Report" to the user, highlighting any deviations or confirming a 100% match.

## 2. Match Criteria
- **Protocol:** SDD workflow followed exactly.
- **Architecture:** Clean Architecture layers strictly separated.
- **Visuals:** Material 3 semantic roles used exclusively.
- **Analysis:** Zero issues in `flutter analyze`.

## 3. Rectification
- If the verification fails at any point, the agent must immediately propose a repair plan before starting new tasks.
