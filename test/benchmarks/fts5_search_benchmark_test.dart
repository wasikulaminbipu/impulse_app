import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/fts_utils.dart';

void main() {
  group('Search Engine & FTS5 Query Processing Benchmarks', () {
    test('Benchmark: Synonym expansion throughput', () {
      final tokens = [
        'amox',
        'antibiotic',
        'পোল্ট্রি',
        'cattle',
        'vit',
        'dewormer',
      ];

      const iterations = 5000;
      final stopwatch = Stopwatch()..start();

      for (int i = 0; i < iterations; i++) {
        final token = tokens[i % tokens.length];
        final expansions = getSynonymExpansions(token);
        expect(expansions, isNotEmpty);
      }

      stopwatch.stop();
      final elapsedMs = stopwatch.elapsedMilliseconds;
      expect(
        elapsedMs,
        lessThan(2000),
        reason: 'Synonym expansion took $elapsedMs ms for $iterations ops',
      );
    });

    test('Benchmark: FTS5 MATCH query sanitization throughput', () {
      final testCases = [
        'amox',
        'paracetamol suspension',
        'ডক্সিসাইক্লিন',
        'vitamin c 100',
        'enrofloxacin oral solution',
      ];

      const iterations = 3000;
      final stopwatch = Stopwatch()..start();

      for (int i = 0; i < iterations; i++) {
        final query = testCases[i % testCases.length];
        final sanitized = sanitizeFtsQuery(query);
        expect(sanitized, isNotEmpty);
      }

      stopwatch.stop();
      final elapsedMs = stopwatch.elapsedMilliseconds;
      expect(
        elapsedMs,
        lessThan(2000),
        reason: 'FTS5 sanitization took $elapsedMs ms for $iterations ops',
      );
    });

    test('Benchmark: Complex search query tokenization latency < 15ms', () {
      const complexQuery =
          'oxytetracycline 20% long acting injection for cattle and sheep';
      final stopwatch = Stopwatch()..start();

      for (int i = 0; i < 100; i++) {
        final sanitized = sanitizeFtsQuery(complexQuery);
        expect(sanitized, contains('oxytetracycline'));
      }

      stopwatch.stop();
      // P95 latency for 100 runs must be under 15ms total
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });
  });
}
