import 'package:freezed_annotation/freezed_annotation.dart';

part 'dosage_unit.freezed.dart';

@freezed
abstract class DosageUnit with _$DosageUnit {
  const factory DosageUnit({
    required int id,
    required String nameEn,
    String? nameBn,
  }) = _DosageUnit;

  factory DosageUnit.fromRow(Map<String, dynamic> row) => DosageUnit(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );
}
