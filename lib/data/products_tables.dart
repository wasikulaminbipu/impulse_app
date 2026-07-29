import 'package:drift/drift.dart';

@DataClassName('CategoryEntity')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
  TextColumn get iconName => text().nullable()();
  TextColumn get slug => text().nullable()();
}

@DataClassName('TargetGroupEntity')
class TargetGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
  TextColumn get iconName => text().nullable()();
}

@DataClassName('ContentTypeEntity')
class ContentTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('ProductTypeEntity')
class ProductTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
  TextColumn get iconName => text().nullable()();
}

@DataClassName('SpeciesEntity')
class Species extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get targetGroupId => integer().customConstraint('NOT NULL REFERENCES target_groups(id)')();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text()();
}

@DataClassName('DosageUnitEntity')
class DosageUnits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('DosageBaseEntity')
class DosageBases extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text().unique()();
  TextColumn get nameBn => text()();
}

@DataClassName('ManufacturerEntity')
class Manufacturers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nameEn => text()();
  TextColumn get nameBn => text().nullable()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get addressEn => text().nullable()();
  TextColumn get addressBn => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get countryOfOriginEn => text().nullable()();
  TextColumn get countryOfOriginBn => text().nullable()();
}

@DataClassName('ProductEntity')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get manufacturerId => integer().nullable().customConstraint('REFERENCES manufacturers(id)')();
  IntColumn get categoryId => integer().customConstraint('NOT NULL REFERENCES categories(id)')();
  TextColumn get titleEn => text()();
  TextColumn get titleBn => text().nullable()();
  TextColumn get slug => text().unique()();
  TextColumn get mottoEn => text().nullable()();
  TextColumn get mottoBn => text().nullable()();
  TextColumn get shortDescriptionEn => text().nullable()();
  TextColumn get shortDescriptionBn => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  TextColumn get createdAt => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get updatedAt => text().clientDefault(() => DateTime.now().toIso8601String())();
  TextColumn get compositionBasisEn => text().nullable()();
  TextColumn get compositionBasisBn => text().nullable()();
}

class ProductTargetGroups extends Table {
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  IntColumn get targetGroupId => integer().customConstraint('NOT NULL REFERENCES target_groups(id)')();
  @override
  Set<Column> get primaryKey => {productId, targetGroupId};
}

@DataClassName('CompositionEntity')
class Compositions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  TextColumn get ingredientEn => text()();
  TextColumn get ingredientBn => text().nullable()();
  TextColumn get concentration => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('IndicationEntity')
class Indications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  TextColumn get textEn => text()();
  TextColumn get textBn => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('DirectionEntity')
class Directions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  IntColumn get contentTypeId => integer().customConstraint('NOT NULL REFERENCES content_types(id)')();
  IntColumn get speciesId => integer().customConstraint('NOT NULL REFERENCES species(id)')();
  RealColumn get doseValueMin => real()();
  RealColumn get doseValueMax => real().nullable()();
  IntColumn get doseUnitId => integer().customConstraint('NOT NULL REFERENCES dosage_units(id)')();
  IntColumn get doseBasisId => integer().customConstraint('NOT NULL REFERENCES dosage_bases(id)')();
  IntColumn get durationDaysMin => integer().nullable()();
  IntColumn get durationDaysMax => integer().nullable()();
  TextColumn get administrationEn => text().nullable()();
  TextColumn get administrationBn => text().nullable()();
  TextColumn get dosageEn => text().nullable()();
  TextColumn get dosageBn => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('PrecautionEntity')
class Precautions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  TextColumn get textEn => text()();
  TextColumn get textBn => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('PresentationEntity')
class Presentations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().customConstraint('NOT NULL REFERENCES products(id) ON DELETE CASCADE')();
  IntColumn get productTypeId => integer().customConstraint('NOT NULL REFERENCES product_types(id)')();
  IntColumn get contentTypeId => integer().customConstraint('NOT NULL REFERENCES content_types(id)')();
  TextColumn get size => text().nullable()();
  RealColumn get mrp => real().nullable()();
  TextColumn get imageUrl => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  IntColumn get bulkItem => integer().withDefault(const Constant(0))();
}
