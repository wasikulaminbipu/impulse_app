---
name: project-architecture
description: Use when determining file placement, structuring Clean Architecture layers (presentation, domain, data), enforcing architectural boundaries, and scaling Flutter application codebases.
---

# Project Architecture & Code Organization Guidelines

This document outlines the architectural standards, code placement patterns, state management conventions, offline persistence strategies, and modularization guidelines for building scalable, maintainable, and testable mobile & web applications. Inspired by **Flutter Best Practices**, **Android Official App Architecture Guide**, and **Clean Architecture & Domain-Driven Design (DDD)**, this codebase enforces strict separation of concerns across presentation, domain, and data components.

---

## 1. Core Architectural Principles

### A. Separation of Concerns & Clean Layer Boundaries
Every component must reside in its designated layer with unambiguous responsibilities:

* **Presentation Layer**: UI rendering (Flutter widgets), Material 3 design tokens, responsive layout scaffolds, tactile micro-animations, user gesture handling, and view-state management (Riverpod Controllers / Notifiers). Zero direct database or network dependencies.
* **Domain Layer**: Core domain models, value objects, domain entities, use cases / business operations, domain validation, and repository interface contracts. **Framework-agnostic** (zero dependency on Flutter UI widgets or specific database implementations like Drift).
* **Data Layer**: Data persistence (Drift tables, DAOs, SQLite FTS search tables, Web Workers), remote network clients, cache engines, third-party SDK adapters, and concrete repository implementations (`RepositoryImpl`).

### B. Inward Dependency Flow
Dependencies MUST strictly flow inward toward the domain layer:

```text
┌────────────────────────────────┐         ┌──────────────────────────────┐
│       Presentation Layer       │         │          Data Layer          │
│   (Widgets / Controllers)      │         │   (DAOs / RepositoriesImpl)  │
└───────────────┬────────────────┘         └──────────────┬───────────────┘
                │                                         │
                │        ┌──────────────────────┐         │
                └───────►│     Domain Layer     │◄────────┘
                         │ (Entities / Contracts)│
                         └──────────────────────┘
```

* **Presentation** depends on **Domain** interfaces and entities.
* **Data** depends on **Domain** (implements repository contract interfaces).
* **Domain** depends on **nothing** external (pure Dart logic).

### C. Unidirectional Data Flow (UDF)
1. **User Action / UI Event**: User interacts with a widget (e.g., searches, taps favorite button, requests next page).
2. **Controller Execution**: Riverpod `Notifier` / `AsyncNotifier` intercepts the action.
3. **Domain / Data Delegation**: Controller invokes a Use Case or Repository method.
4. **Data Stream / Result**: Repository executes DAO / FTS queries or HTTP requests and returns immutable Freezed models / entities or Failure abstractions.
5. **State Update**: Controller updates `AsyncValue<T>` state cleanly using `.copyWith()` or immutable pattern.
6. **Reactive Render**: UI rebuilds predictably via `ref.watch()`.

---

## 2. Code Placement & Directory Structure Framework

### Layout Options & Standards

#### Feature-First Layout (Target Architecture for Scale)
Recommended for expanding multi-domain projects where components are organized by functional domain feature:

```text
lib/
├── core/                         # Cross-cutting concerns & shared infrastructure
│   ├── database/                 # Core Drift database connection, isolates & WebWorker
│   ├── error/                    # Domain failures, exceptions, error mappers
│   ├── network/                  # HTTP clients, interceptors, API tokens
│   ├── router/                   # GoRouter / AppRouter configuration & guards
│   ├── security/                 # Encrypted storage adapters (FlutterSecureStorage)
│   ├── theme/                    # AppTheme, design system tokens, typography
│   └── utils/                    # Common formatters, extensions, helpers
│
├── features/
│   ├── products/
│   │   ├── data/
│   │   │   ├── datasources/      # ProductLocalDao (Drift), ProductFtsIndex
│   │   │   ├── models/           # ProductDto (Freezed JSON/DB DTOs)
│   │   │   └── repositories/     # ProductRepositoryImpl.dart
│   │   ├── domain/
│   │   │   ├── entities/         # Product.dart (Domain Entity)
│   │   │   ├── repositories/     # ProductRepository.dart (Abstract contract)
│   │   │   └── usecases/         # SearchProductsUseCase.dart, FilterProductsUseCase.dart
│   │   └── presentation/
│   │       ├── controllers/      # products_controller.dart (Riverpod Notifier)
│   │       ├── screens/          # products_screen.dart, product_details_screen.dart
│   │       └── widgets/          # product_card.dart, product_search_bar.dart
│   │
│   └── stakeholders/
│       ├── data/                 # DistributorDao, ManufacturerDao
│       ├── domain/               # Stakeholder domain entities & contracts
│       └── presentation/         # Stakeholder screens & controllers
│
└── main.dart                     # App bootstrap & ProviderScope initialization
```

#### Layer-First / Hybrid Structure (Legacy & Focused Apps)
When maintaining a Layer-First layout, strictly enforce sub-folder separation to prevent file clutter:

```text
lib/
├── data/                         # Database schema, DAOs, Drift queries, repositories
├── domain/                       # Core contracts, use cases, domain entities
├── models/                       # Freezed data models, value objects, state DTOs
├── providers/                    # Riverpod providers, Notifier classes, paginated state
├── screens/                      # Page-level route widgets (Scaffold wrappers)
├── theme/                        # Design tokens, Material 3 styling
├── utils/                        # Analytics, share services, formatters
└── widgets/                      # Atomic & reusable UI components
```

---

## 3. Technology Stack Integration Architecture

### A. Riverpod State Management & Performance Standards
* **Code Generation**: Prefer `@riverpod` annotated functional and class providers (`KeepAlive`, `AutoDispose`).
* **Async Safety**: Represent UI async state using `AsyncValue<T>` (leveraging `.when()`, `.maybeWhen()`, or `.copyWithPrevious()`).
* **Selective Rebuilding**: Use `ref.watch(provider.select((s) => s.specificField))` in fine-grained widgets to avoid unnecessary rebuilds of entire widget subtrees.
* **Pagination Pattern**: Use structured pagination objects (`PaginatedState<T>`) for search results and list views to separate items, cursor/offset, page status, and error state cleanly.

```dart
// Domain Repository Contract (lib/domain/repositories/product_repository.dart)
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> searchProducts(String query, {required int limit, required int offset});
}

// Data Layer Binding (lib/data/repositories/product_repository_impl.dart)
@riverpod
ProductRepository productRepository(Ref ref) {
  final dao = ref.watch(productDaoProvider);
  return ProductRepositoryImpl(dao);
}

// Presentation Controller (lib/providers/products_controller.dart)
@riverpod
class ProductsController extends _$ProductsController {
  @override
  FutureOr<PaginatedState<Product>> build() async {
    return _fetchInitial();
  }

  Future<void> fetchNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.hasReachedMax || currentState.isLoadingMore) return;

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.searchProducts(
      currentState.query,
      limit: currentState.pageSize,
      offset: currentState.items.length,
    );

    result.fold(
      (failure) => state = AsyncValue.data(currentState.copyWith(isLoadingMore: false, error: failure.message)),
      (newItems) => state = AsyncValue.data(currentState.copyWith(
        items: [...currentState.items, ...newItems],
        hasReachedMax: newItems.length < currentState.pageSize,
        isLoadingMore: false,
      )),
    );
  }
}
```

### B. Local Persistence, Off-Main-Thread Isolates & Web Workers
* **DAO Isolation**: DAOs (`@DriftAccessor`) must remain encapsulated in `data/datasources/` or `features/*/data/`.
* **Isolate Execution**: Long-running SQLite index computations and FTS tokenization MUST run off the main UI thread via Drift Isolate or Background Workers (`DriftIsolate` / `WasmDatabase` on Web).
* **FTS Search Integration**: Keep SQLite FTS5 virtual tables and raw search queries inside DAOs. Map FTS search hits to domain models before exposing data to Riverpod providers.
* **Database Transactions**: Execute multi-table updates (e.g., inserting products alongside categories or ingredients) inside `db.transaction()` blocks in the DAO to guarantee ACID integrity.

```dart
@DriftAccessor(tables: [Products, ProductFts])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(AppDatabase db) : super(db);

  /// Executes Hybrid Reciprocal Rank Fusion (RRF) search across FTS and Trigram indexes
  Future<List<ProductEntry>> searchProductsHybrid(String query, {int limit = 20, int offset = 0}) async {
    return customSelect(
      'SELECT p.* FROM products p JOIN product_fts fts ON p.id = fts.rowid WHERE product_fts MATCH ? LIMIT ? OFFSET ?',
      readsFrom: {products, productFts},
      variables: [Variable.withString(query), Variable.withInt(limit), Variable.withInt(offset)],
    ).map((row) => Products.map(row.data)).get();
  }
}
```

### C. Offline-First Sync & Cache Architecture
* **Repository Strategy**: Repositories act as the single source of truth, balancing local database access with remote APIs.
* **Cache Read-Through**: Read from local Drift storage first for instantaneous UI rendering, sync with remote APIs in the background, and emit state updates via reactive streams (`watch()`).

```dart
// Repository implementation enforcing Cache Read-Through
class ProductRepositoryImpl implements ProductRepository {
  final ProductDao _localDao;
  final ProductRemoteApi _remoteApi;

  ProductRepositoryImpl(this._localDao, this._remoteApi);

  @override
  Stream<List<Product>> watchProducts() {
    // 1. Return local database stream immediately
    return _localDao.watchAllProducts().map((entries) => entries.map((e) => e.toDomain()).toList());
  }

  Future<void> refreshProducts() async {
    // 2. Fetch remote update and upsert to local DB inside transaction
    final remoteDtos = await _remoteApi.fetchProducts();
    await _localDao.upsertProductsTransaction(remoteDtos);
  }
}
```

### D. Security & Encrypted Storage Architecture
* Never store auth tokens, API keys, or private user credentials in raw SQLite database tables or `SharedPreferences`.
* Wrap secure storage operations behind a `SecureStorageService` interface in `core/security/` backed by platform keychain services (`FlutterSecureStorage` / `KeyStore`).

### E. Error & Failure Domain Modeling
* **Domain Failures**: Define functional domain failures using a sealed class hierarchy in `core/error/failures.dart`.
* **Mapping**: Data layer catches low-level SQLite (`SqliteException`) or Network exceptions and maps them into pure domain `Failure` objects before returning them to controllers.

```dart
// core/error/failures.dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
```

### F. Design System & Material 3 Token Architecture
* **Token Isolation**: Color schemes, high-craft typography, elevation, glassmorphism blurs, and border radii must be centralized in `core/theme/` or `lib/theme/`.
* **Zero Hardcoded Design Magic Numbers**: UI widgets must reference `Theme.of(context)` design tokens or defined constant tokens (`AppColors`, `AppTypography`, `AppSpacing`).
* **WCAG 2.2 AA Contrast**: Ensure minimum contrast ratios across light and dark theme palettes.

### G. Testing & Test Double Architecture
Enforce strict test boundaries corresponding to app layers:

* **Domain Unit Tests** (`test/domain/`): Test pure Dart use cases, business validation, and domain models using standard Dart unit test runners (zero Flutter engine requirement).
* **Data Integration Tests** (`test/data/`): Test Drift DAOs, tables, and search indexes using in-memory SQLite instances (`NativeDatabase.memory()`).
* **Presentation Widget & Controller Tests** (`test/presentation/`): Test UI screens and controllers using `WidgetTester` and Riverpod `ProviderScope` overrides to inject mock repositories.

```dart
// Example Presentation Test with Provider Override
testWidgets('ProductsScreen displays loaded products cleanly', (tester) async {
  final mockRepository = MockProductRepository();
  when(() => mockRepository.searchProducts(any())).thenAnswer((_) async => Right(sampleProducts));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        productRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: const MaterialApp(home: ProductsScreen()),
    ),
  );

  expect(find.byType(ProductCard), findsNWidgets(sampleProducts.length));
});
```

### H. Performance Telemetry & Analytics Architecture
* Wrap search query telemetry, startup time profiling, and crash reporting inside abstract logger adapters in `core/analytics/`.
* Presentation and Data components invoke abstract analytics interfaces; never couple UI directly to third-party SDK implementations (e.g., Firebase Analytics or Sentry).

### I. Deep Linking & Dynamic Router Architecture
* Centralize navigation logic using GoRouter or typed routes in `core/router/`.
* **Route Parameter Parsing**: Pass immutable primitives or UUID strings in route paths (`/product/:id`). Let the target screen's Riverpod provider resolve the domain entity via repository lookup.

---

## 4. File Placement Decision Matrix

When adding or refactoring code, consult this matrix:

| Task / Component | Layer | Correct Directory Path |
| :--- | :--- | :--- |
| **Full Page Route Screen Scaffold** | Presentation | `lib/screens/` or `features/<feature>/presentation/screens/` |
| **Reusable UI Card, Dialog, or Button** | Presentation | `lib/widgets/` or `features/<feature>/presentation/widgets/` |
| **Riverpod Provider / State Controller** | Presentation | `lib/providers/` or `features/<feature>/presentation/controllers/` |
| **Freezed Domain Entity / Value Object** | Domain | `lib/models/` or `features/<feature>/domain/entities/` |
| **Repository Contract (Abstract Interface)** | Domain | `lib/domain/repositories/` or `features/<feature>/domain/repositories/` |
| **Use Case / Single-Operation Business Logic** | Domain | `lib/domain/usecases/` or `features/<feature>/domain/usecases/` |
| **Drift DB Accessor / Table Schema / DAO** | Data | `lib/data/` or `features/<feature>/data/datasources/` |
| **Concrete Repository Implementation** | Data | `lib/data/repositories/` or `features/<feature>/data/repositories/` |
| **App Theme, Colors, Typography Tokens** | Core / Theme | `lib/theme/` or `core/theme/` |
| **Analytics, Native Bridges, Formatters** | Core / Services | `lib/utils/` or `core/services/` |

---

## 5. Step-by-Step Feature Migration Guide (Layer-First ➔ Feature-First)

When refactoring a legacy or monolithic Layer-First component into a modular Feature-First architecture, execute the following steps systematically:

```text
Step 1: Identify Domain Feature Boundaries (e.g., 'products')
Step 2: Create feature target directories (`lib/features/products/{data,domain,presentation}`)
Step 3: Move entities and repository interfaces to `features/products/domain/`
Step 4: Move DAOs, Drift table queries, and DTOs to `features/products/data/`
Step 5: Move Riverpod Notifiers and UI widgets to `features/products/presentation/`
Step 6: Update internal imports using relative pathing within feature package
Step 7: Run `flutter analyze` to verify zero layer violations or import leaks
```

---

## 6. Architectural Quality & CI/CD Verification Checklist

- [ ] **Zero UI Leakage**: Domain layer contains ZERO imports of `package:flutter/material.dart`, `BuildContext`, or database engine packages (`drift`).
- [ ] **No Direct DAO Calls in UI**: UI screens and widgets interact strictly through Riverpod providers or Use Cases.
- [ ] **Off-Main-Thread Heavy Work**: Database initialization, FTS re-indexing, and large JSON parsing are offloaded to Isolates/WebWorkers.
- [ ] **Selective Rebuilds**: Large widget trees utilize `ref.watch(provider.select(...))` to minimize unnecessary build ticks.
- [ ] **Error Safety**: Data layer exceptions mapped into domain `Failure` types; UI handles loading, error, and empty states cleanly via `AsyncValue`.
- [ ] **Analyzer Compliance**: Code passes `flutter analyze` with 0 issues after any structural or logic change.
- [ ] **Testability Boundaries**:
  - **Domain**: 100% unit-testable with pure Dart tests (no Flutter test framework required).
  - **Data**: DAOs testable using in-memory Drift SQLite instances (`NativeDatabase.memory()`).
  - **Presentation**: Controllers and screens testable using `ProviderScope` overrides and widget tester.
- [ ] **Updated Workspace Tracking**: Project map updated in `.agents/project_map.json` when adding or moving modules.


