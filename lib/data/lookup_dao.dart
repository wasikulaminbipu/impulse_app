import 'package:drift/drift.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/data/db_extensions.dart';

class LookupDao {
  final QueryExecutor db;
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
    final rows = await db.query('categories', orderBy: 'name_en');
    return _categories = rows.map(Category.fromRow).toList();
  }

  Future<List<TargetGroup>> getTargetGroups({bool forceRefresh = false}) async {
    if (_targetGroups != null && !forceRefresh) return _targetGroups!;
    final rows = await db.query('target_groups', orderBy: 'name_en');
    return _targetGroups = rows.map(TargetGroup.fromRow).toList();
  }

  Future<List<ContentType>> getContentTypes({bool forceRefresh = false}) async {
    if (_contentTypes != null && !forceRefresh) return _contentTypes!;
    final rows = await db.query('content_types', orderBy: 'name_en');
    return _contentTypes = rows.map(ContentType.fromRow).toList();
  }

  Future<List<ProductType>> getProductTypes({bool forceRefresh = false}) async {
    if (_productTypes != null && !forceRefresh) return _productTypes!;
    final rows = await db.query('product_types', orderBy: 'name_en');
    return _productTypes = rows.map(ProductType.fromRow).toList();
  }

  /// All species, optionally filtered by target group (e.g. species dropdown
  /// that depends on the currently selected target-group tab).
  Future<List<Species>> getSpecies({
    int? targetGroupId,
    bool forceRefresh = false,
  }) async {
    if (targetGroupId == null) {
      if (_species != null && !forceRefresh) return _species!;
      final rows = await db.query('species', orderBy: 'name_en');
      return _species = rows.map(Species.fromRow).toList();
    }
    final all = await getSpecies(forceRefresh: forceRefresh);
    return all.where((s) => s.targetGroupId == targetGroupId).toList();
  }

  Future<List<DosageUnit>> getDosageUnits({bool forceRefresh = false}) async {
    if (_dosageUnits != null && !forceRefresh) return _dosageUnits!;
    final rows = await db.query('dosage_units', orderBy: 'name_en');
    return _dosageUnits = rows.map(DosageUnit.fromRow).toList();
  }

  Future<List<DosageBasis>> getDosageBases({bool forceRefresh = false}) async {
    if (_dosageBases != null && !forceRefresh) return _dosageBases!;
    final rows = await db.query('dosage_bases', orderBy: 'name_en');
    return _dosageBases = rows.map(DosageBasis.fromRow).toList();
  }
}
