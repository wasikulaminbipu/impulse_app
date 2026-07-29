import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_maintenance.freezed.dart';

enum FavoriteType {
  product('favorite_products', 'product_id'),
  distributor('favorite_distributors', 'distributor_id'),
  salesPersonnel('favorite_sales_personnel', 'sales_personnel_id'),
  vetDoctor('favorite_vet_doctors', 'vet_doctor_id');

  final String table;
  final String idColumn;

  const FavoriteType(this.table, this.idColumn);
}

@freezed
abstract class FavoriteEntry with _$FavoriteEntry {
  const factory FavoriteEntry({
    required int id,
    required DateTime addedAt,
  }) = _FavoriteEntry;

  const FavoriteEntry._();

  factory FavoriteEntry.fromMap(Map<String, dynamic> map, String idColumn) {
    return FavoriteEntry(
      id: map[idColumn] as int,
      addedAt: DateTime.parse(map['added_at'] as String),
    );
  }
}

@freezed
abstract class AppSetting with _$AppSetting {
  const factory AppSetting({
    required String key,
    String? value,
  }) = _AppSetting;

  const AppSetting._();

  factory AppSetting.fromMap(Map<String, dynamic> map) {
    return AppSetting(
      key: map['key'] as String,
      value: map['value'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'key': key, 'value': value};
}

