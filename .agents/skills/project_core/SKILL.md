---
name: project-core
description: Core technical implementation patterns for Shop Ease (Clean Architecture, BLoC, networking, etc.)
---

# Tech Stack Skills & Implementation Patterns

## 1. Clean Architecture Patterns
- **Entities:** Plain Dart classes representing business data. No annotations, no JSON logic.
- **Use Cases:** Classes with a single `call()` method. Orchestrate repositories.
- **Models:** Data layer classes with `fromJson`/`toJson` (use `json_serializable`).
- **Mappers:** Extensions or methods to convert `Model` -> `Entity` and vice versa.

## 2. BLoC (State Management)
- **Events:** Sealed classes representing intent (e.g., `LoginSubmitted`).
- **States:** Sealed classes representing UI state (e.g., `LoginLoading`, `LoginSuccess`).
- **Pattern:** `on<Event>((event, emit) async { ... })`.
- **Naming:** `<Feature>Bloc`, `<Feature>Event`, `<Feature>State`.

## 3. Networking (Dio)
- **Client:** Centralized `DioClient` in `core/network/`.
- **Interceptors:** Handle logging, headers, and global error codes (401).
- **DummyJSON Integration:** Base URL `https://dummyjson.com/`.

## 4. Navigation (go_router)
- **Centralized Router:** `AppRouter` class.
- **Route Guards:** Logic in `redirect` for authentication checks.
- **Typed Routes:** Prefer named routes or type-safe routes if configured.

## 5. Dependency Injection (get_it)
- **Setup:** `injection.dart` with a `configureDependencies()` function.
- **Scopes:** Use `registerLazySingleton` for Repositories/DataSources, `registerFactory` for BLoCs.

## 6. Theme & Design (Material 3)
- **Seed Color:** `0xFF2563EB` (Electric Blue).
- **Extension:** Use `ThemeExtension` for custom spacing or specific brand colors not in `ColorScheme`.
- **Semantics:** Use `Theme.of(context).colorScheme` for consistent styling.
