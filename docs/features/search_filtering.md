# Feature Specification — Search & Filtering

**Project:** Shop Ease  
**Feature:** Product Search & Category Filtering  
**Version:** 1.0  
**Status:** Implementation Phase  

---

## 1. Purpose
Enhance the Product Listing (Home) experience by allowing users to search for specific products by title and filter items by category.

## 2. Scope
- **Text Search:** Real-time search against the DummyJSON `/products/search` endpoint.
- **Category Filtering:** Ability to select a category and view products belonging to it.
- **Combined Logic:** Supporting search within a selected category (if supported by API) or switching between search/filter modes.
- **Loading & Empty States:** Specific feedback for "No search results".

## 3. API Integration
### 3.1 Search Endpoint
```http
GET https://dummyjson.com/products/search?q=phone
```

### 3.2 Category List
```http
GET https://dummyjson.com/products/categories
```

### 3.3 Products by Category
```http
GET https://dummyjson.com/products/category/smartphones
```

## 4. User Flow
1. **Search:** User types in the search bar -> BLoC emits `loading` -> Results displayed.
2. **Filter:** User taps a category chip -> BLoC fetches category-specific products -> Results displayed.
3. **Reset:** Clearing search or tapping "All" category resets to the full product list.

## 5. BLoC Updates (`ProductsBloc`)
### 5.1 Events
- `SearchQueryChanged(String query)`
- `CategorySelected(String category)`
- `SearchCleared()`

### 5.2 States
- Updated `ProductsState` to include `currentQuery` and `currentCategory`.

## 6. UI Requirements (Home Screen)
- **Search Bar:** Material 3 SearchBar or Outlined TextField at the top.
- **Category Chips:** Horizontal scrolling list of `FilterChip` or `ChoiceChip`.
- **Empty State:** "No results found for '<query>'" with a clear action.

## 7. Acceptance Criteria
- [ ] Searching for "iPhone" returns relevant results.
- [ ] Tapping "Electronics" category filters the list correctly.
- [ ] Clearing search returns to the default listing.
- [ ] Loading indicators are shown during search/filter operations.
- [ ] The grid layout remains responsive and overflow-free.
