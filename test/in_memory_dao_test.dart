import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/data/app_databases.dart';
import 'package:impulse_dex/data/product_dao.dart';
import 'package:impulse_dex/data/lookup_dao.dart';

void main() {
  group('In-Memory DAO Unit Tests', () {
    late ProductsDb db;
    late ProductDao productDao;
    late LookupDao lookupDao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      lookupDao = LookupDao(db);
      productDao = ProductDao(db, lookupDao);
    });

    tearDown(() async {
      await db.close();
    });

    test('Drift in-memory DB and DAOs initialize successfully', () async {
      expect(lookupDao, isNotNull);
      expect(productDao, isNotNull);
      final count = await productDao.getAllLight();
      expect(count, isEmpty);
    });
  });
}
