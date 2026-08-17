# Feature Specification — Home

**Project:** Flutter Spec-Driven Development Project  
**Feature:** Home / Product Listing  
**Version:** 1.0  
**Platform:** Flutter / Dart  
**Architecture:** Clean Architecture + BLoC  
**Design System:** Latest Flutter Material 3  
**Theme Modes:** Light + Dark + System  
**Primary Color:** Electric Blue

---

## 1. Purpose

This document defines the Home feature before Flutter implementation begins.

The assignment requires a Home screen that displays a list of items retrieved from an API, and allows the user to select an item to navigate to a Detail screen. The assignment permits either **Products** or **Recipes**. fileciteturn1file0L21-L25

### Decision

**Products are selected for this implementation.**

The Home feature will therefore consume the DummyJSON Products API.

DummyJSON currently documents:

- `GET /products` for retrieving products.
- Pagination through `limit` and `skip`.
- Product search.
- Product sorting.
- Individual product retrieval through `/products/:id`. citeturn0search0

This gives the project a straightforward list → detail flow while providing enough data to demonstrate Clean Architecture, BLoC, networking, loading, error and navigation behavior.

---

## 2. Scope

The Home feature includes:

- Authenticated Home screen.
- Product listing.
- Product image.
- Product title.
- Product category.
- Product price.
- Product rating where appropriate.
- Loading state.
- Empty state.
- Error state.
- Retry behavior.
- Pull-to-refresh.
- Product selection.
- Navigation to Product Detail.

The initial Home feature does **not** include:

- Cart management.
- Product creation.
- Product editing.
- Product deletion.
- Checkout.
- Favorites.
- Advanced filtering.
- Search.

Those can be added as separate specifications.

---

## 3. Authentication Requirement

Home is an authenticated feature.

The application should only expose the Home route after successful authentication.

The DummyJSON documentation supports authorization of resources using an access token in the Bearer header. citeturn0search1

Expected request pattern:

```http
Authorization: Bearer <access-token>
```

The access token must not be passed through UI widgets.

---

## 4. API

### 4.1 Base URL

```text
https://dummyjson.com/
```

### 4.2 List Products

```http
GET /products
```

Full endpoint:

```text
https://dummyjson.com/products
```

DummyJSON currently returns a paginated product response containing:

```text
products
total
skip
limit
```

The default response contains 30 products, and `limit`/`skip` can be used for pagination. citeturn0search0

### 4.3 Example Request

```http
GET /products?limit=20&skip=0
```

### 4.4 Example Response Structure

```json
{
  "products": [
    {
      "id": 1,
      "title": "Essence Mascara Lash Princess",
      "description": "...",
      "category": "beauty",
      "price": 9.99,
      "discountPercentage": 7.17,
      "rating": 4.94,
      "stock": 5,
      "brand": "Essence",
      "thumbnail": "...",
      "images": []
    }
  ],
  "total": 194,
  "skip": 0,
  "limit": 30
}
```

The exact API response should be mapped through a Data-layer model rather than exposed directly to the presentation layer. citeturn0search0

---

## 5. Product List

The Home screen should display products in a visually scannable Material 3 layout.

Recommended initial layout:

```text
┌────────────────────────────────┐
│ Products                       │
│                                │
│ ┌────────────────────────────┐ │
│ │ [Image]  Product Title     │ │
│ │          Category          │ │
│ │          ₹/$ 9.99  ★ 4.9  │ │
│ └────────────────────────────┘ │
│                                │
│ ┌────────────────────────────┐ │
│ │ [Image]  Product Title     │ │
│ │          Category          │ │
│ │          ₹/$ 19.99 ★ 4.6  │ │
│ └────────────────────────────┘ │
│                                │
└────────────────────────────────┘
```

The exact visual layout will be validated through the HTML prototype.

---

## 6. Product Card

Each product card should display only the information necessary for quick scanning.

### Required

- Product image/thumbnail.
- Product title.
- Category.
- Price.
- Rating where available.

### Optional

- Discount percentage.
- Availability status.

The card should not display the full product description.

The complete product information belongs on the Detail screen.

---

## 7. Product Image

The product thumbnail/image should:

- Maintain an appropriate aspect ratio.
- Display a loading placeholder while loading.
- Display a fallback when the image cannot be loaded.
- Avoid causing layout shifts.
- Support both light and dark themes.

Image URLs are supplied by the DummyJSON API. citeturn0search0

The implementation should avoid allowing an invalid remote image URL to break the entire list.

---

## 8. Product Price

The product price should be displayed prominently enough to scan quickly.

The API currently provides `price` as a numeric value. citeturn0search0

Formatting should be centralized rather than implemented independently inside every card.

Currency formatting must not be assumed to be tied to the user's actual locale unless that becomes an approved requirement.

---

## 9. Rating

Where the API provides a rating, it may be displayed using:

- Numeric rating.
- Material icon/star indicator.

Example:

```text
★ 4.94
```

The star icon must not be the only representation of the rating because color/iconography alone should not communicate important information.

---

## 10. Product Selection

Tapping a product card should navigate to:

```text
/product/:id
```

Flow:

```text
Home
  ↓
Tap Product
  ↓
Product ID
  ↓
Product Detail
```

The selected product ID must be passed through navigation rather than passing the complete API model through the UI route.

---

## 11. Loading State

When Home initially loads:

```text
HomeInitial
    ↓
HomeLoading
    ↓
API request
```

The UI should display a Material 3-compatible loading state.

Recommended initial implementation:

- Skeleton/placeholder cards if practical.
- Otherwise a centered progress indicator.

The final choice will be validated in the HTML prototype.

### Pagination Loading

When loading another page:

```text
Existing products
       +
Additional loading indicator
       ↓
Additional products
```

Existing products should remain visible while the next page loads.

---

## 12. Empty State

If the API returns no products:

```text
No products found

There are currently no products to display.

        [ Retry ]
```

The empty state must not be confused with an API failure.

---

## 13. Error State

If the initial request fails:

```text
Unable to load products

Something went wrong while loading the products.

        [ Retry ]
```

The error message must be user-friendly.

Technical exceptions must not be displayed.

---

## 14. Retry

Retry must trigger a new request.

For an initial loading failure:

```text
Failure
  ↓
Tap Retry
  ↓
Loading
  ↓
Request
```

If retry fails again, the error state remains available.

---

## 15. Pull-to-Refresh

The Home screen should support pull-to-refresh.

Expected behavior:

```text
User pulls down
      ↓
Refresh indicator
      ↓
Fetch latest first page
      ↓
Replace current list
```

Pull-to-refresh should not create duplicate simultaneous requests.

If the refresh request fails, the existing successfully loaded content should remain visible where practical, with an appropriate error feedback mechanism.

---

## 16. Pagination

DummyJSON supports `limit` and `skip` query parameters. citeturn0search0

The Home implementation should use pagination rather than requesting an unnecessarily large dataset.

Initial request:

```text
limit = 20
skip = 0
```

Next page:

```text
limit = 20
skip = 20
```

Next:

```text
limit = 20
skip = 40
```

The exact page size may be adjusted during performance testing.

### Pagination Rules

- Do not request the next page if all products have already been loaded.
- Do not issue duplicate next-page requests.
- Keep existing products visible during pagination.
- Append newly received products.
- Handle pagination failures without discarding already loaded products.

---

## 17. BLoC Specification

The Home feature will use BLoC.

### 17.1 Events

Initial events:

```text
ProductsRequested
ProductsRefreshed
ProductsNextPageRequested
```

### 17.2 States

Conceptual state model:

```text
HomeInitial
HomeLoading
HomeSuccess
HomeEmpty
HomeFailure
HomeRefreshing
HomePaginationLoading
HomePaginationFailure
```

The final state representation may consolidate some states if it provides clearer state management.

### 17.3 Successful Initial Load

```text
HomeInitial
    ↓ ProductsRequested
HomeLoading
    ↓ API success
HomeSuccess(products)
```

### 17.4 Empty Response

```text
HomeInitial
    ↓ ProductsRequested
HomeLoading
    ↓ API success with zero items
HomeEmpty
```

### 17.5 Initial Failure

```text
HomeInitial
    ↓ ProductsRequested
HomeLoading
    ↓ API failure
HomeFailure
```

### 17.6 Pagination

```text
HomeSuccess
    ↓ ProductsNextPageRequested
HomePaginationLoading
    ↓ API success
HomeSuccess(updatedProducts)
```

### 17.7 Pagination Failure

```text
HomeSuccess
    ↓ ProductsNextPageRequested
HomePaginationLoading
    ↓ API failure
HomePaginationFailure
    ↓
Existing products remain visible
```

---

## 18. Clean Architecture Mapping

The Home feature should follow:

```text
features/products/
├── data/
│   ├── datasources/
│   │   └── product_remote_data_source.dart
│   ├── models/
│   │   ├── product_model.dart
│   │   └── products_response_model.dart
│   └── repositories/
│       └── product_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── product.dart
│   │   └── products_page.dart
│   ├── repositories/
│   │   └── product_repository.dart
│   └── usecases/
│       └── get_products.dart
│
└── presentation/
    ├── bloc/
    │   ├── products_bloc.dart
    │   ├── products_event.dart
    │   └── products_state.dart
    ├── pages/
    │   └── home_page.dart
    └── widgets/
        ├── product_card.dart
        ├── product_image.dart
        ├── product_list.dart
        └── product_list_error.dart
```

The Detail feature should have its own feature specification and implementation rather than placing detail-specific logic inside Home.

---

## 19. Data Flow

```text
HomePage
    ↓
ProductsBloc
    ↓
GetProducts
    ↓
ProductRepository
    ↓
ProductRepositoryImpl
    ↓
ProductRemoteDataSource
    ↓
Dio
    ↓
GET /products
    ↓
ProductsResponseModel
    ↓
Product Entity
    ↓
ProductsBloc
    ↓
HomeSuccess
    ↓
Product List
```

---

## 20. Repository Contract

The Domain layer should expose an abstraction similar to:

```dart
abstract class ProductRepository {
  Future<Result<ProductsPage>> getProducts({
    required int limit,
    required int skip,
  });
}
```

The exact `Result`/failure implementation will be finalized during engineering implementation.

The Domain layer must not depend on Dio.

---

## 21. Product Entity

The Domain entity should contain only information required by application behavior.

Initial fields:

```text
id
title
description
category
price
discountPercentage
rating
stock
brand
thumbnail
images
```

The entity should not expose Data-layer implementation details.

---

## 22. Search and Filtering

Search is **out of scope for the first Home implementation**.

DummyJSON currently provides product search through:

```text
GET /products/search?q=phone
```

and category filtering through category endpoints. citeturn0search0

These capabilities may be introduced later through separate specifications.

Do not add search merely because the API supports it.

---

## 23. Material 3 Requirements

The Home feature must use the latest available Flutter Material 3 components and the application theme.

Use:

```dart
Theme.of(context).colorScheme
```

for colors.

Primary interactive elements should use:

```dart
colorScheme.primary
```

Cards, surfaces, borders and text should use semantic Material 3 roles.

The screen must work correctly in:

```text
Light
Dark
System
```

No Home widget should hard-code colors that only work in one theme.

---

## 24. Accessibility

The Home feature must:

- Provide semantic labels for product images where useful.
- Ensure product titles remain readable with text scaling.
- Maintain sufficient contrast.
- Avoid using color alone to communicate rating or availability.
- Provide accessible interaction targets.
- Ensure cards are keyboard/focus accessible where the platform supports it.
- Avoid excessive information density.

---

## 25. Performance Requirements

The Home screen should be implemented using a lazy list.

Recommended Flutter implementation:

```text
ListView.builder
```

or an equivalent lazy Material 3-compatible list/grid.

Requirements:

- Do not render all items eagerly.
- Avoid unnecessary BLoC rebuilds.
- Keep image loading efficient.
- Avoid duplicate network requests.
- Avoid rebuilding unrelated list items when a single item changes.

---

## 26. Edge Cases

The feature must handle:

- API returns zero products.
- API returns fewer products than the requested page size.
- API returns exactly one page.
- API returns malformed product data.
- Network unavailable.
- Network timeout.
- Server error.
- Image URL unavailable.
- Duplicate pagination requests.
- Pagination failure.
- Refresh while pagination is active.
- User taps a product while the list is loading.
- User leaves Home while a request is active.
- Access token is missing/expired.

---

## 27. Acceptance Criteria

### Home

- [ ] Authenticated user can access Home.
- [ ] Products are retrieved from DummyJSON.
- [ ] Product cards are displayed.
- [ ] Product image is displayed where available.
- [ ] Product title is displayed.
- [ ] Product category is displayed.
- [ ] Product price is displayed.
- [ ] Rating is displayed where available.
- [ ] UI follows approved Material 3 design.
- [ ] Light mode works.
- [ ] Dark mode works.
- [ ] System theme works.

### Loading

- [ ] Initial loading state is displayed.
- [ ] Pagination loading does not remove existing products.
- [ ] Duplicate loading requests are prevented.

### Empty/Error

- [ ] Empty response displays an empty state.
- [ ] Initial API failure displays an error state.
- [ ] Retry is available.
- [ ] Pagination failure does not discard existing products.

### Refresh/Pagination

- [ ] Pull-to-refresh is supported.
- [ ] Refresh reloads the first page.
- [ ] Pagination uses `limit` and `skip`.
- [ ] Pagination stops when all products are loaded.

### Navigation

- [ ] Tapping a product opens Product Detail.
- [ ] Product ID is passed to the Detail route.
- [ ] Home does not contain Product Detail business logic.

### Architecture

- [ ] Home uses BLoC.
- [ ] BLoC calls the appropriate use case.
- [ ] Use case depends on the repository abstraction.
- [ ] Repository implementation belongs to Data.
- [ ] API access is isolated in the Data layer.
- [ ] UI does not call Dio directly.

---

## 28. SDD Completion Checklist

Before implementation:

- [ ] Home specification reviewed.
- [ ] Products decision approved.
- [ ] API contract reviewed.
- [ ] Static HTML Home prototype created.
- [ ] Product card design validated.
- [ ] Loading state validated.
- [ ] Empty state validated.
- [ ] Error state validated.
- [ ] Pagination behavior validated.
- [ ] Pull-to-refresh behavior validated.
- [ ] Light theme validated.
- [ ] Dark theme validated.
- [ ] Responsive behavior validated.

After approval:

- [ ] Flutter Home UI implemented.
- [ ] Products BLoC implemented.
- [ ] Product use case implemented.
- [ ] Product repository implemented.
- [ ] DummyJSON API integration implemented.
- [ ] Pagination implemented.
- [ ] Pull-to-refresh implemented.
- [ ] Error handling implemented.
- [ ] Unit tests implemented.
- [ ] BLoC tests implemented.
- [ ] Widget tests implemented.
- [ ] Documentation updated.

---

## 29. Open Decisions

| Decision | Status |
|---|---|
| Resource | **Products — selected** |
| Initial page size | Proposed: 20 |
| Search | Out of scope |
| Filtering | Out of scope |
| Sorting | Out of scope |
| Product grid vs list | To be finalized in HTML prototype |
| Persistent authentication | Defined separately in Authentication feature |
| Product Detail behavior | Next feature specification |

No additional Home functionality should be implemented without updating this specification.
