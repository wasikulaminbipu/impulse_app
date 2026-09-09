import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/theme/app_theme.dart';
import 'package:impulse_app/widgets/product_details/benefits_section.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

Widget createHarness({required Widget child, ThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? AppTheme.lightTheme,
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    ),
  );
}

void main() {
  group('BenefitsSection Widget Tests', () {
    const testBenefits = [
      Benefit(
        id: 1,
        productId: 1,
        textEn: 'Improves feed conversion ratio (FCR)',
        textBn: 'এফসিআর উন্নত করে',
        displayOrder: 1,
      ),
      Benefit(
        id: 2,
        productId: 1,
        textEn: 'Reduces mortality rate',
        textBn: 'মৃত্যুহার হ্রাস করে',
        displayOrder: 2,
      ),
    ];

    testWidgets(
      'Renders in English correctly with title, icon, and bullet points',
      (tester) async {
        await tester.pumpWidget(
          createHarness(
            child: const BenefitsSection(benefits: testBenefits, lang: 'en'),
          ),
        );

        expect(find.text('Benefits'), findsOneWidget);
        expect(find.byIcon(Icons.verified_outlined), findsOneWidget);
        expect(find.text('• '), findsNWidgets(2));
        expect(
          find.text('Improves feed conversion ratio (FCR)'),
          findsOneWidget,
        );
        expect(find.text('Reduces mortality rate'), findsOneWidget);
        expect(find.byType(SectionCard), findsOneWidget);
      },
    );

    testWidgets(
      'Renders in Bengali correctly with title, icon, and Bengali text',
      (tester) async {
        await tester.pumpWidget(
          createHarness(
            child: const BenefitsSection(benefits: testBenefits, lang: 'bn'),
          ),
        );

        expect(find.text('উপকারিতা'), findsOneWidget);
        expect(find.byIcon(Icons.verified_outlined), findsOneWidget);
        expect(find.text('• '), findsNWidgets(2));
        expect(find.text('এফসিআর উন্নত করে'), findsOneWidget);
        expect(find.text('মৃত্যুহার হ্রাস করে'), findsOneWidget);
        expect(find.byType(SectionCard), findsOneWidget);
      },
    );

    testWidgets('Falls back to textEn when textBn is null in Bengali mode', (
      tester,
    ) async {
      const benefitsWithNullBn = [
        Benefit(
          id: 1,
          productId: 1,
          textEn: 'English only benefit text',
          displayOrder: 1,
        ),
      ];

      await tester.pumpWidget(
        createHarness(
          child: const BenefitsSection(
            benefits: benefitsWithNullBn,
            lang: 'bn',
          ),
        ),
      );

      expect(find.text('উপকারিতা'), findsOneWidget);
      expect(find.text('English only benefit text'), findsOneWidget);
    });

    testWidgets(
      'Falls back to textEn when textBn is empty string in Bengali mode',
      (tester) async {
        const benefitsWithEmptyBn = [
          Benefit(
            id: 1,
            productId: 1,
            textEn: 'English fallback for empty Bengali',
            textBn: '',
            displayOrder: 1,
          ),
        ];

        await tester.pumpWidget(
          createHarness(
            child: const BenefitsSection(
              benefits: benefitsWithEmptyBn,
              lang: 'bn',
            ),
          ),
        );

        expect(find.text('উপকারিতা'), findsOneWidget);
        expect(find.text('English fallback for empty Bengali'), findsOneWidget);
      },
    );

    testWidgets(
      'Renders nothing (SizedBox.shrink) when benefits list is empty',
      (tester) async {
        await tester.pumpWidget(
          createHarness(
            child: const BenefitsSection(benefits: [], lang: 'en'),
          ),
        );

        expect(find.text('Benefits'), findsNothing);
        expect(find.text('উপকারিতা'), findsNothing);
        expect(find.byType(SectionCard), findsNothing);
        expect(find.byType(BenefitsSection), findsOneWidget);
      },
    );

    testWidgets('Renders single benefit item correctly', (tester) async {
      await tester.pumpWidget(
        createHarness(
          child: BenefitsSection(benefits: [testBenefits.first], lang: 'en'),
        ),
      );

      expect(find.text('Benefits'), findsOneWidget);
      expect(find.text('• '), findsOneWidget);
      expect(find.text('Improves feed conversion ratio (FCR)'), findsOneWidget);
      expect(find.text('Reduces mortality rate'), findsNothing);
    });

    testWidgets('Preserves vertical display order of multiple benefits', (
      tester,
    ) async {
      await tester.pumpWidget(
        createHarness(
          child: const BenefitsSection(benefits: testBenefits, lang: 'en'),
        ),
      );

      final firstBenefitOffset = tester.getTopLeft(
        find.text('Improves feed conversion ratio (FCR)'),
      );
      final secondBenefitOffset = tester.getTopLeft(
        find.text('Reduces mortality rate'),
      );

      expect(firstBenefitOffset.dy, lessThan(secondBenefitOffset.dy));
    });

    testWidgets('Renders cleanly in Dark Theme with AppTheme.darkTheme', (
      tester,
    ) async {
      await tester.pumpWidget(
        createHarness(
          theme: AppTheme.darkTheme,
          child: const BenefitsSection(benefits: testBenefits, lang: 'en'),
        ),
      );

      expect(find.text('Benefits'), findsOneWidget);
      expect(find.byIcon(Icons.verified_outlined), findsOneWidget);
      expect(find.text('Improves feed conversion ratio (FCR)'), findsOneWidget);
      expect(find.byType(SectionCard), findsOneWidget);
    });

    testWidgets(
      'Handles long text gracefully on narrow mobile viewport without overflow',
      (tester) async {
        tester.view.physicalSize = const Size(320 * 3, 640 * 3);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        const longBenefit = [
          Benefit(
            id: 1,
            productId: 1,
            textEn: 'Provides extensive nutritional support across all stages of poultry production, significantly improving intestinal gut health, feed absorption, and metabolic rate while minimizing mortality.',
            textBn: 'পোল্ট্রি উৎপাদনের সকল পর্যায়ে ব্যাপক পুষ্টি সহায়তা প্রদান করে, অন্ত্রের স্বাস্থ্য, খাদ্য শোষণ এবং মেটাবলিক হার উল্লেখযোগ্যভাবে উন্নত করে এবং মৃত্যুহার হ্রাস করে।',
            displayOrder: 1,
          ),
        ];

        await tester.pumpWidget(
          createHarness(
            child: const BenefitsSection(benefits: longBenefit, lang: 'bn'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('উপকারিতা'), findsOneWidget);
        expect(
          find.textContaining('পোল্ট্রি উৎপাদনের সকল পর্যায়ে'),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );
  });
}
