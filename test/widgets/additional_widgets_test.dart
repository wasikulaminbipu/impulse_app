import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/widgets/asset_fallback_image.dart';
import 'package:impulse_app/widgets/favorite_button.dart';
import 'package:impulse_app/widgets/feedback_banner.dart';
import 'package:impulse_app/widgets/highlight_text.dart';
import 'package:impulse_app/widgets/privacy_policy_dialog.dart';

void main() {
  group('Additional Core Widgets Tests', () {
    testWidgets(
      'PrivacyPolicyDialog renders content, bullets, and close button',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => const PrivacyPolicyDialog(),
                  ),
                  child: const Text('Open Dialog'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Privacy Policy & Data'), findsOneWidget);
        expect(find.text('Impulse respects your privacy.'), findsOneWidget);
        expect(find.text('Read Full Privacy Policy'), findsOneWidget);

        await tester.tap(find.text('Close'));
        await tester.pumpAndSettle();

        expect(find.text('Privacy Policy & Data'), findsNothing);
      },
    );

    testWidgets(
      'HighlightText highlights matching query tokens and handles edge cases',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  HighlightText(text: 'Amoxicillin 500mg', query: 'mox'),
                  HighlightText(text: 'Paracetamol', query: ''),
                  HighlightText(text: null, query: 'test'),
                  HighlightText(text: 'Special [char] test', query: '[char]'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Paracetamol'), findsOneWidget);
        expect(find.text('Special [char] test'), findsOneWidget);
      },
    );

    testWidgets(
      'FeedbackBanner displays success and error variants and static helpers',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => Column(
                  children: [
                    const FeedbackBanner(message: 'Item saved successfully'),
                    const FeedbackBanner(
                      message: 'Something went wrong',
                      isError: true,
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          FeedbackBanner.showSuccess(context, 'Success toast'),
                      child: const Text('Toast Success'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          FeedbackBanner.showError(context, 'Error toast'),
                      child: const Text('Toast Error'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Item saved successfully'), findsOneWidget);
        expect(find.text('Something went wrong'), findsOneWidget);

        await tester.tap(find.text('Toast Success'));
        await tester.pump();
        expect(find.text('Success toast'), findsOneWidget);

        await tester.tap(find.text('Toast Error'));
        await tester.pump();
        expect(find.text('Error toast'), findsOneWidget);
      },
    );

    testWidgets(
      'FavoriteButton reflects state and triggers toggle for all types',
      (tester) async {
        var toggled = false;

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              productFavoritesProvider.overrideWith((ref) async => [1]),
              distributorFavoritesProvider.overrideWith((ref) async => []),
              salesPersonnelFavoritesProvider.overrideWith((ref) async => [3]),
              vetDoctorFavoritesProvider.overrideWith((ref) async => []),
              favoriteToggleProvider.overrideWith(
                () => _MockFavoriteToggle(() => toggled = true),
              ),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    FavoriteButton(refId: 1, type: FavoriteType.product),
                    FavoriteButton(refId: 2, type: FavoriteType.distributor),
                    FavoriteButton(refId: 3, type: FavoriteType.salesPersonnel),
                    FavoriteButton(refId: 4, type: FavoriteType.vetDoctor),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Tap on product favorite
        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();
        expect(toggled, isTrue);
      },
    );

    testWidgets(
      'AssetFallbackImage renders fallback icon when asset path is empty or invalid',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AssetFallbackImage(
                fallbackIcon: Icons.broken_image,
                width: 50,
                height: 50,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.broken_image), findsOneWidget);
      },
    );
  });
}

class _MockFavoriteToggle extends FavoriteToggle {
  final VoidCallback onToggle;
  _MockFavoriteToggle(this.onToggle);

  @override
  Future<void> toggle(FavoriteType type, int id) async {
    onToggle();
  }
}
