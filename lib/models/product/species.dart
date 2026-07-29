import 'package:freezed_annotation/freezed_annotation.dart';

part 'species.freezed.dart';

@freezed
abstract class Species with _$Species {
  const factory Species({
    required int id,
    required int targetGroupId,
    required String nameEn,
    String? nameBn,
  }) = _Species;

  factory Species.fromRow(Map<String, dynamic> row) => Species(
    id: row['id'] as int,
    targetGroupId: row['target_group_id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
  );
}
