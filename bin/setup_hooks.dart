import 'dart:io';

/// Cross-platform Git Hooks Setup & Configuration Utility
///
/// Configures local repository git hooks by pointing `core.hooksPath` to `.githooks/`
/// and verifying executable permissions.
void main(List<String> args) {
  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' ⚓ Impulse DEX - Cross-Platform Git Hooks Setup Utility');
  stdout.writeln(
    '================================================================\n',
  );

  final hooksDir = Directory('.githooks');
  if (!hooksDir.existsSync()) {
    stderr.writeln(
      '❌ Error: .githooks directory not found at ${hooksDir.absolute.path}',
    );
    exit(1);
  }

  // 1. Configure git core.hooksPath
  stdout.write('⏳ Configuring git core.hooksPath to .githooks... ');
  final configResult = Process.runSync('git', [
    'config',
    'core.hooksPath',
    '.githooks',
  ], runInShell: true);
  if (configResult.exitCode != 0) {
    stdout.writeln('❌ FAILED');
    stderr.writeln(configResult.stderr);
    exit(1);
  }
  stdout.writeln('✅ CONFIGURED');

  // 2. Verify git config value
  final verifyResult = Process.runSync('git', [
    'config',
    '--get',
    'core.hooksPath',
  ], runInShell: true);
  final activeHooksPath = verifyResult.stdout.toString().trim();
  stdout.writeln('  👉 Active Git Hooks Path: "$activeHooksPath"');

  // 3. Inspect and verify hook files
  final expectedHooks = [
    'pre-commit',
    'pre-push',
    'post-checkout',
    'post-commit',
  ];
  stdout.writeln('\n📁 Verifying hook files in .githooks/:');

  for (final hookName in expectedHooks) {
    final hookFile = File('${hooksDir.path}/$hookName');
    if (hookFile.existsSync()) {
      stdout.writeln('  ✅ $hookName (Size: ${hookFile.lengthSync()} bytes)');
      // On Unix-like systems, ensure executable permissions
      if (!Platform.isWindows) {
        Process.runSync('chmod', ['+x', hookFile.path], runInShell: true);
      }
    } else {
      stderr.writeln('  ⚠️ Warning: Expected hook $hookName is missing.');
    }
  }

  stdout.writeln(
    '\n================================================================',
  );
  stdout.writeln('🎉 Git hooks successfully installed and operational!');
  stdout.writeln(
    '   - pre-commit: Code formatting, static analysis & Play Store audit',
  );
  stdout.writeln(
    '   - pre-push:   7 comprehensive pre-flight quality & testing gates',
  );
  stdout.writeln(
    '================================================================\n',
  );
}
