# Layout & Overflow Prevention Rules

These rules define the standards for preventing and fixing layout overflows in the Shop Ease project.

## 1. General Principles
- **Constraints First:** Always remember "Constraints go down. Sizes go up. Parent sets position."
- **Flexible by Default:** Use `Flexible` or `Expanded` for any widget that contains dynamic text or variable-sized content inside a `Row` or `Column`.
- **Overflow Protection:** Use `maxLines` and `TextOverflow.ellipsis` for `Text` widgets that might receive long strings.

## 2. Preventing RenderFlex Overflows
- **In Columns:** If a `Column` is inside a widget with a fixed height (like a `SizedBox` or a `GridView` item with a fixed aspect ratio), ensure the children don't exceed that height. Wrap vertical lists in `Expanded`.
- **In Rows:** Wrap `Text` or other variable-width widgets in `Expanded` or `Flexible` to prevent horizontal overflows.
- **Scroll as Fallback:** If content visibility is more important than fixed sizing, wrap the `Column` in a `SingleChildScrollView`.

## 3. Grid & Card Standards
- **Safe Aspect Ratios:** When using `SliverGridDelegateWithFixedCrossAxisCount` or `SliverGridDelegateWithMaxCrossAxisExtent`, ensure the `childAspectRatio` provides enough height for the content, especially for different text scales.
- **Intrinsic Sizing Avoidance:** Avoid `IntrinsicHeight` or `IntrinsicWidth` unless absolutely necessary, as they are expensive. Prefer `CustomMultiChildLayout` or better constraint management.

## 4. Debugging Workflow
1. **Locate:** Use the error message to find the exact line causing the overflow.
2. **Inspect:** Check the parent's constraints. Is it a fixed height?
3. **Apply Fix:**
   - Wrap the offending child in `Expanded` or `Flexible`.
   - Add `TextOverflow.ellipsis` to text.
   - Adjust parent constraints or aspect ratios.
4. **Verify:** Run the app and test with large text scales (Accessibility settings).
