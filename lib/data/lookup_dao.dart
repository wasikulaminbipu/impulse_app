import 'package:drift/drift.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/providers/database_provider.dart';

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

  Future<List<Category>> getCategories({bool forceRefresh = false}) async {
    if (_categories != null && !forceRefresh) return _categories!;
    final rows = await (db.select(db.categories)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _categories = rows.map((e) => Category(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn, iconName: e.iconName)).toList();
  }

  Future<List<TargetGroup>> getTargetGroups({bool forceRefresh = false}) async {
    if (_targetGroups != null && !forceRefresh) return _targetGroups!;
    final rows = await (db.select(db.targetGroups)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _targetGroups = rows.map((e) => TargetGroup(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn, iconName: e.iconName)).toList();
  }

  Future<List<ContentType>> getContentTypes({bool forceRefresh = false}) async {
    if (_contentTypes != null && !forceRefresh) return _contentTypes!;
    final rows = await (db.select(db.contentTypes)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _contentTypes = rows.map((e) => ContentType(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn)).toList();
  }

  Future<List<ProductType>> getProductTypes({bool forceRefresh = false}) async {
    if (_productTypes != null && !forceRefresh) return _productTypes!;
    final rows = await (db.select(db.productTypes)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _productTypes = rows.map((e) => ProductType(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn, iconName: e.iconName)).toList();
  }

  Future<List<Species>> getSpecies({
    int? targetGroupId,
    bool forceRefresh = false,
  }) async {
    if (targetGroupId == null) {
      if (_species != null && !forceRefresh) return _species!;
      final rows = await (db.select(db.species)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
      return _species = rows.map((e) => Species(id: e.id, targetGroupId: e.targetGroupId, nameEn: e.nameEn, nameBn: e.nameBn)).toList();
    }
    final all = await getSpecies(forceRefresh: forceRefresh);
    return all.where((s) => s.targetGroupId == targetGroupId).toList();
  }

  Future<List<DosageUnit>> getDosageUnits({bool forceRefresh = false}) async {
    if (_dosageUnits != null && !forceRefresh) return _dosageUnits!;
    final rows = await (db.select(db.dosageUnits)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _dosageUnits = rows.map((e) => DosageUnit(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn)).toList();
  }

  Future<List<DosageBasis>> getDosageBases({bool forceRefresh = false}) async {
    if (_dosageBases != null && !forceRefresh) return _dosageBases!;
    final rows = await (db.select(db.dosageBases)..orderBy([(t) => OrderingTerm(expression: t.nameEn)])).get();
    return _dosageBases = rows.map((e) => DosageBasis(id: e.id, nameEn: e.nameEn, nameBn: e.nameBn)).toList();
  }
}
