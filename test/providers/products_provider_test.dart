import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/providers/products_provider.dart';

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
}
