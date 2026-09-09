import 'package:drift/drift.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/models/product.dart';

/// Data Access Object for cached lookup metadata such as categories, target groups,
/// content types, product types, species, and dosage bases/units from [ProductsDb].
class LookupDao {
  final ProductsDb db;
  LookupDao(this.db);

  List<Category>? _categories;
  List<TargetGroup>? _targetGroups;
  List<ContentType>? _contentTypes;
  List<ProductType>? _productTypes;
  List<Species>? _species;
  List<DosageUnit>? _dosageUnits;
  List<DosageBasis>? _dosageBases;

  Map<int, Category>? _categoryMap;
  Map<int, TargetGroup>? _targetGroupMap;

  /// Preloads and caches all lookup tables concurrently for rapid in-memory queries.
  Future<void> preloadAll() async {
    await Future.wait([
      getCategories(forceRefresh: true),
      getTargetGroups(forceRefresh: true),
      getContentTypes(forceRefresh: true),
      getProductTypes(forceRefresh: true),
      getSpecies(forceRefresh: true),
      getDosageUnits(forceRefresh: true),
      getDosageBases(forceRefresh: true),
    ]);
  }

  /// Retrieves all product categories ordered alphabetically by English name.
  Future<List<Category>> getCategories({bool forceRefresh = false}) async {
    if (_categories != null && !forceRefresh) return _categories!;
    final rows = await (db.select(
      db.categories,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    _categories = rows
        .map(
          (e) => Category(
            id: e.id,
            nameEn: e.nameEn,
            nameBn: e.nameBn,
            iconName: e.iconName,
          ),
        )
        .toList();
    _categoryMap = {for (final c in _categories!) c.id: c};
    return _categories!;
  }

  /// Returns an ID-to-[Category] map, populating the cache if not already loaded.
  Future<Map<int, Category>> getCategoryMap({bool forceRefresh = false}) async {
    if (_categoryMap != null && !forceRefresh) return _categoryMap!;
    await getCategories(forceRefresh: forceRefresh);
    return _categoryMap!;
  }

  /// Retrieves all target groups (e.g., Poultry, Cattle, Aqua) ordered alphabetically.
  Future<List<TargetGroup>> getTargetGroups({bool forceRefresh = false}) async {
    if (_targetGroups != null && !forceRefresh) return _targetGroups!;
    final rows = await (db.select(
      db.targetGroups,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    _targetGroups = rows.map((e) {
      final icon = e.iconName == 'feed_additive'
          ? 'feed_additives'
          : e.iconName;
      return TargetGroup(
        id: e.id,
        nameEn: e.nameEn,
        nameBn: e.nameBn,
        iconName: icon,
      );
    }).toList();
    _targetGroupMap = {for (final tg in _targetGroups!) tg.id: tg};
    return _targetGroups!;
  }

  /// Returns an ID-to-[TargetGroup] map, populating the cache if not already loaded.
  Future<Map<int, TargetGroup>> getTargetGroupMap({
    bool forceRefresh = false,
  }) async {
    if (_targetGroupMap != null && !forceRefresh) return _targetGroupMap!;
    await getTargetGroups(forceRefresh: forceRefresh);
    return _targetGroupMap!;
  }

  /// Retrieves all content types (e.g. tablet, liquid, powder) ordered alphabetically.
  Future<List<ContentType>> getContentTypes({bool forceRefresh = false}) async {
    if (_contentTypes != null && !forceRefresh) return _contentTypes!;
    final rows = await (db.select(
      db.contentTypes,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _contentTypes = rows
        .map((e) => ContentType(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn))
        .toList();
  }

  /// Retrieves all product types (e.g. Antibiotic, Vitamin) ordered alphabetically.
  Future<List<ProductType>> getProductTypes({bool forceRefresh = false}) async {
    if (_productTypes != null && !forceRefresh) return _productTypes!;
    final rows = await (db.select(
      db.productTypes,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _productTypes = rows
        .map(
          (e) => ProductType(
            id: e.id,
            nameEn: e.nameEn,
            nameBn: e.nameBn,
            iconName: e.iconName,
          ),
        )
        .toList();
  }

  /// Retrieves animal species, optionally filtered by [targetGroupId].
  Future<List<Species>> getSpecies({
    int? targetGroupId,
    bool forceRefresh = false,
  }) async {
    if (targetGroupId == null) {
      if (_species != null && !forceRefresh) return _species!;
      final rows = await (db.select(
        db.species,
      )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
      return _species = rows
          .map(
            (e) => Species(
              id: e.id,
              targetGroupId: e.targetGroupId,
              nameEn: e.nameEn,
              nameBn: e.nameBn,
            ),
          )
          .toList();
    }
    final all = await getSpecies(forceRefresh: forceRefresh);
    return all.where((s) => s.targetGroupId == targetGroupId).toList();
  }

  /// Retrieves all dosage measurement units (e.g., ml, gm, kg) ordered alphabetically.
  Future<List<DosageUnit>> getDosageUnits({bool forceRefresh = false}) async {
    if (_dosageUnits != null && !forceRefresh) return _dosageUnits!;
    final rows = await (db.select(
      db.dosageUnits,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _dosageUnits = rows
        .map((e) => DosageUnit(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn))
        .toList();
  }

  /// Retrieves all dosage bases (e.g., per liter of drinking water, per kg feed).
  Future<List<DosageBasis>> getDosageBases({bool forceRefresh = false}) async {
    if (_dosageBases != null && !forceRefresh) return _dosageBases!;
    final rows = await (db.select(
      db.dosageBases,
    )..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _dosageBases = rows
        .map((e) => DosageBasis(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn))
        .toList();
  }
}
