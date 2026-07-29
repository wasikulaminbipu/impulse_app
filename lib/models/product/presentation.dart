import 'package:freezed_annotation/freezed_annotation.dart';

part 'presentation.freezed.dart';

@freezed
abstract class Presentation with _$Presentation {
  const factory Presentation({
    required int id,
    required int productId,
    required int productTypeId,
    required int contentTypeId,
    String? size,
    double? mrp,
    String? imageUrl,
    @Default(0) int displayOrder,
    @Default(false) bool bulkItem,
  }) = _Presentation;

  const Presentation._();

  factory Presentation.fromRow(Map<String, dynamic> row) => Presentation(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    productTypeId: row['product_type_id'] as int,
    contentTypeId: row['content_type_id'] as int,
    size: row['size'] as String?,
    mrp: (row['mrp'] as num?)?.toDouble(),
    imageUrl: row['image_url'] as String?,
    displayOrder: row['display_order'] as int? ?? 0,
    bulkItem: (row['bulk_item'] as int? ?? 0) == 1,
  );

  Map<String, dynamic> toRow() => {
    'id': id,
    'product_id': productId,
    'product_type_id': productTypeId,
    'content_type_id': contentTypeId,
    'size': size,
    'mrp': mrp,
    'image_url': imageUrl,
    'display_order': displayOrder,
    'bulk_item': bulkItem ? 1 : 0,
  };
}
