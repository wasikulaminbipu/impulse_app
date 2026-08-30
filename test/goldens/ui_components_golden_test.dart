@Tags(['golden'])
library;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/theme/app_theme.dart';
import 'package:impulse_dex/widgets/custom_badge.dart';
import 'package:impulse_dex/widgets/tactile_button.dart';
import 'package:impulse_dex/widgets/glass_container.dart';
import 'package:impulse_dex/widgets/feedback_banner.dart';
import 'package:impulse_dex/widgets/favorite_button.dart';
import 'package:impulse_dex/widgets/product_card.dart';

/// Custom golden comparator with a controlled cross-platform tolerance threshold (2%)
/// to account for OS-level font rasterization / anti-aliasing variations (e.g. Linux CI vs Windows).
class TolerantGoldenFileComparator extends LocalFileComparator {
  final double tolerance;

  TolerantGoldenFileComparator(super.testFile, {this.tolerance = 0.02});

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final ComparisonResult result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (result.passed) {
      return true;
    }

    if (result.diffPercent <= tolerance) {
      debugPrint(
        'Golden diff of ${(result.diffPercent * 100).toStringAsFixed(2)}% '
        'detected for $golden (within tolerance of ${(tolerance * 100).toStringAsFixed(2)}%). Passing test.',
      );
      return true;
    }

    final String error = await generateFailureOutput(result, golden, basedir);
    throw FlutterError(error);
  }
}

Widget createGoldenHarness({
  required Widget child,
  ThemeData? theme,
  ProviderContainer? container,
  Size surfaceSize = const Size(400, 600),
}) {
  final app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? AppTheme.lightTheme,
    home: Scaffold(
      backgroundColor: (theme ?? AppTheme.lightTheme).scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          width: surfaceSize.width,
          height: surfaceSize.height,
          child: child,
        ),
      ),
    ),
  );

  if (container != null) {
    return UncontrolledProviderScope(
      container: container,
      child: app,
    );
  }

  return ProviderScope(child: app);
}

void main() {
  setUpAll(() {
    final currentComparator = goldenFileComparator;
    if (currentComparator is LocalFileComparator) {
      goldenFileComparator = TolerantGoldenFileComparator(
        currentComparator.basedir.resolve('ui_components_golden_test.dart'),
        tolerance: 0.02,
      );
    }
  });
  final sampleProduct = ProductLabel(
    id: 1,
    titleEn: 'Amoxivet 50% WSP',
    titleBn: 'অ্যামোক্সিভেট ৫০% ডব্লিউএসপি',
    shortDescriptionEn: 'Broad spectrum antibiotic for poultry & livestock',
    shortDescriptionBn: 'পোল্ট্রি এবং গবাদি পশুর জন্য ব্রড স্পেকট্রাম অ্যান্টিবায়োটিক',
    categoryId: 1,
    category: const Category(id: 1, nameEn: 'Antibiotics'),
    targetGroups: const [TargetGroup(id: 1, nameEn: 'Poultry', iconName: 'poultry')],
    presentations: const [
      Presentation(id: 1, productId: 1, productTypeId: 1, contentTypeId: 1, size: '100g', mrp: 450.0),
      Presentation(id: 2, productId: 1, productTypeId: 1, contentTypeId: 1, size: '500g', mrp: 1950.0),
    ],
  );

  group('UI Golden Tests - Core Components', () {
    testWidgets('CustomBadge Golden - Light & Dark variants', (tester) async {
      tester.view.physicalSize = const Size(400, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final widgetUnderTest = createGoldenHarness(
        surfaceSize: const Size(360, 200),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBadge(color: Colors.blue, text: 'VACCINE'),
            SizedBox(height: 12),
            CustomBadge(color: Colors.green, text: 'BOLUS'),
            SizedBox(height: 12),
            CustomBadge(color: Colors.orange, text: 'POWDER 100G'),
          ],
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/custom_badge_variants.png'),
      );
    });

    testWidgets('TactileButton Golden - Active and Disabled States', (tester) async {
      tester.view.physicalSize = const Size(400, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final widgetUnderTest = createGoldenHarness(
        surfaceSize: const Size(360, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TactileButton(
              onPressed: () {},
              child: const Text('Primary Action'),
            ),
            const SizedBox(height: 16),
            const TactileButton(
              onPressed: null,
              child: Text('Disabled Action'),
            ),
          ],
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/tactile_button_states.png'),
      );
    });

    testWidgets('GlassContainer Golden - Frosted specular effect', (tester) async {
      tester.view.physicalSize = const Size(400, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final widgetUnderTest = createGoldenHarness(
        surfaceSize: const Size(360, 220),
        child: const GlassContainer(
          borderRadius: 16.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield_outlined, size: 36, color: Colors.blueAccent),
                SizedBox(height: 8),
                Text(
                  'Frosted Specular Glass Card',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'WCAG 2.2 AA compliant contrast',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/glass_container_card.png'),
      );
    });

    testWidgets('FeedbackBanner Golden - Success and Error banners', (tester) async {
      tester.view.physicalSize = const Size(400, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final widgetUnderTest = createGoldenHarness(
        surfaceSize: const Size(360, 200),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeedbackBanner(
              message: 'Product added to favorites',
              isError: false,
            ),
            SizedBox(height: 16),
            FeedbackBanner(
              message: 'Database synchronization failed',
              isError: true,
            ),
          ],
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/feedback_banners.png'),
      );
    });

    testWidgets('FavoriteButton Golden - Active and Inactive states', (tester) async {
      tester.view.physicalSize = const Size(500, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final container = ProviderContainer(
        overrides: [
          productFavoritesProvider.overrideWith((ref) async => [1]),
        ],
      );
      addTearDown(container.dispose);

      final widgetUnderTest = createGoldenHarness(
        container: container,
        surfaceSize: const Size(460, 150),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FavoriteButton(refId: 1, type: FavoriteType.product, size: 32),
                SizedBox(height: 6),
                Text('Active'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FavoriteButton(refId: 2, type: FavoriteType.product, size: 32),
                SizedBox(height: 6),
                Text('Inactive'),
              ],
            ),
          ],
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/favorite_button_states.png'),
      );
    });

    testWidgets('ProductCard Golden - Light Theme rendering', (tester) async {
      tester.view.physicalSize = const Size(420, 450);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final container = ProviderContainer(
        overrides: [
          productFavoritesProvider.overrideWith((ref) async => [1]),
        ],
      );
      addTearDown(container.dispose);

      final widgetUnderTest = createGoldenHarness(
        theme: AppTheme.lightTheme,
        container: container,
        surfaceSize: const Size(380, 240),
        child: ProductCard(product: sampleProduct),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/product_card_light.png'),
      );
    });

    testWidgets('ProductCard Golden - Dark Theme rendering', (tester) async {
      tester.view.physicalSize = const Size(420, 450);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final container = ProviderContainer(
        overrides: [
          productFavoritesProvider.overrideWith((ref) async => [1]),
        ],
      );
      addTearDown(container.dispose);

      final widgetUnderTest = createGoldenHarness(
        theme: AppTheme.darkTheme,
        container: container,
        surfaceSize: const Size(380, 240),
        child: ProductCard(product: sampleProduct),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/product_card_dark.png'),
      );
    });
  });
}
