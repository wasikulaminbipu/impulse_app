import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/product_dao.dart';
import 'package:impulse_app/data/lookup_dao.dart';

void main() {
  group('Database Unit Tests', () {
    late ProductsDb db;
    late ProductDao productDao;
    late LookupDao lookupDao;

    setUp(() {
      db = ProductsDb(NativeDatabase.memory());
      lookupDao = LookupDao(db);
      productDao = ProductDao(db, lookupDao);
    });

    tearDown(() async {
      await db.close();
    });

    test('ProductsDb can be initialized in-memory', () async {
      expect(productDao, isNotNull);
      final result = await db.customSelect('SELECT 1').getSingle();
      expect(result.read<int>('1'), 1);
    });

    // Add more logic-only tests here without depending on actual assets
  });
}
