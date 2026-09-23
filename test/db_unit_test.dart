import 'package:crypto/crypto.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/lookup_dao.dart';
import 'package:impulse_app/data/product_dao.dart';

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

    test(
      'SHA-256 signature changes when any single byte changes in DB payload',
      () {
        final baseBytes = List<int>.filled(500, 0);
        final modifiedBytes = List<int>.from(baseBytes);
        // Change a single byte deep in payload
        modifiedBytes[250] = 1;

        final sig1 = sha256.convert(baseBytes).toString();
        final sig2 = sha256.convert(modifiedBytes).toString();

        expect(sig1, isNot(equals(sig2)));
        expect(sig1.length, 64);
        expect(sig2.length, 64);
      },
    );

    test(
      'SHA-256 signature detects same-length and same-counter content changes',
      () {
        // Mock SQLite header where bytes 24-27 (change counter) are identical
        final dbA = List<int>.generate(1000, (i) => i % 256);
        final dbB = List<int>.from(dbA);
        // Modify content outside of header bytes 24-27
        dbB[500] = (dbB[500] + 1) % 256;

        final sigA = sha256.convert(dbA).toString();
        final sigB = sha256.convert(dbB).toString();

        expect(sigA, isNot(equals(sigB)));
      },
    );
  });
}
