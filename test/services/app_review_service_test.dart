import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/data/app_databases.dart';
import 'package:impulse_app/data/app_maintenance_dao.dart';
import 'package:impulse_app/services/app_review_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FakeUrlLauncherWrapper extends UrlLauncherWrapper {
  final List<Uri> launchedUris = [];
  bool canLaunchResult = true;
  bool launchResult = true;

  @override
  Future<bool> canLaunch(Uri uri) async => canLaunchResult;

  @override
  Future<bool> launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    launchedUris.add(uri);
    return launchResult;
  }
}

void main() {
  group('AppReviewService Unit Tests', () {
    late AppMaintenanceDb db;
    late AppMaintenanceDao dao;
    late FakeUrlLauncherWrapper fakeLauncher;
    late AppReviewService service;

    setUp(() async {
      db = AppMaintenanceDb(NativeDatabase.memory());
      await db.createMigrator().createAll();
      dao = AppMaintenanceDao(db);
      fakeLauncher = FakeUrlLauncherWrapper();
      service = AppReviewService(launcher: fakeLauncher);
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'recordSession increments count and getSessionCount retrieves it',
      () async {
        expect(await service.getSessionCount(dao), 0);

        final count1 = await service.recordSession(dao);
        expect(count1, 1);
        expect(await service.getSessionCount(dao), 1);

        final count2 = await service.recordSession(dao);
        expect(count2, 2);
        expect(await service.getSessionCount(dao), 2);
      },
    );

    test(
      'shouldShowPrompt returns false if session count is below threshold',
      () async {
        for (int i = 0; i < 4; i++) {
          await service.recordSession(dao);
        }
        expect(await service.shouldShowPrompt(dao), false);
      },
    );

    test(
      'shouldShowPrompt returns true if session count >= 5 and never prompted',
      () async {
        for (int i = 0; i < 5; i++) {
          await service.recordSession(dao);
        }
        expect(await service.shouldShowPrompt(dao), true);
      },
    );

    test(
      'shouldShowPrompt returns false if user previously rated or chose never',
      () async {
        for (int i = 0; i < 6; i++) {
          await service.recordSession(dao);
        }

        await service.markRated(dao);
        expect(await service.shouldShowPrompt(dao), false);

        // Reset and test never
        await dao.setSetting(AppReviewService.keyUserActionState, null);
        expect(await service.shouldShowPrompt(dao), true);

        await service.markNeverAskAgain(dao);
        expect(await service.shouldShowPrompt(dao), false);
      },
    );

    test(
      'cooldown interval of 60 days is strictly respected when postponed',
      () async {
        for (int i = 0; i < 5; i++) {
          await service.recordSession(dao);
        }

        final now = DateTime(2026, 1, 1, 12);
        await service.markPostponed(dao, now: now);

        // Check 30 days later -> should be false
        final daysLater30 = DateTime(2026, 1, 31, 12);
        expect(await service.shouldShowPrompt(dao, now: daysLater30), false);

        // Check 59 days later -> should be false
        final daysLater59 = now.add(const Duration(days: 59));
        expect(await service.shouldShowPrompt(dao, now: daysLater59), false);

        // Check 60 days later -> should be true
        final daysLater60 = now.add(const Duration(days: 60));
        expect(await service.shouldShowPrompt(dao, now: daysLater60), true);
      },
    );

    test(
      'openPlayStoreListing tries market: and falls back to https:',
      () async {
        // First attempt with market: capable
        fakeLauncher.canLaunchResult = true;
        final successMarket = await service.openPlayStoreListing();
        expect(successMarket, true);
        expect(fakeLauncher.launchedUris.last.scheme, 'market');

        // Second attempt when market: fails
        fakeLauncher.canLaunchResult = false;
        final successWeb = await service.openPlayStoreListing();
        expect(successWeb, true);
        expect(fakeLauncher.launchedUris.last.scheme, 'https');
        expect(
          fakeLauncher.launchedUris.last.toString(),
          AppConstants.playStoreUrl,
        );
      },
    );

    test(
      'openFeedbackEmail constructs proper mailto URI with subject and body',
      () async {
        final success = await service.openFeedbackEmail(
          subject: 'My Custom Subject',
          body: 'Here is my review',
        );
        expect(success, true);
        final uri = fakeLauncher.launchedUris.last;
        expect(uri.scheme, 'mailto');
        expect(uri.path, AppConstants.supportEmail);
        expect(uri.queryParameters['subject'], 'My Custom Subject');
        expect(uri.queryParameters['body'], 'Here is my review');
      },
    );

    test(
      'openFeedbackWhatsApp formats telephone digits and query message',
      () async {
        final success = await service.openFeedbackWhatsApp(
          message: 'Hello Support!',
        );
        expect(success, true);
        final uri = fakeLauncher.launchedUris.last;
        expect(uri.host, 'wa.me');
        expect(uri.path, '/8801629389015');
        expect(uri.queryParameters['text'], 'Hello Support!');
      },
    );
  });
}
