import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/distributor.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/search_history_provider.dart';
import 'package:impulse_app/providers/stakeholder_provider.dart';
import 'package:impulse_app/screens/sales_personnels_screen.dart';

void main() {
  final testDate = DateTime(2026);

  final mockPersonnel = SalesPersonnelWithAreas(
    personnel: SalesPersonnel(
      id: 1,
      nameEn: 'Md. Rafiqul Islam',
      nameBn: 'মো: রফিকুল ইসলাম',
      designation: 'Territory Officer',
      mobile: '01712000000',
      email: 'rafiq@impulse.com',
      employeeId: 'EMP001',
      createdAt: testDate,
      updatedAt: testDate,
    ),
    areas: const [
      Area(
        id: 10,
        regionId: 1,
        nameEn: 'Gazipur Area',
        nameBn: 'গাজীপুর এলাকা',
      ),
    ],
    regions: const [
      Region(id: 1, nameEn: 'Dhaka Region', nameBn: 'ঢাকা অঞ্চল'),
    ],
    bases: const [Base(id: 100, areaId: 10, nameEn: 'Sreepur Base')],
    upazilas: const [
      Upazila(id: 1001, districtId: 1, nameEn: 'Sreepur Upazila'),
    ],
  );

  final mockVetDoctor = VetDoctorWithAreas(
    doctor: VetDoctor(
      id: 1,
      nameEn: 'Dr. Shamsul Alam',
      nameBn: 'ডা: শামসুল আলম',
      qualification: 'DVM, MS',
      specialization: 'Veterinary Consultant',
      mobile: '01713000000',
      email: 'shamsul@impulse.com',
      addressEn: 'Gazipur Sadar',
      createdAt: testDate,
      updatedAt: testDate,
    ),
    areas: const [
      Area(
        id: 10,
        regionId: 1,
        nameEn: 'Gazipur Area',
        nameBn: 'গাজীপুর এলাকা',
      ),
    ],
    regions: const [
      Region(id: 1, nameEn: 'Dhaka Region', nameBn: 'ঢাকা অঞ্চল'),
    ],
    bases: const [Base(id: 100, areaId: 10, nameEn: 'Sreepur Base')],
    upazilas: const [
      Upazila(id: 1001, districtId: 1, nameEn: 'Sreepur Upazila'),
    ],
  );

  Widget createHarness({
    required Widget child,
    String lang = 'en',
    List<SalesPersonnelWithAreas>? personnel,
    List<VetDoctorWithAreas>? doctors,
    List<String> searchHistory = const ['Rafiqul', 'Dhaka'],
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _MockLanguageSetting(lang)),
        salesPersonnelFavoritesProvider.overrideWith((ref) async => [1]),
        vetDoctorFavoritesProvider.overrideWith((ref) async => [1]),
        paginatedSalesPersonnelProvider.overrideWith(
          () => _MockPaginatedSalesPersonnel(personnel ?? [mockPersonnel]),
        ),
        paginatedVetDoctorsProvider.overrideWith(
          () => _MockPaginatedVetDoctors(doctors ?? [mockVetDoctor]),
        ),
        basesWithUpazilasProvider.overrideWith(
          (ref) async => [
            const BaseWithUpazilas(
              base: Base(id: 100, areaId: 10, nameEn: 'Sreepur Base'),
              area: Area(
                id: 10,
                regionId: 1,
                nameEn: 'Gazipur Area',
                nameBn: 'গাজীপুর এলাকা',
              ),
              region: Region(
                id: 1,
                nameEn: 'Dhaka Region',
                nameBn: 'ঢাকা অঞ্চল',
              ),
              upazilas: [
                Upazila(id: 1001, districtId: 1, nameEn: 'Sreepur Upazila'),
              ],
            ),
          ],
        ),
        searchHistoryProvider.overrideWith(
          () => _MockSearchHistory(searchHistory),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('SalesPersonnelsScreen Widget Tests', () {
    testWidgets('Renders Sales Personnel list, cards, badges, and tabs', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(child: const SalesPersonnelsScreen()),
      );
      await tester.pumpAndSettle();

      // Check tab bars
      expect(find.text('Representatives'), findsWidgets);
      expect(find.text('Veterinarians'), findsWidgets);

      // Check personnel card
      expect(find.text('Md. Rafiqul Islam'), findsOneWidget);
      expect(find.text('Territory Officer'), findsOneWidget);
      expect(find.text('01712000000'), findsOneWidget);
      expect(find.textContaining('Gazipur Area'), findsWidgets);
    });

    testWidgets('Switches to Vet Doctors tab and renders doctor card', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(child: const SalesPersonnelsScreen()),
      );
      await tester.pumpAndSettle();

      // Tap on Vet Doctors tab
      await tester.tap(find.text('Veterinarians'));
      await tester.pumpAndSettle();

      expect(find.text('Dr. Shamsul Alam'), findsOneWidget);
      expect(find.text('Veterinary Consultant'), findsOneWidget);
      expect(find.text('01713000000'), findsOneWidget);
    });

    testWidgets(
      'Search input updates text and triggers query synchronization',
      (tester) async {
        tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          createHarness(child: const SalesPersonnelsScreen()),
        );
        await tester.pumpAndSettle();

        final searchField = find.byType(TextField);
        expect(searchField, findsOneWidget);

        await tester.enterText(searchField, 'Rafiqul');
        await tester.pumpAndSettle();

        expect(find.text('Rafiqul'), findsWidgets);
      },
    );

    testWidgets('Renders Bengali text when language is bn', (tester) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(lang: 'bn', child: const SalesPersonnelsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('মো: রফিকুল ইসলাম'), findsOneWidget);
    });

    testWidgets('Empty state renders gracefully when no contacts match', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(
          personnel: const [],
          doctors: const [],
          child: const SalesPersonnelsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No representatives found'), findsOneWidget);
    });
  });
}

class _MockLanguageSetting extends LanguageSetting {
  final String initial;
  _MockLanguageSetting(this.initial);

  @override
  String build() => initial;
}

class _MockPaginatedSalesPersonnel extends PaginatedSalesPersonnel {
  final List<SalesPersonnelWithAreas> _initial;
  _MockPaginatedSalesPersonnel(this._initial);

  @override
  Future<PaginatedState<SalesPersonnelWithAreas>> build() async {
    return PaginatedState(items: _initial, hasMore: false);
  }
}

class _MockPaginatedVetDoctors extends PaginatedVetDoctors {
  final List<VetDoctorWithAreas> _initial;
  _MockPaginatedVetDoctors(this._initial);

  @override
  Future<PaginatedState<VetDoctorWithAreas>> build() async {
    return PaginatedState(items: _initial, hasMore: false);
  }
}

class _MockSearchHistory extends SearchHistory {
  final List<String> _initial;
  _MockSearchHistory(this._initial);

  @override
  Future<List<String>> build() async => _initial;
}
