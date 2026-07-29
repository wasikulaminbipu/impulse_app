import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_type.freezed.dart';

@freezed
abstract class ContentType with _$ContentType {
  const factory ContentType({
    required int id,
    required String nameEn,
    String? nameBn,
  }) = _ContentType;

  factory ContentType.fromRow(Map<String, dynamic> row) => ContentType(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );
}
