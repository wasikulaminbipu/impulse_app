import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/product_share_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProductShareService Tests', () {
    testWidgets('Throws Exception when repaint boundary key is unattached', (
      tester,
    ) async {
      final key = GlobalKey();

      expect(
        () => ProductShareService.shareProductCard(
          repaintBoundaryKey: key,
          shareTitle: 'Test Share Title',
        ),
        throwsA(isA<Exception>()),
      );
    });

    testWidgets('RepaintBoundary widget renders with key without error', (
      tester,
    ) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RepaintBoundary(
              key: key,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: Text('Shareable Content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(key.currentContext, isNotNull);
      expect(key.currentContext?.findRenderObject(), isNotNull);
    });

    test('buildPdfFromImageBytes generates valid PDF document bytes', () async {
      // 1x1 transparent PNG bytes
      final dummyPngBytes = Uint8List.fromList([
        137,
        80,
        78,
        71,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        13,
        73,
        72,
        68,
        82,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        8,
        6,
        0,
        0,
        0,
        31,
        21,
        196,
        137,
        0,
        0,
        0,
        10,
        73,
        68,
        65,
        84,
        120,
        156,
        99,
        0,
        1,
        0,
        0,
        5,
        0,
        1,
        13,
        10,
        45,
        180,
        0,
        0,
        0,
        0,
        73,
        69,
        78,
        68,
        174,
        66,
        96,
        130,
      ]);

      final pdfBytes = await ProductShareService.buildPdfFromImageBytes(
        imageBytes: dummyPngBytes,
        imageWidth: 100,
        imageHeight: 200,
        title: 'Test Product',
      );

      expect(pdfBytes, isNotEmpty);
      // Verify PDF magic header %PDF
      final header = String.fromCharCodes(pdfBytes.take(4));
      expect(header, '%PDF');
    });

    test(
      'buildNativeProductPdf generates valid native vector/text PDF document',
      () async {
        final dummyPngBytes = Uint8List.fromList([
          137,
          80,
          78,
          71,
          13,
          10,
          26,
          10,
          0,
          0,
          0,
          13,
          73,
          72,
          68,
          82,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          1,
          8,
          6,
          0,
          0,
          0,
          31,
          21,
          196,
          137,
          0,
          0,
          0,
          10,
          73,
          68,
          65,
          84,
          120,
          156,
          99,
          0,
          1,
          0,
          0,
          5,
          0,
          1,
          13,
          10,
          45,
          180,
          0,
          0,
          0,
          0,
          73,
          69,
          78,
          68,
          174,
          66,
          96,
          130,
        ]);

        const testProduct = Product(
          id: 1,
          titleEn: 'Amoxivet 50% WSP',
          titleBn: 'এমক্সিবেট ৫০% ডব্লিউএসপি',
          slug: 'amoxivet-50-wsp',
          categoryId: 1,
          shortDescriptionEn: 'Broad spectrum antibiotic powder',
          mottoEn: 'Reliable bacterial infection therapy',
          createdAt: '2026-01-01',
          updatedAt: '2026-01-01',
          compositions: [
            Composition(
              id: 1,
              productId: 1,
              ingredientEn: 'Amoxicillin Trihydrate',
              concentration: '500 mg/g',
              displayOrder: 1,
            ),
          ],
          indications: [
            Indication(
              id: 1,
              productId: 1,
              textEn: 'Respiratory tract infections and fowl cholera',
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
              dosageEn: '1g per 2L water for 3-5 days',
              administrationEn: 'Oral administration via drinking water',
              displayOrder: 1,
            ),
          ],
          precautions: [
            Precaution(
              id: 1,
              productId: 1,
              textEn: 'Withdrawal period: 3 days before slaughter',
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
            addressEn: 'Dhaka, Bangladesh',
            mobile: '01700000000',
          ),
          category: Category(id: 1, nameEn: 'Antibiotics'),
        );

        const testSpecies = [
          Species(id: 1, targetGroupId: 1, nameEn: 'Broiler'),
        ];

        final pdfBytes = await ProductShareService.buildNativeProductPdf(
          product: testProduct,
          logoBytes: dummyPngBytes,
          productImageBytes: dummyPngBytes,
          manufacturerLogoBytes: dummyPngBytes,
          speciesList: testSpecies,
        );

        expect(pdfBytes, isNotEmpty);
        final header = String.fromCharCodes(pdfBytes.take(4));
        expect(header, '%PDF');
      },
    );
  });
}
