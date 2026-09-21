import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/utils/search_analytics.dart';

void main() {
  group('SearchAnalyticsTracker Tests', () {
    tearDown(SearchAnalyticsTracker.clearListeners);

    test('SearchAnalyticsEvent toJson produces expected format', () {
      final now = DateTime.now();
      final event = SearchAnalyticsEvent(
        query: 'antibiotic',
        resultCount: 5,
        executionTimeMs: 15,
        timestamp: now,
        categoryOrScope: 'Veterinary',
      );

      final json = event.toJson();
      expect(json['query'], equals('antibiotic'));
      expect(json['result_count'], equals(5));
      expect(json['execution_time_ms'], equals(15));
      expect(json['timestamp'], equals(now.toIso8601String()));
      expect(json['category_or_scope'], equals('Veterinary'));
      expect(json['is_zero_result'], isFalse);
    });

    test('logSearch ignores empty or whitespace-only queries', () {
      final initialLogsCount = SearchAnalyticsTracker.getRecentLogs().length;
      SearchAnalyticsTracker.logSearch(
        query: '   ',
        resultCount: 0,
        executionTimeMs: 10,
      );
      expect(
        SearchAnalyticsTracker.getRecentLogs().length,
        equals(initialLogsCount),
      );
    });

    test(
      'logSearch fires registered listeners and tracks zero-result rate',
      () {
        SearchAnalyticsEvent? executedEvent;
        SearchAnalyticsEvent? zeroResultEvent;

        SearchAnalyticsTracker.registerListeners(
          onSearchExecuted: (e) => executedEvent = e,
          onZeroResultQuery: (e) => zeroResultEvent = e,
        );

        // Log non-zero search
        SearchAnalyticsTracker.logSearch(
          query: 'Paracetamol',
          resultCount: 3,
          executionTimeMs: 25,
          categoryOrScope: 'Human',
        );

        expect(executedEvent, isNotNull);
        expect(executedEvent!.query, equals('paracetamol'));
        expect(executedEvent!.resultCount, equals(3));
        expect(zeroResultEvent, isNull);

        // Log zero-result search
        SearchAnalyticsTracker.logSearch(
          query: 'UnknownChemical123',
          resultCount: 0,
          executionTimeMs: 8,
        );

        expect(zeroResultEvent, isNotNull);
        expect(zeroResultEvent!.query, equals('unknownchemical123'));
        expect(zeroResultEvent!.resultCount, equals(0));

        final rate = SearchAnalyticsTracker.getZeroResultRate();
        expect(rate, greaterThan(0.0));
        expect(rate, lessThanOrEqualTo(1.0));
      },
    );
  });
}
