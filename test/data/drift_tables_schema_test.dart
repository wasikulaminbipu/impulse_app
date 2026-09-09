import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';

void main() {
  group('Drift Table Schema Coverage Tests', () {
    test(
      'ProductsDb table schemas instantiate all columns correctly',
      () async {
        final db = ProductsDb(NativeDatabase.memory());
        expect(db.categories.nameEn.name, equals('name_en'));
        expect(db.categories.nameBn.name, equals('name_bn'));
        expect(db.categories.iconName.name, equals('icon_name'));
        expect(db.categories.slug.name, equals('slug'));

        expect(db.targetGroups.nameEn.name, equals('name_en'));
        expect(db.targetGroups.nameBn.name, equals('name_bn'));
        expect(db.targetGroups.iconName.name, equals('icon_name'));

        expect(db.contentTypes.nameEn.name, equals('name_en'));
        expect(db.contentTypes.nameBn.name, equals('name_bn'));

        expect(db.productTypes.nameEn.name, equals('name_en'));
        expect(db.productTypes.nameBn.name, equals('name_bn'));
        expect(db.productTypes.iconName.name, equals('icon_name'));

        expect(db.species.targetGroupId.name, equals('target_group_id'));
        expect(db.species.nameEn.name, equals('name_en'));
        expect(db.species.nameBn.name, equals('name_bn'));

        expect(db.dosageUnits.nameEn.name, equals('name_en'));
        expect(db.dosageUnits.nameBn.name, equals('name_bn'));

        expect(db.dosageBases.nameEn.name, equals('name_en'));
        expect(db.dosageBases.nameBn.name, equals('name_bn'));

        expect(db.manufacturers.nameEn.name, equals('name_en'));
        expect(db.manufacturers.nameBn.name, equals('name_bn'));
        expect(db.manufacturers.logoUrl.name, equals('logo_url'));
        expect(db.manufacturers.addressEn.name, equals('address_en'));
        expect(db.manufacturers.addressBn.name, equals('address_bn'));
        expect(db.manufacturers.email.name, equals('email'));
        expect(db.manufacturers.website.name, equals('website'));
        expect(db.manufacturers.mobile.name, equals('mobile'));
        expect(
          db.manufacturers.countryOfOriginEn.name,
          equals('country_of_origin_en'),
        );
        expect(
          db.manufacturers.countryOfOriginBn.name,
          equals('country_of_origin_bn'),
        );

        expect(db.products.titleEn.name, equals('title_en'));
        expect(db.products.titleBn.name, equals('title_bn'));
        expect(db.products.slug.name, equals('slug'));
        expect(db.products.categoryId.name, equals('category_id'));
        expect(db.products.manufacturerId.name, equals('manufacturer_id'));
        expect(db.products.imageUrl.name, equals('image_url'));
        expect(db.products.mottoEn.name, equals('motto_en'));
        expect(db.products.mottoBn.name, equals('motto_bn'));
        expect(
          db.products.compositionBasisEn.name,
          equals('composition_basis_en'),
        );
        expect(
          db.products.compositionBasisBn.name,
          equals('composition_basis_bn'),
        );
        expect(
          db.products.shortDescriptionEn.name,
          equals('short_description_en'),
        );
        expect(
          db.products.shortDescriptionBn.name,
          equals('short_description_bn'),
        );
        expect(db.products.isActive.name, equals('is_active'));
        expect(db.products.createdAt.name, equals('created_at'));
        expect(db.products.updatedAt.name, equals('updated_at'));

        expect(db.productTargetGroups.productId.name, equals('product_id'));
        expect(
          db.productTargetGroups.targetGroupId.name,
          equals('target_group_id'),
        );

        expect(db.compositions.productId.name, equals('product_id'));
        expect(db.compositions.ingredientEn.name, equals('ingredient_en'));
        expect(db.compositions.ingredientBn.name, equals('ingredient_bn'));
        expect(db.compositions.concentration.name, equals('concentration'));
        expect(db.compositions.displayOrder.name, equals('display_order'));

        expect(db.benefits.productId.name, equals('product_id'));
        expect(db.benefits.textEn.name, equals('text_en'));
        expect(db.benefits.textBn.name, equals('text_bn'));
        expect(db.benefits.displayOrder.name, equals('display_order'));

        expect(db.indications.productId.name, equals('product_id'));
        expect(db.indications.textEn.name, equals('text_en'));
        expect(db.indications.textBn.name, equals('text_bn'));
        expect(db.indications.displayOrder.name, equals('display_order'));

        expect(db.directions.productId.name, equals('product_id'));
        expect(db.directions.contentTypeId.name, equals('content_type_id'));
        expect(db.directions.speciesId.name, equals('species_id'));
        expect(db.directions.doseValueMin.name, equals('dose_value_min'));
        expect(db.directions.doseValueMax.name, equals('dose_value_max'));
        expect(db.directions.doseUnitId.name, equals('dose_unit_id'));
        expect(db.directions.doseBasisId.name, equals('dose_basis_id'));
        expect(db.directions.durationDaysMin.name, equals('duration_days_min'));
        expect(db.directions.durationDaysMax.name, equals('duration_days_max'));
        expect(
          db.directions.administrationEn.name,
          equals('administration_en'),
        );
        expect(
          db.directions.administrationBn.name,
          equals('administration_bn'),
        );
        expect(db.directions.dosageEn.name, equals('dosage_en'));
        expect(db.directions.dosageBn.name, equals('dosage_bn'));
        expect(db.directions.displayOrder.name, equals('display_order'));

        expect(db.precautions.productId.name, equals('product_id'));
        expect(db.precautions.textEn.name, equals('text_en'));
        expect(db.precautions.textBn.name, equals('text_bn'));
        expect(db.precautions.displayOrder.name, equals('display_order'));

        expect(db.presentations.productId.name, equals('product_id'));
        expect(db.presentations.productTypeId.name, equals('product_type_id'));
        expect(db.presentations.contentTypeId.name, equals('content_type_id'));
        expect(db.presentations.size.name, equals('size'));
        expect(db.presentations.mrp.name, equals('mrp'));
        expect(db.presentations.imageUrl.name, equals('image_url'));
        expect(db.presentations.displayOrder.name, equals('display_order'));
        expect(db.presentations.bulkItem.name, equals('bulk_item'));

        await db.close();
      },
    );

    test(
      'DistributorsDb table schemas instantiate all columns correctly',
      () async {
        final db = DistributorsDb(NativeDatabase.memory());
        expect(db.divisions.nameEn.name, equals('name_en'));
        expect(db.divisions.nameBn.name, equals('name_bn'));

        expect(db.districts.divisionId.name, equals('division_id'));
        expect(db.districts.nameEn.name, equals('name_en'));
        expect(db.districts.nameBn.name, equals('name_bn'));

        expect(db.upazilas.districtId.name, equals('district_id'));
        expect(db.upazilas.nameEn.name, equals('name_en'));
        expect(db.upazilas.nameBn.name, equals('name_bn'));

        expect(db.regions.nameEn.name, equals('name_en'));
        expect(db.regions.nameBn.name, equals('name_bn'));

        expect(db.areas.regionId.name, equals('region_id'));
        expect(db.areas.nameEn.name, equals('name_en'));
        expect(db.areas.nameBn.name, equals('name_bn'));

        expect(db.bases.areaId.name, equals('area_id'));
        expect(db.bases.nameEn.name, equals('name_en'));
        expect(db.bases.nameBn.name, equals('name_bn'));

        expect(db.baseUpazilas.baseId.name, equals('base_id'));
        expect(db.baseUpazilas.upazilaId.name, equals('upazila_id'));

        expect(db.distributors.nameEn.name, equals('name_en'));
        expect(db.distributors.nameBn.name, equals('name_bn'));
        expect(db.distributors.designation.name, equals('designation'));
        expect(db.distributors.addressEn.name, equals('address_en'));
        expect(db.distributors.addressBn.name, equals('address_bn'));
        expect(db.distributors.mobile.name, equals('mobile'));
        expect(db.distributors.areaId.name, equals('area_id'));
        expect(db.distributors.isActive.name, equals('is_active'));
        expect(db.distributors.createdAt.name, equals('created_at'));
        expect(db.distributors.updatedAt.name, equals('updated_at'));

        expect(db.salesPersonnel.nameEn.name, equals('name_en'));
        expect(db.salesPersonnel.nameBn.name, equals('name_bn'));
        expect(db.salesPersonnel.designation.name, equals('designation'));
        expect(db.salesPersonnel.mobile.name, equals('mobile'));
        expect(db.salesPersonnel.email.name, equals('email'));
        expect(db.salesPersonnel.employeeId.name, equals('employee_id'));
        expect(db.salesPersonnel.isActive.name, equals('is_active'));

        expect(db.vetDoctors.nameEn.name, equals('name_en'));
        expect(db.vetDoctors.nameBn.name, equals('name_bn'));
        expect(db.vetDoctors.qualification.name, equals('qualification'));
        expect(db.vetDoctors.specialization.name, equals('specialization'));
        expect(db.vetDoctors.mobile.name, equals('mobile'));
        expect(db.vetDoctors.email.name, equals('email'));
        expect(db.vetDoctors.addressEn.name, equals('address_en'));
        expect(db.vetDoctors.addressBn.name, equals('address_bn'));
        expect(
          db.vetDoctors.clinicOrHospitalNameEn.name,
          equals('clinic_or_hospital_name_en'),
        );
        expect(
          db.vetDoctors.clinicOrHospitalNameBn.name,
          equals('clinic_or_hospital_name_bn'),
        );
        expect(db.vetDoctors.isActive.name, equals('is_active'));

        await db.close();
      },
    );

    test(
      'AppMaintenanceDb table schemas instantiate all columns correctly',
      () async {
        final db = AppMaintenanceDb(NativeDatabase.memory());
        expect(db.favoriteProducts.productId.name, equals('product_id'));
        expect(db.favoriteProducts.addedAt.name, equals('added_at'));

        expect(
          db.favoriteDistributors.distributorId.name,
          equals('distributor_id'),
        );
        expect(
          db.favoriteSalesPersonnel.salesPersonnelId.name,
          equals('sales_personnel_id'),
        );
        expect(db.favoriteVetDoctors.vetDoctorId.name, equals('vet_doctor_id'));

        expect(db.appSettings.key.name, equals('key'));
        expect(db.appSettings.value.name, equals('value'));

        expect(db.dbMeta.key.name, equals('key'));
        expect(db.dbMeta.value.name, equals('value'));

        await db.close();
      },
    );
  });
}
