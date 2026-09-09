import 'package:freezed_annotation/freezed_annotation.dart';

part 'benefit.freezed.dart';

@freezed
abstract class Benefit with _$Benefit {
  const factory Benefit({
    required int id,
    required int productId,
    required String textEn,
    String? textBn,
    @Default(0) int displayOrder,
  }) = _Benefit;

  factory Benefit.fromRow(Map<String, dynamic> row) => Benefit(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    textEn: row['text_en'] as String,
    textBn: row['text_bn'] as String?,
    displayOrder: (row['display_order'] as int?) ?? 0,
  );
}
