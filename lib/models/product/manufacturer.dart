import 'package:freezed_annotation/freezed_annotation.dart';

part 'manufacturer.freezed.dart';

@freezed
abstract class Manufacturer with _$Manufacturer {
  const factory Manufacturer({
    required int id,
    required String nameEn,
    String? nameBn,
    String? addressEn,
    String? addressBn,
    String? countryOfOriginEn,
    String? countryOfOriginBn,
    String? email,
    String? website,
    String? mobile,
    String? logoUrl,
  }) = _Manufacturer;

  const Manufacturer._();

  const factory Manufacturer.empty({
    @Default(0) int id,
    @Default("") String nameEn,
    String? nameBn,
    String? addressEn,
    String? addressBn,
    String? countryOfOriginEn,
    String? countryOfOriginBn,
    String? email,
    String? website,
    String? mobile,
    String? logoUrl,
  }) = _ManufacturerEmpty;

  factory Manufacturer.fromRow(Map<String, dynamic> row) => Manufacturer(
    id: row['id'] as int,
    nameEn: row['name_en'] as String,
    nameBn: row['name_bn'] as String?,
    addressEn: row['address_en'] as String?,
    addressBn: row['address_bn'] as String?,
    countryOfOriginEn: row['country_of_origin_en'] as String?,
    countryOfOriginBn: row['country_of_origin_bn'] as String?,
    email: row['email'] as String?,
    website: row['website'] as String?,
    mobile: row['mobile'] as String?,
    logoUrl: row['logo_url'] as String?,
  );
}
