import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/app_keys.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/providers/app_update_provider.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/services/app_update_service.dart';
import 'package:in_app_update/in_app_update.dart';

class FakeTestUpdateService extends AppUpdateService {
  final AppUpdateInfo? infoToReturn;
  final bool failFlexible;
  final bool failComplete;
  final bool shouldCheckResult;
  bool completeCalled = false;
  int? dismissedVersion;

  FakeTestUpdateService({
    this.infoToReturn,
    this.failFlexible = false,
    this.failComplete = false,
    this.shouldCheckResult = true,
  });

  @override
  Future<bool> shouldCheckForUpdate(dynamic dao, {DateTime? now}) async =>
      shouldCheckResult;

  @override
  Future<void> recordUpdateChecked(dynamic dao, {DateTime? now}) async {}

  @override
  Future<AppUpdateInfo?> checkForUpdate() async => infoToReturn;

  @override
  Future<AppUpdateResult?> startFlexibleUpdate() async {
    return failFlexible ? null : AppUpdateResult.success;
  }

  @override
  Future<bool> completeFlexibleUpdate() async {
    completeCalled = true;
    return !failComplete;
  }

  @override
  Future<bool> shouldPromptUser(
    dynamic dao,
    int versionCode, {
    DateTime? now,
  }) async => false; // Prevents opening modal in headless container test

  @override
  Future<void> recordPromptDismissed(
    dynamic dao,
    int versionCode, {
    DateTime? now,
  }) async {
    dismissedVersion = versionCode;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppUpdateNotifier Provider Tests', () {
    late AppMaintenanceDb db;
    late ProviderContainer container;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('initial state is idle and hasUpdate is false', () {
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
        ],
      );

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.idle));
      expect(state.hasUpdate, isFalse);
    });

    test('checkAndPromptUpdate remains idle if no update available', () async {
      final fakeService = FakeTestUpdateService();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container
          .read(appUpdateProvider.notifier)
          .checkAndPromptUpdate(force: true);

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.idle));
      expect(state.hasUpdate, isFalse);
    });

    testWidgets(
      'checkAndPromptUpdate shows auto-dismissing SnackBar without action',
      (WidgetTester tester) async {
        final fakeService = FakeTestUpdateService();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
              appUpdateServiceProvider.overrideWithValue(fakeService),
            ],
            child: MaterialApp(
              scaffoldMessengerKey: AppKeys.rootScaffoldMessengerKey,
              home: const Scaffold(body: SizedBox()),
            ),
          ),
        );

        final testContainer = ProviderScope.containerOf(
          tester.element(find.byType(Scaffold)),
        );

        await testContainer
            .read(appUpdateProvider.notifier)
            .checkAndPromptUpdate(force: true);

        // Let the first SnackBar ("Checking for updates...") finish and dismiss
        await tester.pump(const Duration(seconds: 3));
        await tester.pumpAndSettle();

        // The second SnackBar ("Your app is up to date") is now shown
        expect(find.textContaining('Your app is up to date'), findsOneWidget);
        final SnackBar snackBar = tester.widget(find.byType(SnackBar));
        expect(snackBar.persist, isFalse);
        expect(snackBar.action, isNull);

        // Advance past second SnackBar duration (4 seconds) to trigger timeout dismissal
        await tester.pump(const Duration(seconds: 5));
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsNothing);
      },
    );

    test('flexible update download and completion updates state', () async {
      final fakeService = FakeTestUpdateService();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).startFlexibleUpdate();

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.downloaded));
      expect(state.hasUpdate, isTrue);

      await container.read(appUpdateProvider.notifier).completeFlexibleUpdate();

      expect(fakeService.completeCalled, isTrue);
    });

    test('startFlexibleUpdate reverts to available on failure', () async {
      final fakeService = FakeTestUpdateService(failFlexible: true);
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).startFlexibleUpdate();

      final state = container.read(appUpdateProvider);
      expect(state.status, equals(UpdateStatus.available));
    });

    test(
      'default appUpdateServiceProvider resolves to const AppUpdateService',
      () {
        final defaultContainer = ProviderContainer();
        final service = defaultContainer.read(appUpdateServiceProvider);
        expect(service, isA<AppUpdateService>());
        defaultContainer.dispose();
      },
    );

    test('completeFlexibleUpdate reverts to available on failure', () async {
      final fakeService = FakeTestUpdateService(failComplete: true);
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      // Transition to downloaded first
      await container.read(appUpdateProvider.notifier).startFlexibleUpdate();
      expect(
        container.read(appUpdateProvider).status,
        equals(UpdateStatus.downloaded),
      );

      await container.read(appUpdateProvider.notifier).completeFlexibleUpdate();
      expect(
        container.read(appUpdateProvider).status,
        equals(UpdateStatus.available),
      );
    });

    test('dismissPrompt records prompt dismissal via service', () async {
      final fakeService = FakeTestUpdateService();
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).dismissPrompt(105);
      expect(fakeService.dismissedVersion, equals(105));
    });

    test('checkAndPromptUpdate with force: false does not check when shouldCheck is false', () async {
      final fakeService = FakeTestUpdateService(shouldCheckResult: false);
      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appUpdateServiceProvider.overrideWithValue(fakeService),
        ],
      );

      await container.read(appUpdateProvider.notifier).checkAndPromptUpdate();
      expect(
        container.read(appUpdateProvider).status,
        equals(UpdateStatus.idle),
      );
    });
  });
}
