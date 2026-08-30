import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/data/fts_utils.dart';
import 'package:impulse_app/utils/search_analytics.dart';

void main() {
  group('ProductSearchQuery Provider Tests', () {
    test('Initial search query state is empty string', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(productSearchQueryProvider);
      expect(state, equals(''));
    });

    test('updateQuery updates state after debounce or directly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.listen(productSearchQueryProvider, (previous, next) {});

      final notifier = container.read(productSearchQueryProvider.notifier);
      notifier.updateQuery('vaccine');

      // Allow debounce timer to fire if any
      await Future<void>.delayed(const Duration(milliseconds: 350));
      final state = container.read(productSearchQueryProvider);
      expect(state, equals('vaccine'));
    });
  });

  group('Search Engine Expert Utilities & Telemetry Tests', () {
    test('sanitizeFtsQuery expands terms and filters stopwords for multi-word queries', () {
      final query = sanitizeFtsQuery('vit c for cattle');
      expect(query, contains('"vit"*'));
      expect(query, contains('"vitamin"*'));
      expect(query, isNot(contains('"for"*')));
      expect(query, contains('"cattle"*'));
    });

    test('sanitizeFtsQuery preserves single-word stopwords', () {
      final query = sanitizeFtsQuery('for');
      expect(query, equals('"for"*'));
    });

    test('SearchAnalyticsTracker logs zero-result events properly', () {
      SearchAnalyticsTracker.clearListeners();
      SearchAnalyticsTracker.logSearch(query: 'unknown medicine xyz', resultCount: 0, executionTimeMs: 12);
      SearchAnalyticsTracker.logSearch(query: 'amoxicillin', resultCount: 5, executionTimeMs: 8);

      final logs = SearchAnalyticsTracker.getRecentLogs();
      expect(logs.length, equals(2));
      expect(logs.first.query, equals('amoxicillin'));
    });

    test('reciprocalRankFusion properly merges multiple ranked lists', () {
      final list1 = ['doc1', 'doc2', 'doc3'];
      final list2 = ['doc2', 'doc4', 'doc1'];

      final fused = reciprocalRankFusion<String>(
        rankedResultLists: [list1, list2],
        getId: (id) => id,
        k: 60,
      );

      // doc2 is rank 2 in list1 and rank 1 in list2 -> highest RRF score
      expect(fused.first, equals('doc2'));
      expect(fused, containsAll(['doc1', 'doc2', 'doc3', 'doc4']));
    });

    test('Expanded synonym dictionary maps veterinary and generic terms', () {
      final amoxExpansions = getSynonymExpansions('amox');
      expect(amoxExpansions, containsAll(['amoxicillin', 'amoxycillin']));

      final vetExpansions = getSynonymExpansions('vet');
      expect(vetExpansions, contains('veterinary'));

      final poultryExpansions = getSynonymExpansions('poultry');
      expect(poultryExpansions, containsAll(['chicken', 'broiler', 'layer']));
    });

    test('calculatePhoneticSimilarity handles sound-alike terms and transliterations', () {
      final sim1 = calculatePhoneticSimilarity('amoxilin', 'Amoxicillin');
      expect(sim1, greaterThan(0.7));

      final sim2 = calculatePhoneticSimilarity('ciproflxacin', 'Ciprofloxacin');
      expect(sim2, greaterThan(0.7));

      final matchesPhonetic = matchesFuzzyToken('Amoxicillin Trihydrate', 'amoxilin');
      expect(matchesPhonetic, isTrue);
    });
  });
}
