@Timeout(Duration(minutes: 2))
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fastlane Doctor CLI Tool Tests', () {
    test('bin/fastlane_doctor.dart exists and completes diagnostic checks with exit code 0', () async {
      final scriptFile = File('bin/fastlane_doctor.dart');
      expect(
        scriptFile.existsSync(),
        isTrue,
        reason: 'bin/fastlane_doctor.dart must exist on disk',
      );

      final result = await Process.run('dart', [
        'run',
        'bin/fastlane_doctor.dart',
      ], runInShell: true);

      expect(
        result.exitCode,
        equals(0),
        reason: 'fastlane_doctor.dart failed with stderr: ${result.stderr}',
      );

      final output = result.stdout.toString();
      expect(output, contains('Fastlane Environment & Toolchain Doctor'));
      expect(output, contains('Checking Ruby runtime'));
      expect(output, contains('Checking Flutter SDK'));
      expect(output, contains('Environment Doctor Summary'));
      expect(output, contains('Environment diagnostic completed!'));
    });
  });
}
