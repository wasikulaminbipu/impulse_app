import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/db_extensions.dart';

void main() {
  group('QueryExecutorX Tests', () {
    late NativeDatabase executor;

    setUp(() async {
      executor = NativeDatabase.memory();
    });

    tearDown(() async {
      await executor.close();
    });

    test('NoOpUser satisfies QueryExecutorUser contract', () async {
      final user = NoOpUser();
      expect(user.schemaVersion, equals(1));
      // Calling beforeOpen should execute without errors
      await user.beforeOpen(executor, const OpeningDetails(null, 1));
    });

    test(
      'customExecute, customQuery, and query work via executor extension',
      () async {
        // ignore: deprecated_member_use
        await executor.customExecute(
          'CREATE TABLE test_items (id INTEGER PRIMARY KEY, name TEXT);',
        );

        // ignore: deprecated_member_use
        await executor.customExecute(
          'INSERT INTO test_items (id, name) VALUES (?, ?);',
          [1, 'Product A'],
        );

        // ignore: deprecated_member_use
        final customRows = await executor.customQuery(
          'SELECT * FROM test_items WHERE id = ?;',
          [1],
        );
        expect(customRows.length, equals(1));
        expect(customRows.first['name'], equals('Product A'));

        // ignore: deprecated_member_use
        final queryRows = await executor.query(
          'test_items',
          columns: ['name'],
          where: 'id = ?',
          whereArgs: [1],
          orderBy: 'id ASC',
          limit: 10,
          offset: 0,
        );
        expect(queryRows.length, equals(1));
        expect(queryRows.first['name'], equals('Product A'));
      },
    );

    test('chunkedInQuery handles empty list and chunks properly', () async {
      // ignore: deprecated_member_use
      final emptyResult = await executor.chunkedInQuery(
        prefix: 'SELECT * FROM test_items WHERE id IN ',
        ids: [],
      );
      expect(emptyResult, isEmpty);

      // ignore: deprecated_member_use
      await executor.customExecute(
        'CREATE TABLE test_chunk (id INTEGER PRIMARY KEY);',
      );
      for (var i = 1; i <= 10; i++) {
        // ignore: deprecated_member_use
        await executor.customExecute(
          'INSERT INTO test_chunk (id) VALUES (?);',
          [i],
        );
      }

      // ignore: deprecated_member_use
      final chunkResult = await executor.chunkedInQuery(
        prefix: 'SELECT * FROM test_chunk WHERE id IN ',
        ids: [1, 3, 5, 7, 9],
        chunkSize: 2,
      );
      expect(chunkResult.length, equals(5));
    });
  });
}
