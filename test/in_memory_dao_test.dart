import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/distributor_dao.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/product_dao.dart';
import 'package:impulse_app/models/distributor.dart';

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

    test('LocationDao handles Base and Upazila assignment', () async {
      final distDb = DistributorsDb(NativeDatabase.memory());
      await distDb.createMigrator().createAll();
      final locationDao = LocationDao(distDb);

      await distDb.executor.customExecute(
        "INSERT INTO regions (id, name_en, name_bn) VALUES (1, 'Dhaka', 'ঢাকা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO areas (id, region_id, name_en, name_bn) VALUES (10, 1, 'Gazipur Area', 'গাজীপুর এলাকা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO divisions (id, name_en, name_bn) VALUES (1, 'Dhaka', 'ঢাকা');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO districts (id, division_id, name_en, name_bn) VALUES (1, 1, 'Gazipur', 'গাজীপুর');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (101, 1, 'Sreepur', 'শ্রীপুর');",
      );
      await distDb.executor.customExecute(
        "INSERT INTO upazilas (id, district_id, name_en, name_bn) VALUES (102, 1, 'Kaliakair', 'কালিয়াকৈর');",
      );

      const base = Base(
        id: 1,
        areaId: 10,
        nameEn: 'Sreepur Base',
        nameBn: 'শ্রীপুর বেস',
      );
      await locationDao.upsertBase(base, upazilaIds: [101, 102]);

      final basesWithUpazilas = await locationDao.getAllBasesWithUpazilas();
      expect(basesWithUpazilas, hasLength(1));
      expect(basesWithUpazilas.first.base.nameEn, equals('Sreepur Base'));
      expect(
        basesWithUpazilas.first.upazilas.map((u) => u.id),
        containsAll([101, 102]),
      );

      await distDb.close();
    });
  });
}
