# Product Detail Prototype

## 1. Purpose
Displays complete information for a product selected from the Home screen.

## 2. Entry Points
- Tapping a product card on the Home screen.

## 3. Exit Points
- Back button → Home screen.

## 4. Layout

```
┌────────────────────────────────────────┐
│  ←  Product Detail     🔗  ♡           │  ← M3 Top App Bar (back, share, favourite)
├────────────────────────────────────────┤
│  ┌──────────────────────────────────┐  │
│  │                                  │  │
│  │     📱  (product icon)            │  │  ← Gradient image hero (primary-container)
│  │                        NEW ARRIVAL│  │    with badge chip
│  └──────────────────────────────────┘  │
│                                        │
│  Smartphone X                 $699     │  ← Title + Price
│  Electronics · Apple          $799̶     │  ← Category + Strikethrough old price
│  ★★★★½  4.8  (120 reviews)           │  ← Star rating row
│                                        │
│  ┌──────────────────────────────────┐  │
│  │ Description                      │  │  ← Surface-variant rounded card
│  │ The latest Smartphone X…         │  │
│  └──────────────────────────────────┘  │
│                                        │
│  ┌─────────┬────────┬──────┬────────┐  │
│  │ STOCK   │ SKU    │ DISC │WARRANTY│  │  ← 2×2 info grid (surface-variant tiles)
│  │ In Stock│SPX-001 │ 12%  │ 1 Year │  │
│  └─────────┴────────┴──────┴────────┘  │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │  🛒  Add to cart                 │  │  ← Filled Button (Electric Blue, pill)
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

## 5. Components
- **M3 Top App Bar** — Back `arrow_back`, trailing `share` and `favorite_border` icon buttons.
- **Product Image Hero** — Aspect-ratio-1 gradient area (`primary-container` → `secondary-container`); Material Symbol product icon centred; badge pill chip (e.g., NEW ARRIVAL).
- **Title / Price Row** — Product name (22px/700), price (24px/800, primary), strikethrough original price.
- **Rating Row** — Five `star`/`star_half` symbols (amber), numeric rating, review count.
- **Description Card** — Surface-variant rounded container (16px radius).
- **Info Grid** — 2×2 grid of surface-variant tiles: Stock, SKU, Discount, Warranty.
- **Primary CTA Button** — `add_shopping_cart` icon + "Add to cart" label; pill-shaped Electric Blue filled button.

## 6. Material Symbols
- App bar: `arrow_back`, `share`, `favorite_border`
- Product image: `smartphone` (FILL=1)
- Rating: `star`, `star_half` (FILL=1, #F59E0B)
- CTA: `add_shopping_cart`

## 7. Typography
- Product name: Inter 22px, weight 700
- Price: Inter 24px, weight 800, Electric Blue
- Old price: Inter 12px, strikethrough, on-surface-variant
- Category: Inter 13px, on-surface-variant
- Rating value: Inter 14px, weight 600
- Section title: Inter 14px, weight 600
- Info tile label: Inter 11px, uppercase, on-surface-variant
- Info tile value: Inter 14px, weight 600

## 8. User Interactions
- Back button → navigate to Home.
- `favorite_border` → visual toggle (prototype only).
- Scroll scrollable content below image.
- Tap **Add to cart** → visual press animation.

## 9. Loading State
- `m3-spinner` centred in content area.
- "Loading details…" caption.

## 10. Empty State (Not Found)
- `search_off` icon in circular container.
- Title: **Product not found**
- Body: "The product you're looking for doesn't exist."
- Tonal button: **Go back**

## 11. Error State
- `error_outline` icon (error colour) in circular container.
- Title: **Something went wrong**
- Body: "We couldn't load the product details."
- Tonal button: **Retry**

## 12. Theme Behaviour
- **Light**: Gradient hero uses light primary-container / secondary-container tokens.
- **Dark**: Gradient hero uses dark token equivalents; text adapts automatically.

## 13. Accessibility
- Back button `aria-label="Back"`.
- Image area has `aria-label` with product name.
- Star rating group has `aria-label="4.8 out of 5 stars"`.
- CTA button is a semantic `<button>`.

## 14. Prototype Acceptance Criteria
- [ ] Gradient hero and product icon display correctly.
- [ ] Title, price, strikethrough old price visible.
- [ ] Star rating renders with correct fill/half icons.
- [ ] Description card and info grid render correctly.
- [ ] Loading / Not Found / Error states toggle correctly.
- [ ] Add to cart button shows correct icon and label.
