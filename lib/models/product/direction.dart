import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction.freezed.dart';

@freezed
abstract class Direction with _$Direction {
  const factory Direction({
    required int id,
    required int productId,
    required int contentTypeId,
    required int speciesId,
    required double doseValueMin,
    double? doseValueMax,
    required int doseUnitId,
    required int doseBasisId,
    int? durationDaysMin,
    int? durationDaysMax,
    String? administrationEn,
    String? administrationBn,
    String? dosageEn,
    String? dosageBn,
    @Default(0) int displayOrder,
  }) = _Direction;

  factory Direction.fromRow(Map<String, dynamic> row) => Direction(
    id: row['id'] as int,
    productId: row['product_id'] as int,
    contentTypeId: row['content_type_id'] as int,
    speciesId: row['species_id'] as int,
    doseValueMin: (row['dose_value_min'] as num).toDouble(),
    doseValueMax: (row['dose_value_max'] as num?)?.toDouble(),
    doseUnitId: row['dose_unit_id'] as int,
    doseBasisId: row['dose_basis_id'] as int,
    durationDaysMin: row['duration_days_min'] as int?,
    durationDaysMax: row['duration_days_max'] as int?,
    administrationEn: row['administration_en'] as String?,
    administrationBn: row['administration_bn'] as String?,
    dosageEn: row['dosage_en'] as String?,
    dosageBn: row['dosage_bn'] as String?,
    displayOrder: row['display_order'] as int,
  );
}
