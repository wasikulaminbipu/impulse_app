import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_review_provider.dart';
import 'package:impulse_app/providers/app_update_provider.dart';
import 'package:impulse_app/providers/database_provider.dart';
import 'package:impulse_app/services/app_review_service.dart';
import 'package:impulse_app/widgets/feedback_dialog.dart';

class MockUrlLauncherWrapper extends UrlLauncherWrapper {
  bool launched = false;
  Uri? lastUri;

  @override
  Future<bool> launch(Uri uri, {dynamic mode}) async {
    launched = true;
    lastUri = uri;
    return true;
  }

  @override
  Future<bool> canLaunch(Uri uri) async => true;
}

void main() {
  group('AppReviewNotifier Tests', () {
    late AppMaintenanceDb db;
    late MockUrlLauncherWrapper mockLauncher;
    late ProviderContainer container;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      mockLauncher = MockUrlLauncherWrapper();

      container = ProviderContainer(
        overrides: [
          appMaintenanceDatabaseProvider.overrideWith((ref) async => db),
          appReviewServiceProvider.overrideWith(
            (ref) => AppReviewService(launcher: mockLauncher),
          ),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('build initializes AppReviewNotifier without error', () {
      final notifier = container.read(appReviewProvider.notifier);
      expect(notifier, isNotNull);
    });

    test('openPlayStore marks rated and launches store URL', () async {
      final notifier = container.read(appReviewProvider.notifier);
      final success = await notifier.openPlayStore();

      expect(success, isTrue);
      expect(mockLauncher.launched, isTrue);
      expect(mockLauncher.lastUri?.scheme, equals('market'));

      final dao = await container.read(appMaintenanceDaoProvider.future);
      expect(
        await dao.getSetting(AppReviewService.keyUserActionState),
        equals('rated'),
      );
    });

    test(
      'sendFeedbackEmail invokes email intent with subject and body',
      () async {
        final notifier = container.read(appReviewProvider.notifier);
        final success = await notifier.sendFeedbackEmail(
          feedback: 'Great offline app!',
          recipientEmail: 'support@impulse.com',
        );

        expect(success, isTrue);
        expect(mockLauncher.lastUri?.scheme, equals('mailto'));
        expect(mockLauncher.lastUri?.path, equals('support@impulse.com'));
        expect(
          mockLauncher.lastUri?.queryParameters['body'],
          equals('Great offline app!'),
        );
      },
    );

    test('sendFeedbackWhatsApp invokes WhatsApp URL with message', () async {
      final notifier = container.read(appReviewProvider.notifier);
      final success = await notifier.sendFeedbackWhatsApp(
        feedback: 'Need new products',
        whatsAppTarget: '8801700000000',
      );

      expect(success, isTrue);
      expect(mockLauncher.lastUri?.scheme, equals('https'));
      expect(mockLauncher.lastUri?.host, equals('wa.me'));
      expect(
        mockLauncher.lastUri?.queryParameters['text'],
        contains('Need new products'),
      );
    });

    test(
      'markPostponed, markNeverAskAgain, and markRated update DAO state',
      () async {
        final notifier = container.read(appReviewProvider.notifier);
        final dao = await container.read(appMaintenanceDaoProvider.future);

        await notifier.markPostponed();
        expect(
          await dao.getSetting(AppReviewService.keyUserActionState),
          equals('postponed'),
        );

        await notifier.markNeverAskAgain();
        expect(
          await dao.getSetting(AppReviewService.keyUserActionState),
          equals('never'),
        );

        await notifier.markRated();
        expect(
          await dao.getSetting(AppReviewService.keyUserActionState),
          equals('rated'),
        );
      },
    );

    test(
      'default appReviewServiceProvider resolves to const AppReviewService',
      () {
        final defaultContainer = ProviderContainer();
        final service = defaultContainer.read(appReviewServiceProvider);
        expect(service, isA<AppReviewService>());
        defaultContainer.dispose();
      },
    );

    testWidgets(
      'recordSessionAndCheckPrompt returns early when update is available',
      (tester) async {
        final notifier = container.read(appReviewProvider.notifier);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () =>
                        notifier.recordSessionAndCheckPrompt(context: context),
                    child: const Text('Check Review'),
                  );
                },
              ),
            ),
          ),
        );

        // Force update available state
        container.read(appUpdateProvider.notifier).state = const AppUpdateState(
          status: UpdateStatus.available,
        );

        await tester.tap(find.text('Check Review'));
        await tester.pumpAndSettle();

        // No dialog should be shown
        expect(find.byType(FeedbackDialog), findsNothing);
      },
    );

    testWidgets(
      'recordSessionAndCheckPrompt shows dialog when prompt criteria met',
      (tester) async {
        final dao = await container.read(appMaintenanceDaoProvider.future);
        // Seed criteria: 5 sessions
        await dao.setSetting(AppReviewService.keySessionCount, '5');

        final notifier = container.read(appReviewProvider.notifier);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () =>
                        notifier.recordSessionAndCheckPrompt(context: context),
                    child: const Text('Check Review'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Check Review'));
        await tester.pumpAndSettle();

        expect(find.byType(FeedbackDialog), findsOneWidget);
      },
    );
  });
}
