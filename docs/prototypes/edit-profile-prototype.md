# Edit Profile Prototype

## 1. Purpose
Entry point for future profile editing functionality. Currently presented as a "Coming Soon" placeholder as per the approved feature scope.

## 2. Entry Points
- Tapping **Edit Profile** button in the Profile hero.
- Tapping **Edit Profile** in the Profile settings group.

## 3. Exit Points
- Back button → Profile screen.
- **Go back** tonal button → Profile screen.

## 4. Layout

```
┌────────────────────────────────────────┐
│  ←  Edit Profile                       │  ← M3 Top App Bar with back arrow
├────────────────────────────────────────┤
│                                        │
│                                        │
│             ┌───────────┐             │
│             │  🚧  opsz │             │  ← construction icon (primary colour)
│             └───────────┘             │    in circular surface-variant container
│                                        │
│           Coming Soon                  │  ← State title (18px/600)
│                                        │
│  Profile editing will be available     │
│  in a future version of the app.       │  ← State body (14px, on-surface-variant)
│                                        │
│        [ Go back ]                     │  ← Tonal button (pill-shaped)
│                                        │
│                                        │
└────────────────────────────────────────┘
```

## 5. Components
- **M3 Top App Bar** — `arrow_back` icon button, "Edit Profile" title.
- **Coming Soon State View** — Uses the standard `empty-state` component pattern:
  - Circular `surface-variant` icon container (80×80px).
  - `construction` Material Symbol (FILL=0, Electric Blue colour).
  - State title: **Coming Soon**
  - State body: descriptive message.
  - Tonal button: **Go back**

## 6. Material Symbols
- Back: `arrow_back`
- State icon: `construction` (FILL=0, primary colour)

## 7. Typography
- Screen title: Inter 22px, weight 400
- State title: Inter 18px, weight 600
- State body: Inter 14px, weight 400, on-surface-variant, line-height 1.5

## 8. Interaction
```
Tap back (←)  → navigate to Profile
Tap Go back   → navigate to Profile
```

## 9. States
Only a single visible state:
- **Coming Soon** — always displayed (uses the `empty-state` layout component).

No Loading / Error / Success states are required for this screen in the current scope.

## 10. Theme Behaviour
- **Light**: White background, light surface-variant icon container, Electric Blue icon.
- **Dark**: Dark background, dark surface-variant icon container, lighter Electric Blue icon token.

## 11. Design Constraint
> Do **not** add fake form fields or simulate profile saving. This screen is intentionally a placeholder until a real Edit Profile API and feature spec are approved.

## 12. Accessibility
- Back button: `aria-label="Back"`.
- State icon container: `aria-hidden="true"` (decorative).
- Go back button: semantic `<button>` with descriptive text.

## 13. Prototype Acceptance Criteria
- [ ] Screen shows Coming Soon state with `construction` icon.
- [ ] Back button and Go back button both navigate to Profile.
- [ ] No fake form elements are present.
