import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/providers/navigation_provider.dart';

void main() {
  group('NavigationProvider Tests', () {
    test('mainNavIndexProvider initial state is 0', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(mainNavIndexProvider), equals(0));
    });

    test('setIndex updates tab index correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mainNavIndexProvider.notifier);

      notifier.setIndex(1);
      expect(container.read(mainNavIndexProvider), equals(1));

      notifier.setIndex(2);
      expect(container.read(mainNavIndexProvider), equals(2));

      notifier.setIndex(0);
      expect(container.read(mainNavIndexProvider), equals(0));
    });

    test('setIndex does not update if index is identical', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mainNavIndexProvider.notifier);

      int notifyCount = 0;
      container.listen(mainNavIndexProvider, (prev, next) {
        notifyCount++;
      });

      notifier.setIndex(0); // same as initial
      expect(notifyCount, equals(0));

      notifier.setIndex(1);
      expect(notifyCount, equals(1));

      notifier.setIndex(1); // same
      expect(notifyCount, equals(1));
    });
  });
}
