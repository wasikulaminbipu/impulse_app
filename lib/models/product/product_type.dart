import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_type.freezed.dart';

@freezed
abstract class ProductType with _$ProductType {
  const factory ProductType({
    required int id,
    required String nameEn,
    String? nameBn,
    String? iconName,
  }) = _ProductType;

  factory ProductType.fromRow(Map<String, dynamic> row) => ProductType(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    iconName: row['icon_name'] as String?,
  );
}
