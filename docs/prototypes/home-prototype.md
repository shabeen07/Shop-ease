# Home Prototype

## 1. Purpose
Displays the browsable product catalogue with search and category filtering.

## 2. Entry Points
- Successful login.
- Navigating back from Product Detail.
- Selecting **Home** in the M3 Navigation Bar.

## 3. Exit Points
- Tap a product card → Product Detail.
- Tap **Alerts** nav item → Notifications.
- Tap **Profile** nav item → Profile.

## 4. Layout

```
┌────────────────────────────────────────┐
│  Products                   🔔  ⚙      │  ← M3 Top App Bar (large title)
├────────────────────────────────────────┤
│  🔍 Search products…              🎤   │  ← M3 Search Bar (surface-container-highest)
├────────────────────────────────────────┤
│  [All] [Electronics] [Fashion] [Home]  │  ← M3 Filter Chips (scrollable row)
├─────────────────┬──────────────────────┤
│  📱             │  🎧                  │  ← Product Cards (2-col grid)
│  Smartphone X   │  Wireless Headphones │
│  Electronics    │  Audio               │
│  ★4.8  $699     │  ★4.5  $149          │
├─────────────────┼──────────────────────┤
│  ⌚             │  💻                  │
│  Smart Watch    │  Laptop Ultra        │
│  Wearables      │  Computers           │
│  ★4.6  $299     │  ★4.9  $1,299        │
├────────────────────────────────────────┤
│  🏠 Home    🔔 Alerts    👤 Profile    │  ← M3 Navigation Bar (pill indicator)
└────────────────────────────────────────┘
```

## 5. Components
- **M3 Top App Bar** — Bold 24px title `Products`, trailing `notifications` and `tune` icon buttons.
- **M3 Search Bar** — Full-width, pill-shaped, `surface-container-highest` background, `search` leading icon, `mic` trailing icon.
- **M3 Filter Chips** — Horizontally scrollable; `selected` chip uses `primary-container` fill.
- **Product Card** — M3 elevated card (`elev-1` default, `elev-2` on hover, scale down on press). Displays: icon placeholder, product name, category, star rating, price. Optional badge chip (e.g., NEW, HOT).
- **M3 Navigation Bar** — Pill indicator animates on active item; icon switches to `FILL=1` when active.

## 6. Content
- 4 mock product cards: Smartphone X, Wireless Headphones, Smart Watch Pro, Laptop Ultra.
- Each card: Material Symbol product icon, name, category, star rating (with `star` symbol), price.

## 7. Material Symbols Used
- App bar actions: `notifications`, `tune`
- Search: `search`, `mic`
- Product icons: `smartphone`, `headphones`, `watch`, `laptop` (all FILL=1)
- Rating: `star`, `star_half` (FILL=1, amber colour)
- Navigation: `home`, `notifications`, `person` (FILL=1 when active)

## 8. User Interactions
- Scroll product grid vertically.
- Tap a category chip → chip gains `selected` state (visual only in prototype).
- Tap a product card → scale-down animation → navigate to Product Detail.
- Tap nav items → screen transition with slide-up + fade animation.

## 9. Loading State
- `m3-spinner` (48px circular indicator) centred in the content area.
- "Loading products…" caption below spinner.

## 10. Empty State
- `inventory_2` icon in a circular surface-variant container.
- Title: **No products found**
- Body: "There are currently no products to display."
- Tonal button: **Retry**

## 11. Error State
- `wifi_off` icon in a circular surface-variant container, icon coloured `error`.
- Title: **Something went wrong**
- Body: "We couldn't load the products. Check your connection."
- Tonal button: **Try again**

## 12. Theme Behaviour
- **Light**: White/near-white background, light surface cards, Electric Blue active chip/nav.
- **Dark**: Dark surface background, elevated dark cards (surface-container-low), Electric Blue accents.

## 13. Responsive Behaviour
- 2-column grid on phones.
- Chips row scrolls horizontally without wrapping.

## 14. Accessibility
- Product cards are `role="button"` (or `<button>`) with descriptive `aria-label`.
- Navigation items have `aria-label` and `role="button"`.
- Active nav item has `aria-selected="true"`.

## 15. Prototype State Controls
- Floating debug FAB (bottom-right) toggles a panel to switch between: Loading / Success / Empty / Error states.

## 16. Prototype Acceptance Criteria
- [ ] Search bar renders with correct M3 pill shape.
- [ ] Category chips show selected state.
- [ ] Product cards display icon, title, category, rating, price.
- [ ] Badge chips (NEW, HOT) display on designated cards.
- [ ] Loading / Empty / Error states toggle correctly.
- [ ] Navigation bar pill indicator animates to active item.
