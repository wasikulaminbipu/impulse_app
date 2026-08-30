import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/lookup_dao.dart';

void main() {
  late ProductsDb db;
  late LookupDao lookupDao;

  setUp(() {
    db = ProductsDb(NativeDatabase.memory());
    lookupDao = LookupDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('LookupDao Tests', () {
    test('getCategories and getCategoryMap caching and fetching', () async {
      await db.into(db.categories).insert(
        CategoriesCompanion.insert(id: const Value(1), nameEn: 'Antibiotics', nameBn: 'অ্যান্টিবায়োটিক'),
      );

      final categories = await lookupDao.getCategories();
      expect(categories.length, equals(1));
      expect(categories.first.nameEn, equals('Antibiotics'));

      final categoryMap = await lookupDao.getCategoryMap();
      expect(categoryMap.containsKey(1), isTrue);
      expect(categoryMap[1]?.nameEn, equals('Antibiotics'));
    });

    test('getTargetGroups transforms iconName feed_additive to feed_additives', () async {
      await db.into(db.targetGroups).insert(
        TargetGroupsCompanion.insert(
          id: const Value(7),
          nameEn: 'Feed Additive',
          nameBn: 'ফিড অ্যাডিটিভ',
          iconName: const Value('feed_additive'),
        ),
      );

      final targetGroups = await lookupDao.getTargetGroups();
      expect(targetGroups.length, equals(1));
      expect(targetGroups.first.iconName, equals('feed_additives'));
    });

    test('getSpecies filters by targetGroupId when supplied', () async {
      await db.into(db.species).insert(
        SpeciesCompanion.insert(
          id: const Value(1),
          targetGroupId: 1,
          nameEn: 'Broiler',
          nameBn: 'ব্রয়লার',
        ),
      );
      await db.into(db.species).insert(
        SpeciesCompanion.insert(
          id: const Value(2),
          targetGroupId: 2,
          nameEn: 'Cow',
          nameBn: 'গরু',
        ),
      );

      final poultrySpecies = await lookupDao.getSpecies(targetGroupId: 1);
      expect(poultrySpecies.length, equals(1));
      expect(poultrySpecies.first.nameEn, equals('Broiler'));
    });

    test('preloadAll populates cache across all lookup entities', () async {
      await lookupDao.preloadAll();

      final categories = await lookupDao.getCategories();
      final targetGroups = await lookupDao.getTargetGroups();
      final contentTypes = await lookupDao.getContentTypes();

      expect(categories, isEmpty);
      expect(targetGroups, isEmpty);
      expect(contentTypes, isEmpty);
    });
  });
}
