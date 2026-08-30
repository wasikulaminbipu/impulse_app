import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/main.dart';

import 'package:impulse_app/widgets/skeleton_loader.dart';

void main() {
  testWidgets('App smoke test - builds successfully', (WidgetTester tester) async {
    // Build our app and trigger initial frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ImpulseProductsApp(),
      ),
    );

    // Verify main screen skeleton loading state is shown initially
    expect(find.byType(ProductCardSkeleton), findsWidgets);
  });
}
