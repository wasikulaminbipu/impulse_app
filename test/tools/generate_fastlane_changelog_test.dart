@Timeout(Duration(minutes: 2))
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fastlane Changelog Generator CLI Tool Tests', () {
    test(
      'bin/generate_fastlane_changelog.dart runs with --dry-run and exits 0',
      () async {
        final scriptFile = File('bin/generate_fastlane_changelog.dart');
        expect(
          scriptFile.existsSync(),
          isTrue,
          reason: 'bin/generate_fastlane_changelog.dart must exist on disk',
        );

        final result = await Process.run('dart', [
          'run',
          'bin/generate_fastlane_changelog.dart',
          '--dry-run',
        ], runInShell: true);

        expect(result.exitCode, equals(0), reason: 'stderr: ${result.stderr}');
        final output = result.stdout.toString();
        expect(output, contains('Fastlane Localized Changelog Generator'));
        expect(output, contains('Target Version:'));
        expect(output, contains('Changelog Preview'));
        expect(output, contains('/500 chars'));
        expect(output, contains('Dry-run mode'));
      },
    );

    test(
      'bin/generate_fastlane_changelog.dart supports custom --notes parameter',
      () async {
        const customNote =
            'Automated test release notes verifying clamping functionality.';
        final result = await Process.run('dart', [
          'run',
          'bin/generate_fastlane_changelog.dart',
          '--dry-run',
          '--notes=$customNote',
        ], runInShell: true);

        expect(result.exitCode, equals(0));
        final output = result.stdout.toString();
        expect(output, contains(customNote));
      },
    );
  });
}
