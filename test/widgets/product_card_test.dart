import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/widgets/product_card.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';

Widget createProductCardHarness({
  required Widget child,
  required ProviderContainer container,
}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

void main() {
  final sampleProduct = ProductLabel(
    id: 1,
    titleEn: 'Amoxivet 50%',
    titleBn: 'অ্যামোক্সিভেট ৫০%',
    shortDescriptionEn: 'Broad spectrum antibiotic',
    shortDescriptionBn: 'ব্রড স্পেকট্রাম অ্যান্টিবায়োটিক',
    categoryId: 1,
    category: const Category(id: 1, nameEn: 'Antibiotics'),
    targetGroups: const [TargetGroup(id: 1, nameEn: 'Poultry', iconName: 'poultry')],
    presentations: const [Presentation(id: 1, productId: 1, productTypeId: 1, contentTypeId: 1, size: '100g', mrp: 450.0)],
  );

  group('ProductCard Widget Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          productFavoritesProvider.overrideWith((ref) async => [1]),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Renders product title, description and presentation badge', (tester) async {
      await tester.pumpWidget(
        createProductCardHarness(
          container: container,
          child: ProductCard(product: sampleProduct),
        ),
      );
      await tester.pump();

      expect(find.text('Amoxivet 50%'), findsOneWidget);
      expect(find.text('Broad spectrum antibiotic'), findsOneWidget);
      expect(find.text('100g : ৳ 450.00'), findsOneWidget);
    });

    testWidgets('Renders Bengali title when lang is bn', (tester) async {
      await tester.pumpWidget(
        createProductCardHarness(
          container: container,
          child: ProductCard(
            product: sampleProduct,
            lang: 'bn',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('অ্যামোক্সিভেট ৫০%'), findsOneWidget);
    });
  });
}
