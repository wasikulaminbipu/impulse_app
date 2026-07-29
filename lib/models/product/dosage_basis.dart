import 'package:freezed_annotation/freezed_annotation.dart';

part 'dosage_basis.freezed.dart';

@freezed
abstract class DosageBasis with _$DosageBasis {
  const factory DosageBasis({
    required int id,
    required String nameEn,
    String? nameBn,
  }) = _DosageBasis;

  factory DosageBasis.fromRow(Map<String, dynamic> row) => DosageBasis(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );
}
