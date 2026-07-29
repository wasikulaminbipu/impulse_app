import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_group.freezed.dart';

@freezed
abstract class TargetGroup with _$TargetGroup {
  const factory TargetGroup({
    required int id,
    required String nameEn,
    String? nameBn,
    String? iconName,
  }) = _TargetGroup;

  factory TargetGroup.fromRow(Map<String, dynamic> row) => TargetGroup(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    iconName: row['icon_name'] as String?,
  );
}
