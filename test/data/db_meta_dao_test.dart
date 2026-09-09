import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/db_extensions.dart';
import 'package:impulse_app/data/db_meta_dao.dart';

void main() {
  group('DbMetaDao Unit Tests', () {
    late ProductsDb db;
    late DbMetaDao dao;

    setUp(() async {
      db = ProductsDb(NativeDatabase.memory());
      await db.executor.ensureOpen(NoOpUser());
      await db.executor.runCustom(
        'CREATE TABLE db_meta (key TEXT PRIMARY KEY, value TEXT);',
        const [],
      );
      dao = DbMetaDao(db.executor);
    });

    tearDown(() async {
      await db.close();
    });

    test('getValue returns null when key missing', () async {
      expect(await dao.getValue('missing_key'), isNull);
    });

    test(
      'getSchemaVersion, getDataVersion, and getGeneratedAt parse correctly',
      () async {
        const nowIso = '2026-09-07T12:00:00.000Z';
        await db.executor.runCustom(
          "INSERT INTO db_meta (key, value) VALUES ('schema_version', '3'), ('data_version', '5'), ('generated_at', ?);",
          [nowIso],
        );

        expect(await dao.getSchemaVersion(), equals(3));
        expect(await dao.getDataVersion(), equals(5));
        expect(await dao.getGeneratedAt(), equals(DateTime.parse(nowIso)));
      },
    );

    test('getAll returns map of all key-value pairs', () async {
      await db.executor.runCustom(
        "INSERT INTO db_meta (key, value) VALUES ('k1', 'v1'), ('k2', 'v2');",
        const [],
      );

      final all = await dao.getAll();
      expect(all, equals({'k1': 'v1', 'k2': 'v2'}));
    });
  });
}
