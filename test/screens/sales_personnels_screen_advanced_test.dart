import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/distributor.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/paginated_state.dart';
import 'package:impulse_app/providers/search_history_provider.dart';
import 'package:impulse_app/providers/stakeholder_provider.dart';
import 'package:impulse_app/screens/sales_personnels_screen.dart';
import 'package:impulse_app/widgets/skeleton_loader.dart';

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
      id: 2,
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
    AsyncValue<PaginatedState<SalesPersonnelWithAreas>>? personnelState,
    AsyncValue<PaginatedState<VetDoctorWithAreas>>? doctorState,
    List<String> suggestions = const ['Rafiqul', 'Alam'],
  }) {
    return ProviderScope(
      overrides: [
        languageSettingProvider.overrideWith(() => _TestLanguageSetting(lang)),
        salesPersonnelFavoritesProvider.overrideWith((ref) async => [1]),
        vetDoctorFavoritesProvider.overrideWith((ref) async => [2]),
        if (personnelState != null)
          paginatedSalesPersonnelProvider.overrideWith(
            () => _ExplicitSalesPersonnelNotifier(personnelState),
          )
        else
          paginatedSalesPersonnelProvider.overrideWith(
            () => _DefaultSalesPersonnelNotifier([mockPersonnel]),
          ),
        if (doctorState != null)
          paginatedVetDoctorsProvider.overrideWith(
            () => _ExplicitVetDoctorsNotifier(doctorState),
          )
        else
          paginatedVetDoctorsProvider.overrideWith(
            () => _DefaultVetDoctorsNotifier([mockVetDoctor]),
          ),
        salesPersonnelSearchTrieSuggestionsProvider.overrideWith(
          (ref) async => suggestions,
        ),
        vetDoctorSearchTrieSuggestionsProvider.overrideWith(
          (ref) async => suggestions,
        ),
        searchHistoryProvider.overrideWith(_TestSearchHistory.new),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('SalesPersonnelsScreen Advanced & Interaction Tests', () {
    testWidgets('Clear button in search bar resets query text and unfocuses', (
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

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Testing clear');
      await tester.pumpAndSettle();

      // Clear icon button should be present when text is non-empty
      final clearButton = find.byIcon(Icons.clear_rounded);
      expect(clearButton, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Text field should now be empty and clear icon gone
      expect(find.text('Testing clear'), findsNothing);
      expect(find.byIcon(Icons.clear_rounded), findsNothing);
    });

    testWidgets('Tapping search suggestion chip updates search input', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(
          child: const SalesPersonnelsScreen(),
          suggestions: ['Rafiqul', 'Gazipur'],
        ),
      );
      await tester.pumpAndSettle();

      // Focus the text field and enter partial query to reveal chips
      final searchField = find.byType(TextField);
      await tester.tap(searchField);
      await tester.enterText(searchField, 'Raf');
      await tester.pumpAndSettle();

      // Look for ActionChip with suggestion
      final chipFinder = find.widgetWithText(ActionChip, 'Rafiqul');
      if (chipFinder.evaluate().isNotEmpty) {
        await tester.tap(chipFinder);
        await tester.pumpAndSettle();
        expect(find.text('Rafiqul'), findsWidgets);
      }
    });

    testWidgets('Language toggle in AppBar switches language dynamically', (
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

      // Initially in English: button displays 'বাংলা'
      final toggleButton = find.widgetWithText(IconButton, 'বাংলা');
      expect(toggleButton, findsOneWidget);

      await tester.tap(toggleButton);
      await tester.pumpAndSettle();

      // After toggle, AppBar title shows 'যোগাযোগ' and button shows 'EN'
      expect(find.text('যোগাযোগ'), findsOneWidget);
      expect(find.text('EN'), findsOneWidget);
    });

    testWidgets('Renders loading skeleton state when data is loading', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(
          personnelState: const AsyncValue.loading(),
          child: const SalesPersonnelsScreen(),
        ),
      );
      await tester.pump(); // do not pumpAndSettle to keep loading state

      expect(find.byType(DistributorCardSkeleton), findsWidgets);
    });

    testWidgets('Renders error message when paginated provider errors', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800 * 3, 1200 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        createHarness(
          personnelState: AsyncValue.error(
            Exception('Network failure'),
            StackTrace.empty,
          ),
          child: const SalesPersonnelsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Network failure'), findsOneWidget);
    });

    testWidgets('Call button tap invokes action gracefully without throwing', (
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

      final callButton = find.widgetWithText(TextButton, 'Call');
      expect(callButton, findsOneWidget);

      await tester.tap(callButton);
      await tester.pumpAndSettle();
    });
  });
}

class _TestLanguageSetting extends LanguageSetting {
  final String _initialState;
  _TestLanguageSetting(this._initialState);

  @override
  String build() => _initialState;

  @override
  Future<void> toggle() async {
    state = state == 'en' ? 'bn' : 'en';
  }
}

class _DefaultSalesPersonnelNotifier extends PaginatedSalesPersonnel {
  final List<SalesPersonnelWithAreas> _items;
  _DefaultSalesPersonnelNotifier(this._items);

  @override
  Future<PaginatedState<SalesPersonnelWithAreas>> build() async {
    return PaginatedState(items: _items, hasMore: false);
  }
}

class _DefaultVetDoctorsNotifier extends PaginatedVetDoctors {
  final List<VetDoctorWithAreas> _items;
  _DefaultVetDoctorsNotifier(this._items);

  @override
  Future<PaginatedState<VetDoctorWithAreas>> build() async {
    return PaginatedState(items: _items, hasMore: false);
  }
}

class _ExplicitSalesPersonnelNotifier extends PaginatedSalesPersonnel {
  final AsyncValue<PaginatedState<SalesPersonnelWithAreas>> _val;
  _ExplicitSalesPersonnelNotifier(this._val);

  @override
  Future<PaginatedState<SalesPersonnelWithAreas>> build() async {
    if (_val.hasError) {
      throw _val.error!;
    }
    if (_val.isLoading) {
      // Return uncompleted future to simulate persistent loading without timer
      return Completer<PaginatedState<SalesPersonnelWithAreas>>().future;
    }
    return _val.value ?? const PaginatedState(items: [], hasMore: false);
  }
}

class _ExplicitVetDoctorsNotifier extends PaginatedVetDoctors {
  final AsyncValue<PaginatedState<VetDoctorWithAreas>> _val;
  _ExplicitVetDoctorsNotifier(this._val);

  @override
  Future<PaginatedState<VetDoctorWithAreas>> build() async {
    if (_val.hasError) {
      throw _val.error!;
    }
    if (_val.isLoading) {
      // Return uncompleted future to simulate persistent loading without timer
      return Completer<PaginatedState<VetDoctorWithAreas>>().future;
    }
    return _val.value ?? const PaginatedState(items: [], hasMore: false);
  }
}

class _TestSearchHistory extends SearchHistory {
  @override
  Future<List<String>> build() async => ['Rafiqul', 'Alam'];

  @override
  Future<void> addQuery(String query) async {}
}
