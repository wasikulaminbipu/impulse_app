import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/fts_utils.dart';

void main() {
  group('AppDatabases FTS & Database Initialization Tests', () {
    late NativeDatabase executor;

    setUp(() async {
      executor = NativeDatabase.memory();
      await executor.ensureOpen(NoOpUser());
    });

    tearDown(() async {
      await executor.close();
    });

    test('setupProductsFts builds virtual table, populates data, and attaches triggers', () async {
      // Create required base tables
      await executor.runCustom('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY,
          name_en TEXT,
          name_bn TEXT
        );
      ''');
      await executor.runCustom('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY,
          title_en TEXT,
          title_bn TEXT,
          slug TEXT,
          motto_en TEXT,
          short_description_en TEXT,
          category_id INTEGER
        );
      ''');

      // Insert mock category and product
      await executor.runCustom(
        "INSERT INTO categories (id, name_en, name_bn) VALUES (1, 'Vaccine', 'টিকা');",
      );
      await executor.runCustom(
        "INSERT INTO products (id, title_en, title_bn, slug, motto_en, short_description_en, category_id) "
        "VALUES (10, 'Gumboro Vaccine', 'গামবোরো টিকা', 'gumboro-vaccine', 'Effective protection', 'Immunity booster', 1);",
      );

      // Build FTS
      await setupProductsFts(executor);

      // Verify FTS table search
      final ftsRows = await executor.runSelect(
        "SELECT rowid, title_en FROM products_fts WHERE products_fts MATCH 'Gumboro';",
        [],
      );
      expect(ftsRows.length, equals(1));
      expect(ftsRows.first['rowid'], equals(10));

      // Test Insert Trigger
      await executor.runCustom(
        "INSERT INTO products (id, title_en, title_bn, slug, motto_en, short_description_en, category_id) "
        "VALUES (20, 'Newcastle Vaccine', 'রানীক্ষেত টিকা', 'newcastle-vaccine', 'Safe', 'Live viral', 1);",
      );
      final newRows = await executor.runSelect(
        "SELECT rowid FROM products_fts WHERE products_fts MATCH 'Newcastle';",
        [],
      );
      expect(newRows.length, equals(1));

      // Test Update Trigger
      await executor.runCustom(
        "UPDATE products SET title_en = 'Newcastle Modified' WHERE id = 20;",
      );
      final updatedRows = await executor.runSelect(
        "SELECT rowid FROM products_fts WHERE products_fts MATCH 'Modified';",
        [],
      );
      expect(updatedRows.length, equals(1));

      // Test Delete Trigger
      await executor.runCustom("DELETE FROM products WHERE id = 10;");
      final deletedRows = await executor.runSelect(
        "SELECT rowid FROM products_fts WHERE products_fts MATCH 'Gumboro';",
        [],
      );
      expect(deletedRows, isEmpty);

      // Calling setupProductsFts again should take the fast optimization path
      await setupProductsFts(executor);
    });

    test('setupDistributorsFts builds distributors, sales personnel, and vet doctors FTS', () async {
      await executor.runCustom('''
        CREATE TABLE distributors (
          id INTEGER PRIMARY KEY,
          name_en TEXT,
          name_bn TEXT,
          designation TEXT,
          address_en TEXT,
          address_bn TEXT,
          mobile TEXT
        );
      ''');
      await executor.runCustom('''
        CREATE TABLE sales_personnel (
          id INTEGER PRIMARY KEY,
          name_en TEXT,
          name_bn TEXT,
          designation TEXT,
          mobile TEXT,
          email TEXT,
          employee_id TEXT
        );
      ''');
      await executor.runCustom('''
        CREATE TABLE vet_doctors (
          id INTEGER PRIMARY KEY,
          name_en TEXT,
          name_bn TEXT,
          qualification TEXT,
          specialization TEXT,
          bvc_registration_no TEXT,
          clinic_or_hospital_name_en TEXT,
          clinic_or_hospital_name_bn TEXT,
          address_en TEXT,
          address_bn TEXT,
          mobile TEXT,
          email TEXT
        );
      ''');

      // Insert mock records
      await executor.runCustom(
        "INSERT INTO distributors (id, name_en, name_bn, designation, address_en, address_bn, mobile) "
        "VALUES (1, 'City Agro Store', 'সিটি এগ্রো স্টোর', 'Dealer', 'Dhaka', 'ঢাকা', '01711111111');",
      );
      await executor.runCustom(
        "INSERT INTO sales_personnel (id, name_en, name_bn, designation, mobile, email, employee_id) "
        "VALUES (2, 'Rahim Khan', 'রহিম খান', 'Field Officer', '01722222222', 'rahim@impulse.com', 'EMP-01');",
      );
      await executor.runCustom(
        "INSERT INTO vet_doctors (id, name_en, name_bn, qualification, specialization, bvc_registration_no, clinic_or_hospital_name_en, clinic_or_hospital_name_bn, address_en, address_bn, mobile, email) "
        "VALUES (3, 'Dr. Hasan', 'ডা. হাসান', 'DVM', 'Poultry', 'BVC-123', 'Central Clinic', 'সেন্ট্রাল ক্লিনিক', 'Gazipur', 'গাজীপুর', '01733333333', 'hasan@vet.com');",
      );

      // Run setup
      await setupDistributorsFts(executor);

      // Verify search
      final distMatch = await executor.runSelect(
        "SELECT rowid FROM distributors_fts WHERE distributors_fts MATCH 'City';",
        [],
      );
      expect(distMatch.length, equals(1));

      final salesMatch = await executor.runSelect(
        "SELECT rowid FROM sales_personnel_fts WHERE sales_personnel_fts MATCH 'Rahim';",
        [],
      );
      expect(salesMatch.length, equals(1));

      final vetMatch = await executor.runSelect(
        "SELECT rowid FROM vet_doctors_fts WHERE vet_doctors_fts MATCH 'Hasan';",
        [],
      );
      expect(vetMatch.length, equals(1));

      // Test optimizeAllFtsTables
      await optimizeAllFtsTables(executor);

      // Second run takes fast optimize path
      await setupDistributorsFts(executor);
    });
  });
}
