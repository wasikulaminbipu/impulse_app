import 'package:freezed_annotation/freezed_annotation.dart';

part 'precaution.freezed.dart';

@freezed
abstract class Precaution with _$Precaution {
  const factory Precaution({
    required int id,
    required int productId,
    required String textEn,
    String? textBn,
    @Default(0) int displayOrder,
  }) = _Precaution;

  factory Precaution.fromRow(Map<String, dynamic> row) => Precaution(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    textEn: row['text_en'] as String,
    textBn: row['text_bn'] as String?,
    displayOrder: row['display_order'] as int,
  );
}
