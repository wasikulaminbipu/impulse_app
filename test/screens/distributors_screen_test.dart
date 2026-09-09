import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/distributor.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/stakeholder_provider.dart';
import 'package:impulse_app/screens/distributors_screen.dart';

class _MockLanguageSetting extends LanguageSetting {
  final String _initial;
  _MockLanguageSetting(this._initial);

  @override
  String build() => _initial;

  @override
  Future<void> toggle() async {
    state = state == 'en' ? 'bn' : 'en';
  }
}

class _MockPaginatedDistributors extends PaginatedDistributors {
  final List<DistributorWithLocation> _distributors;
  _MockPaginatedDistributors(this._distributors);

  @override
  Future<PaginatedState<DistributorWithLocation>> build() async {
    return PaginatedState<DistributorWithLocation>(
      items: _distributors,
      hasMore: false,
    );
  }
}

void main() {
  final testDate = DateTime(2026);

  final mockDistributor = DistributorWithLocation(
    distributor: Distributor(
      id: 1,
      nameEn: 'M/S Green Agro Traders',
      nameBn: 'মেসার্স গ্রিন এগ্রো ট্রেডার্স',
      designation: 'Proprietor: Md. Kamal Hossain',
      addressEn: 'Station Road, Mymensingh',
      addressBn: 'স্টেশন রোড, ময়মনসিংহ',
      mobile: '01711000000',
      createdAt: testDate,
      updatedAt: testDate,
    ),
    area: const Area(
      id: 5,
      regionId: 2,
      nameEn: 'Mymensingh Area',
      nameBn: 'ময়মনসিংহ এলাকা',
    ),
    region: const Region(
      id: 2,
      nameEn: 'Dhaka North Region',
      nameBn: 'ঢাকা উত্তর অঞ্চল',
    ),
  );

  Widget createHarness({
    required Widget child,
    String lang = 'en',
    List<DistributorWithLocation>? distributors,
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _MockLanguageSetting(lang)),
        distributorFavoritesProvider.overrideWith((ref) async => [1]),
        paginatedDistributorsProvider.overrideWith(
          () => _MockPaginatedDistributors(distributors ?? []),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('DistributorsScreen Widget Tests', () {
    testWidgets(
      'renders empty state in English and toggles language to Bengali',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createHarness(child: const DistributorsScreen(), distributors: []),
        );
        await tester.pumpAndSettle();

        expect(find.text('Distributors List'), findsOneWidget);
        expect(find.text('No distributors found'), findsOneWidget);

        // Tap language switch icon in AppBar
        await tester.tap(find.byIcon(Icons.language));
        await tester.pumpAndSettle();

        expect(find.text('ডিস্ট্রিবিউটর তালিকা'), findsOneWidget);
        expect(find.text('কোনো তথ্য পাওয়া যায়নি'), findsOneWidget);
      },
    );

    testWidgets(
      'renders distributor card with details, area, and region badges',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createHarness(
            child: const DistributorsScreen(),
            distributors: [mockDistributor],
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('M/S Green Agro Traders'), findsOneWidget);
        expect(find.text('Proprietor: Md. Kamal Hossain'), findsOneWidget);
        expect(find.textContaining('Mymensingh Area'), findsOneWidget);
        expect(find.textContaining('Dhaka North Region'), findsOneWidget);
        expect(find.text('01711000000'), findsOneWidget);
      },
    );
  });
}
