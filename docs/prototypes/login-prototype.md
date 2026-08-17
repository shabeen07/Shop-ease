# Login Prototype

## 1. Purpose
Allows the user to authenticate using their credentials before accessing the main application.

## 2. Entry Points
- Launching the app unauthenticated (cold start).
- Completing a logout action from the Profile screen.

## 3. Exit Points
- Successful login → Home screen.

## 4. Layout

```
┌────────────────────────────────────────┐
│  ┌──────────────────────────────────┐  │
│  │ 🛍 Shop Ease                     │  │  ← Gradient Hero (Blue → Indigo → Violet)
│  │   Discover products you'll love   │  │
│  └──────────────────────────────────┘  │
│                                        │
│  Welcome back                          │  ← Title
│  Sign in to your account              │  ← Subtitle
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  Email address              (M3) │  │  ← M3 Outlined Text Field
│  └──────────────────────────────────┘  │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  Password                   (M3) │  │  ← M3 Outlined Text Field
│  └──────────────────────────────────┘  │
│                             Forgot?    │
│  ┌──────────────────────────────────┐  │
│  │            Sign in               │  │  ← Filled Button (Electric Blue)
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

## 5. Components
- **Login Hero Section** — Gradient background (Electric Blue → Indigo → Violet) with a glassmorphism logo icon (`shopping_bag`), app name and tagline.
- **M3 Outlined Text Fields** — Floating label animation on focus/fill; Electric Blue border on focus.
- **Forgot Password** — Inline right-aligned text link.
- **Primary Filled Button** — Electric Blue, full-width, pill-shaped (rounded-full), shows inline spinner on loading.
- **Error Banner** — M3 error-container coloured banner with `error` Material Symbol icon.

## 6. Material Symbols
- Logo icon: `shopping_bag` (FILL=1)
- Error banner: `error` (FILL=1)

## 7. Typography
- App name: Inter 32px, weight 800
- Hero tagline: Inter 14px, weight 400
- Page title: Inter 24px, weight 700
- Page subtitle: Inter 14px, weight 400
- Input labels: Inter 16px floating → 12px on focus
- Button label: Inter 16px, weight 600

## 8. User Interactions
- Tap/focus input → floating label animates, Electric Blue border appears.
- Tap **Sign in** → validation runs inline; if valid, button disables, text hides, spinner appears.
- After 1.2 s simulated delay → navigate to Home (or show error banner for `error@example.com`).

## 9. Loading State
- Login button disabled, text hidden, white spinner visible inside button.

## 10. Empty State
- N/A (form cannot be empty; validation handles this with inline field errors).

## 11. Error States
- **Inline field errors**: Red border + helper text below field.
- **API error banner**: Top-level M3 error-container banner with icon.
  - Demo trigger: use `error@example.com`.

## 12. Theme Behaviour
- **Light**: White/light-neutral form body, gradient hero, Electric Blue accents.
- **Dark**: Dark surface form body, same gradient hero, Electric Blue accents (slightly lighter token `#ADC6FF`).

## 13. Responsive Behaviour
- Form body scrollable; Hero fixed at top.
- Full-width button on mobile, centred max-width on desktop.

## 14. Accessibility
- Inputs use `<label>` with `for` associations.
- Error banner has `role="alert"` for screen-reader announcement.
- Spinner has `aria-label="Loading"`.
- Colour is never the sole error indicator (text always accompanies colour).

## 15. Prototype Acceptance Criteria
- [ ] Gradient hero renders correctly in light and dark themes.
- [ ] Floating label animates correctly on focus and blur.
- [ ] Inline field validation shows and clears correctly.
- [ ] Login button shows spinner and disables during simulated API call.
- [ ] Success navigates to Home.
- [ ] Error banner displays for simulated API failure.
