---
name: riverpod-state-management
description: Use when creating or modifying state management, providers, or riverpod architectures in this Flutter project.
---

# Riverpod State Management (Riverpod 3.x & Annotation 4.x)

This project uses `flutter_riverpod: ^3.3.2` and `riverpod_annotation: ^4.0.3` for reactive state management. Follow these standard rules and patterns for Riverpod development.

---

## 1. Core Principles & Philosophy
- **Always Use Code Generation**: Use `@riverpod` or `@Riverpod(...)` annotations instead of manually instantiating legacy `Provider`, `FutureProvider`, `StreamProvider`, or `NotifierProvider`.
- **Embrace `Notifier` & `AsyncNotifier`**: Use `Notifier` for synchronous state and `AsyncNotifier` for asynchronous state. Avoid legacy patterns such as `StateNotifierProvider`, `ChangeNotifierProvider`, or `StateProvider`.
- **Functional vs. Class-Based Providers**:
  - **Functional Provider**: Use for read-only/computed or fetch-only state (returns a value or `Future`/`Stream`).
  - **Class-Based Provider (`Notifier` / `AsyncNotifier`)**: Use when state needs mutation or contains action methods.

---

## 2. Code Generation Setup & Structure
- Every provider file must include the part file directive:
  ```dart
  import 'package:riverpod_annotation/riverpod_annotation.dart';

  part 'my_provider.g.dart';
  ```
- **Organization**: Place providers in `lib/providers/` or inside their respective feature directory (e.g., `lib/features/catalog/providers/`).
- **Generation Command**: Run build_runner whenever creating or updating annotated providers:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

---

## 3. Provider Implementation Patterns

### Synchronous State (`Notifier`)
```dart
@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier {
  @override
  String build() => ''; // Initial state

  void setQuery(String query) => state = query.trim();
  void clear() => state = '';
}
```

### Asynchronous State (`AsyncNotifier`)
```dart
@riverpod
class ProductsController extends _$ProductsController {
  @override
  FutureOr<List<Product>> build() async {
    final repository = ref.watch(productRepositoryProvider);
    return repository.getProducts();
  }

  Future<void> toggleFavorite(int productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(productRepositoryProvider);
      await repository.toggleFavorite(productId);
      return repository.getProducts();
    });
  }
}
```

### Functional Provider (Read-Only / Computed)
```dart
@riverpod
Future<List<Product>> filteredProducts(Ref ref, String query) async {
  final repository = ref.watch(productRepositoryProvider);
  if (query.isEmpty) {
    return repository.getProducts();
  }
  return repository.searchProducts(query);
}
```

---

## 4. Parameters (Families) & Caching (`keepAlive`)
- **Family Parameters**: Simply pass arguments directly to the function or the `build()` method of a `Notifier`. Parameters must implement `==` and `hashCode`.
  ```dart
  @riverpod
  class ProductDetailNotifier extends _$ProductDetailNotifier {
    @override
    FutureOr<Product> build(int productId) async {
      return ref.watch(productRepositoryProvider).getProductById(productId);
    }
  }
  ```
- **Persistence (`keepAlive`)**: By default, generated providers are `autoDispose`. Use `@Riverpod(keepAlive: true)` for global persistent providers (e.g. database connections, settings), or call `ref.keepAlive()` dynamically inside `build()`.

---

## 5. UI Consumption Rules
- **Widgets**: Extend `ConsumerWidget` or `ConsumerStatefulWidget` to access `WidgetRef ref`.
- **`ref.watch`**: Call inside `build()` to reactively listen to provider changes and trigger rebuilds.
- **`ref.read`**: Call inside user event callbacks (e.g. `onPressed`, `onSubmitted`) to invoke methods on notifiers. **NEVER** use `ref.read` directly inside `build()`.
- **`ref.listen`**: Use inside `build()` to trigger side-effects like showing SnackBars, dialogs, or navigation:
  ```dart
  ref.listen<AsyncValue<void>>(productsControllerProvider, (previous, next) {
    next.whenOrNull(error: (err, stack) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString()))));
  });
  ```
- **Selective Rebuilds (`select`)**: Use `ref.watch(provider.select((s) => s.property))` when a widget only needs a slice of complex state to avoid unnecessary rebuilds.
- **Async Handling (`AsyncValue`)**:
  ```dart
  final asyncProducts = ref.watch(productsControllerProvider);

  return asyncProducts.when(
    data: (products) => ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    ),
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, stack) => ErrorDisplayWidget(
      error: error,
      onRetry: () => ref.invalidate(productsControllerProvider),
    ),
  );
  ```

---

## 6. Invalidation & Refreshing
- **`ref.invalidate(provider)`**: Marks the provider as dirty, causing it to rebuild lazily upon next read/watch.
- **`ref.refresh(provider)`**: Forces immediate recomputation and returns the new value synchronously.

---

## 7. Async Gaps & Cleanup
- Check `if (!ref.mounted) return;` after an `await` point before calling state updates or interacting with `ref` inside async notifier methods.
- Use `ref.onDispose(() { ... })` inside `build()` to clean up controllers, timers, or subscriptions when the provider is unmounted.

---

## 8. Testing & Mocking
- Override generated providers in `ProviderScope` (for widget tests) or `ProviderContainer` (for unit tests):
  ```dart
  final container = ProviderContainer(
    overrides: [
      productRepositoryProvider.overrideWithValue(mockProductRepository),
    ],
  );
  addTearDown(container.dispose);
  ```
