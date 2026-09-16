import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fastlane Health Audit CLI Tool Tests', () {
    test('bin/audit_fastlane.dart exists and runs successfully with exit code 0', () async {
      final scriptFile = File('bin/audit_fastlane.dart');
      expect(
        scriptFile.existsSync(),
        isTrue,
        reason: 'bin/audit_fastlane.dart must exist on disk',
      );

      // Execute audit_fastlane.dart as a standalone subprocess
      final result = await Process.run('dart', [
        'run',
        'bin/audit_fastlane.dart',
      ], runInShell: true);

      // Verify the process exits successfully
      expect(
        result.exitCode,
        equals(0),
        reason:
            'audit_fastlane.dart failed with output:\nSTDOUT:\n${result.stdout}\nSTDERR:\n${result.stderr}',
      );

      final stdoutText = result.stdout.toString();
      expect(stdoutText, contains('Fastlane Configuration & Health Audit'));
      expect(stdoutText, contains('Gemfile fastlane gem'));
      expect(stdoutText, contains('Appfile package_name'));
      expect(stdoutText, contains('Application ID Alignment'));
      expect(stdoutText, contains('Required Lanes Present'));
      expect(stdoutText, contains('Custom Fastlane Actions'));
      expect(stdoutText, contains('Metadata Limits Compliance'));
      expect(stdoutText, contains('iOS Fastfile Lanes'));
      expect(stdoutText, contains('Digital Asset Links'));
      expect(
        stdoutText,
        contains('All Fastlane configuration and health checks passed!'),
      );
    });
  });
}
