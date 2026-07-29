import 'package:freezed_annotation/freezed_annotation.dart';

part 'indication.freezed.dart';

@freezed
abstract class Indication with _$Indication {
  const factory Indication({
    required int id,
    required int productId,
    required String textEn,
    String? textBn,
    @Default(0) int displayOrder,
  }) = _Indication;

  factory Indication.fromRow(Map<String, dynamic> row) => Indication(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    textEn: row['text_en'] as String,
    textBn: row['text_bn'] as String?,
    displayOrder: row['display_order'] as int,
  );
}
