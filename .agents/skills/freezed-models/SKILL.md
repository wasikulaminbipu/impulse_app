---
name: freezed-models
description: Use when creating or updating data models, entities, or JSON serialization logic in this Flutter project.
---

# Freezed Models (Freezed 3.x & JSON Serializable)

This skill provides standard practices for using `freezed: ^3.2.6` and `json_serializable: ^6.14.0` in Flutter/Dart projects for immutable data classes, union/sealed types, deep copy, and JSON serialization.

---

## 1. Key Setup & Part Directives
Always include the proper part declarations matching the file name:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
// Include only when using JSON serialization
part 'product.g.dart';
```

---

## 2. Standard Immutable Data Models
- Annotate data classes with `@freezed`.
- Use the `Map<String, Object?>` signature for `fromJson` constructors:
```dart
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required String genericName,
    required String category,
    required String manufacturer,
    String? packSize,
    String? mrp,
    String? indication,
    String? dosage,
    @Default(false) bool isFavorite,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
```

---

## 3. Adding Custom Getters, Methods, or Computed Properties
When adding custom getters, properties, or methods to a Freezed class, you MUST define an empty private constructor:
```dart
@freezed
class Distributor with _$Distributor {
  const Distributor._(); // Required for custom getters/methods

  const factory Distributor({
    required int id,
    required String name,
    required String territory,
    required String phone,
    String? address,
  }) = _Distributor;

  factory Distributor.fromJson(Map<String, Object?> json) => _$DistributorFromJson(json);

  String get displayName => '$name ($territory)';
  bool get hasValidPhone => phone.trim().isNotEmpty;
}
```

---

## 4. Unions / Sealed State Modeling (Dart 3)
Use named factory constructors for UI state modeling, pattern matching, and discriminated unions:
```dart
@freezed
sealed class UiState<T> with _$UiState<T> {
  const factory UiState.initial() = _Initial;
  const factory UiState.loading() = _Loading;
  const factory UiState.data(T data) = _Data<T>;
  const factory UiState.error(String message, {Object? error}) = _Error;
}
```

Pattern match cleanly with Dart 3 switch expressions:
```dart
final widget = switch (state) {
  _Initial() => const SizedBox.shrink(),
  _Loading() => const Center(child: CircularProgressIndicator()),
  _Data(:final data) => ProductListView(products: data),
  _Error(:final message) => ErrorView(message: message),
};
```

---

## 5. JSON Key Renaming & Converters
- Use `@JsonKey(name: 'column_name')` for snake_case to camelCase mapping.
- Use `@Default(...)` for optional fields to ensure null safety.
```dart
@freezed
class SalesPersonnel with _$SalesPersonnel {
  const factory SalesPersonnel({
    required int id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'zone_name') String? zoneName,
    @Default('Active') String status,
  }) = _SalesPersonnel;

  factory SalesPersonnel.fromJson(Map<String, Object?> json) => _$SalesPersonnelFromJson(json);
}
```

---

## 6. Code Generation
Always run `build_runner` after modifying Freezed models:
```bash
dart run build_runner build --build-filter="lib/models/**" --delete-conflicting-outputs
```
