import 'package:freezed_annotation/freezed_annotation.dart';

part 'composition.freezed.dart';

@freezed
abstract class Composition with _$Composition {
  const factory Composition({
    required int id,
    required int productId,
    required String ingredientEn,
    String? ingredientBn,
    String? concentration,
    @Default(0) int displayOrder,
  }) = _Composition;

  factory Composition.fromRow(Map<String, dynamic> row) => Composition(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    ingredientEn: row['ingredient_en'] as String,
    ingredientBn: row['ingredient_bn'] as String?,
    concentration: row['concentration'] as String?,
    displayOrder: row['display_order'] as int,
  );
}
