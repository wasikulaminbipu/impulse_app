import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/screens/product_details_screen.dart';
import 'package:impulse_app/widgets/product_details/benefits_section.dart';
import 'package:impulse_app/widgets/product_details/composition_section.dart';
import 'package:impulse_app/widgets/product_details/directions_section.dart';
import 'package:impulse_app/widgets/product_details/indications_section.dart';
import 'package:impulse_app/widgets/product_details/manufacturer_section.dart';
import 'package:impulse_app/widgets/product_details/precautions_section.dart';
import 'package:impulse_app/widgets/product_details/presentations_section.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

void main() {
  const mockProduct = Product(
    id: 1,
    titleEn: 'Amoxivet 50% WSP',
    titleBn: 'এমক্সিবেট ৫০% ডব্লিউএসপি',
    slug: 'amoxivet-50-wsp',
    categoryId: 1,
    manufacturerId: 1,
    shortDescriptionEn: 'Broad spectrum antibiotic powder',
    shortDescriptionBn: 'অ্যান্টিবায়োটিক পাউডার',
    imageUrl: 'assets/amoxivet.png',
    createdAt: '2026-01-01',
    updatedAt: '2026-01-01',
    compositions: [
      Composition(
        id: 1,
        productId: 1,
        ingredientEn: 'Amoxicillin Trihydrate',
        ingredientBn: 'অ্যামোক্সিসিলিন ট্রাইহাইড্রেট',
        concentration: '500 mg/g',
        displayOrder: 1,
      ),
    ],
    indications: [
      Indication(
        id: 1,
        productId: 1,
        textEn: 'Respiratory tract infections',
        textBn: 'শ্বাসতন্ত্রের সংক্রমণ',
        displayOrder: 1,
      ),
    ],
    directions: [
      Direction(
        id: 1,
        productId: 1,
        contentTypeId: 1,
        speciesId: 1,
        doseValueMin: 1.0,
        doseUnitId: 1,
        doseBasisId: 1,
        dosageEn: '1g per 2L water',
        dosageBn: '১ গ্রাম প্রতি ২ লিটার পানিতে',
        administrationEn: 'Mix with drinking water',
        administrationBn: 'খাবার পানির সাথে মেশান',
        displayOrder: 1,
      ),
    ],
    precautions: [
      Precaution(
        id: 1,
        productId: 1,
        textEn: 'Do not use in laying hens',
        textBn: 'ডিমপাড়া মুরগিকে দেবেন না',
        displayOrder: 1,
      ),
    ],
    presentations: [
      Presentation(
        id: 1,
        productId: 1,
        productTypeId: 1,
        contentTypeId: 1,
        size: '100g sachet',
        mrp: 350.0,
      ),
    ],
    manufacturer: Manufacturer(
      id: 1,
      nameEn: 'Impulse Agriscience Ltd.',
      nameBn: 'ইমপালস এগ্রিসায়েন্স লি:',
      addressEn: 'Dhaka, Bangladesh',
      mobile: '01700000000',
    ),
    category: Category(
      id: 1,
      nameEn: 'Antibiotics',
      nameBn: 'অ্যান্টিবায়োটিক',
    ),
    targetGroups: [TargetGroup(id: 1, nameEn: 'Poultry', nameBn: 'পোল্ট্রি')],
  );

  const mockLabel = ProductLabel(
    id: 1,
    titleEn: 'Amoxivet 50% WSP',
    titleBn: 'এমক্সিবেট ৫০% ডব্লিউএসপি',
    categoryId: 1,
    imageUrl: 'assets/amoxivet.png',
  );

  Widget createHarness({
    required Widget child,
    String lang = 'en',
    List<int> favorites = const [],
    Product? detailProduct = mockProduct,
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _MockLanguageSetting(lang)),
        productFavoritesProvider.overrideWith((ref) async => favorites),
        productDetailProvider(1).overrideWith((ref) async => detailProduct!),
        speciesProvider.overrideWith(
          (ref) async => [
            const Species(
              id: 1,
              targetGroupId: 1,
              nameEn: 'Poultry',
              nameBn: 'পোল্ট্রি',
            ),
          ],
        ),
        targetGroupsProvider.overrideWith(
          (ref) async => [
            const TargetGroup(id: 1, nameEn: 'Poultry', nameBn: 'পোল্ট্রি'),
          ],
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('ProductDetailsScreen & Section Widgets Tests', () {
    testWidgets('Renders ProductDetailsScreen in English with all sections', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(child: const ProductDetailsScreen(product: mockLabel)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Amoxivet 50% WSP'), findsWidgets);
      expect(find.text('Amoxicillin Trihydrate'), findsWidgets);
      expect(find.text('Impulse Agriscience Ltd.'), findsWidgets);

      // Verify sections exist
      expect(find.byType(CompositionSection), findsWidgets);
      expect(find.byType(BenefitsSection), findsNothing);
      expect(find.byType(IndicationsSection), findsWidgets);
      expect(find.byType(DirectionsSection), findsWidgets);
      expect(find.byType(PrecautionsSection), findsWidgets);
      expect(find.byType(PresentationsSection), findsWidgets);
      expect(find.byType(ManufacturerSection), findsWidgets);
    });

    testWidgets('Renders BenefitsSection when product has benefits data', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final productWithBenefits = mockProduct.copyWith(
        benefits: const [
          Benefit(
            id: 1,
            productId: 1,
            textEn: 'Improves vitality and growth',
            textBn: 'প্রাণশক্তি ও বৃদ্ধি উন্নত করে',
            displayOrder: 1,
          ),
        ],
      );

      await tester.pumpWidget(
        createHarness(
          detailProduct: productWithBenefits,
          child: const ProductDetailsScreen(product: mockLabel),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BenefitsSection), findsWidgets);
      expect(find.text('Improves vitality and growth'), findsWidgets);
    });

    testWidgets('Renders ProductDetailsScreen in Bengali', (tester) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(
          lang: 'bn',
          child: const ProductDetailsScreen(product: mockLabel),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('এমক্সিবেট ৫০% ডব্লিউএসপি'), findsWidgets);
      expect(find.text('ইমপালস এগ্রিসায়েন্স লি:'), findsWidgets);
    });

    testWidgets('SectionCard renders title, icon, and child widget', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionCard(
              title: 'Test Section',
              icon: Icons.info,
              child: Text('Section Body Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Section Body Content'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('CompositionSection renders ingredients and strengths', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompositionSection(
              compositions: mockProduct.compositions,
              lang: 'en',
            ),
          ),
        ),
      );

      expect(find.text('Amoxicillin Trihydrate'), findsOneWidget);
      expect(find.text('500 mg/g'), findsOneWidget);
    });

    testWidgets('IndicationsSection renders indications list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IndicationsSection(
              indications: mockProduct.indications,
              lang: 'en',
            ),
          ),
        ),
      );

      expect(find.text('Respiratory tract infections'), findsOneWidget);
    });

    testWidgets('DirectionsSection renders species, route, and dosage', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DirectionsSection(
              directions: mockProduct.directions,
              lang: 'en',
              speciesList: const [
                Species(
                  id: 1,
                  targetGroupId: 1,
                  nameEn: 'Poultry',
                  nameBn: 'পোল্ট্রি',
                ),
              ],
              targetGroupsList: mockProduct.targetGroups,
            ),
          ),
        ),
      );

      expect(find.text('Poultry'), findsOneWidget);
      expect(find.textContaining('1g per 2L water'), findsOneWidget);
    });

    testWidgets('PrecautionsSection renders warning badges and details', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrecautionsSection(
              precautions: mockProduct.precautions,
              lang: 'en',
            ),
          ),
        ),
      );

      expect(find.text('Do not use in laying hens'), findsOneWidget);
    });

    testWidgets('PresentationsSection renders pack sizes and MRP', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PresentationsSection(
              presentations: mockProduct.presentations,
              lang: 'en',
            ),
          ),
        ),
      );

      expect(find.text('100g sachet'), findsOneWidget);
      expect(find.text('MRP: ৳350.00'), findsOneWidget);
    });

    testWidgets(
      'ManufacturerSection renders details and handles empty fields',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ManufacturerSection(
                manufacturer: mockProduct.manufacturer,
                lang: 'en',
              ),
            ),
          ),
        );

        expect(find.text('Impulse Agriscience Ltd.'), findsOneWidget);
        expect(find.text('Dhaka, Bangladesh'), findsOneWidget);
      },
    );
  });
}

class _MockLanguageSetting extends LanguageSetting {
  final String initial;
  _MockLanguageSetting(this.initial);

  @override
  String build() => initial;
}
