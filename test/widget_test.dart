import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/main.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';

void main() {
  testWidgets('App smoke test - builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ImpulseProductsApp(),
      ),
    );

    // Verify skeleton loading state is shown initially
    expect(find.byType(ProductCardSkeleton), findsWidgets);
  });
}
