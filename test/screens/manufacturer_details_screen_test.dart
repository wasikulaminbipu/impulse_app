import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/screens/manufacturer_details_screen.dart';

void main() {
  const mockManufacturer = Manufacturer(
    id: 1,
    nameEn: 'Impulse Agriscience Ltd.',
    nameBn: 'ইমপালস এগ্রিসায়েন্স লি:',
    addressEn: 'Dhaka, Bangladesh',
    addressBn: 'ঢাকা, বাংলাদেশ',
    countryOfOriginEn: 'Bangladesh',
    email: 'info@impulse.com',
    website: 'https://impulse.com',
    mobile: '01700000000',
    logoUrl: 'assets/logo.png',
  );

  const mockProduct = Product(
    id: 1,
    titleEn: 'Amoxivet 50% WSP',
    titleBn: 'এমক্সিবেট ৫০% ডব্লিউএসপি',
    slug: 'amoxivet-50-wsp',
    categoryId: 1,
    manufacturerId: 1,
    shortDescriptionEn: 'Broad spectrum antibiotic powder',
    imageUrl: 'assets/amoxivet.png',
    createdAt: '2026-01-01',
    updatedAt: '2026-01-01',
  );

  Widget createHarness({
    required Widget child,
    String lang = 'en',
    List<Product> products = const [mockProduct],
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _MockLanguageSetting(lang)),
        productsByManufacturerProvider(1).overrideWith((ref) async => products),
        productFavoritesProvider.overrideWith((ref) async => [1]),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('ManufacturerDetailsScreen Widget Tests', () {
    testWidgets('Renders manufacturer info and products in English', (
      tester,
    ) async {
      await tester.pumpWidget(
        createHarness(
          child: const ManufacturerDetailsScreen(
            manufacturer: mockManufacturer,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Impulse Agriscience Ltd.'), findsWidgets);
      expect(find.text('Dhaka, Bangladesh'), findsOneWidget);
      expect(find.text('info@impulse.com'), findsOneWidget);
      expect(find.text('Amoxivet 50% WSP'), findsOneWidget);
    });

    testWidgets('Renders manufacturer info in Bengali', (tester) async {
      await tester.pumpWidget(
        createHarness(
          lang: 'bn',
          child: const ManufacturerDetailsScreen(
            manufacturer: mockManufacturer,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ইমপালস এগ্রিসায়েন্স লি:'), findsWidgets);
      expect(find.text('ঢাকা, বাংলাদেশ'), findsOneWidget);
    });

    testWidgets('Renders empty state when manufacturer has no products', (
      tester,
    ) async {
      await tester.pumpWidget(
        createHarness(
          products: const [],
          child: const ManufacturerDetailsScreen(
            manufacturer: mockManufacturer,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Impulse Agriscience Ltd.'), findsWidgets);
      expect(find.text('Amoxivet 50% WSP'), findsNothing);
    });
  });
}

class _MockLanguageSetting extends LanguageSetting {
  final String initial;
  _MockLanguageSetting(this.initial);

  @override
  String build() => initial;
}
