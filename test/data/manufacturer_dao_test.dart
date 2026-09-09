import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/manufacturer_dao.dart';

void main() {
  group('ManufacturerDao Comprehensive Tests', () {
    late ProductsDb db;
    late ManufacturerDao dao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      dao = ManufacturerDao(db);

      // Seed mock manufacturers
      await db.customStatement('''
        INSERT INTO manufacturers (id, name_en, name_bn, address_en, address_bn, country_of_origin_en, email, website, mobile, logo_url)
        VALUES (1, 'Impulse Agriscience Ltd.', 'ইমপালস এগ্রিসায়েন্স লি:', 'Dhaka, Bangladesh', 'ঢাকা, বাংলাদেশ', 'Bangladesh', 'info@impulse.com', 'https://impulse.com', '01700000000', 'logo.png');
      ''');
      await db.customStatement('''
        INSERT INTO manufacturers (id, name_en, name_bn, address_en, address_bn, country_of_origin_en, email, website, mobile, logo_url)
        VALUES (2, 'Square Pharmaceuticals Ltd.', 'স্কয়ার ফার্মাসিউটিক্যালস লি:', 'Pabna, Bangladesh', 'পাবনা, বাংলাদেশ', 'Bangladesh', 'info@squarepharma.com', 'https://squarepharma.com', '01800000000', 'square.png');
      ''');
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'getById returns correct manufacturer or null when not found',
      () async {
        final m1 = await dao.getById(1);
        expect(m1, isNotNull);
        expect(m1!.nameEn, equals('Impulse Agriscience Ltd.'));
        expect(m1.email, equals('info@impulse.com'));

        final nonExistent = await dao.getById(999);
        expect(nonExistent, isNull);
      },
    );

    test('getAll returns all manufacturers ordered by nameEn', () async {
      final list = await dao.getAll();
      expect(list.length, equals(2));
      expect(list.first.nameEn, equals('Impulse Agriscience Ltd.'));
      expect(list.last.nameEn, equals('Square Pharmaceuticals Ltd.'));
    });

    test('getFilteredManufacturers filters by English or Bengali query and respects limit/offset', () async {
      final filteredEn = await dao.getFilteredManufacturers(
        query: 'Square',
        limit: 10,
        offset: 0,
      );
      expect(filteredEn.length, equals(1));
      expect(filteredEn.first.nameEn, equals('Square Pharmaceuticals Ltd.'));

      final filteredBn = await dao.getFilteredManufacturers(
        query: 'ইমপালস',
        limit: 10,
        offset: 0,
      );
      expect(filteredBn.length, equals(1));
      expect(filteredBn.first.nameEn, equals('Impulse Agriscience Ltd.'));

      final emptyMatch = await dao.getFilteredManufacturers(
        query: 'NonExistentManufacturer',
        limit: 10,
        offset: 0,
      );
      expect(emptyMatch, isEmpty);

      final paginated = await dao.getFilteredManufacturers(
        query: '',
        limit: 1,
        offset: 1,
      );
      expect(paginated.length, equals(1));
      expect(paginated.first.nameEn, equals('Square Pharmaceuticals Ltd.'));
    });
  });
}
