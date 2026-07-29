import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String nameEn,
    String? nameBn,
    String? iconName,
  }) = _Category;

  const Category._();

  const factory Category.empty({
    @Default(0) int id,
    @Default("") String nameEn,
    String? nameBn,
    String? iconName,
  }) = _CategoryEmpty;

  factory Category.fromRow(Map<String, dynamic> row) => Category(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    iconName: row['icon_name'] as String?,
  );
}
