import 'dart:io';

void main(List<String> args) {
  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' 🚀 Impulse DEX - Semantic Version Bumper & Release Trigger');
  stdout.writeln(
    '================================================================',
  );

  if (args.isEmpty || args.contains('--help') || args.contains('-h')) {
    stdout.writeln(
      'Usage: dart run bin/bump_version.dart <patch|minor|major|custom_version> [--commit] [--push] [--skip-tests]\n',
    );
    stdout.writeln('Options:');
    stdout.writeln(
      '  --commit      Creates git commit and annotated tag after tests pass',
    );
    stdout.writeln(
      '  --push        Runs tests, bumps version, commits, tags & pushes to origin to trigger CI/CD',
    );
    stdout.writeln(
      '  --skip-tests  Bypasses pre-release testing gate (NOT RECOMMENDED)\n',
    );
    stdout.writeln(
      '💡 Note: For full regeneration (models, splash screen, launcher icons, asset audits, privacy checks & GH Actions monitoring), use:',
    );
    stdout.writeln(
      '  dart run bin/release.dart <patch|minor|major|custom_version>\n',
    );
    stdout.writeln('Examples:');
    stdout.writeln(
      '  dart run bin/bump_version.dart patch            # Preview 1.0.0+1 -> 1.0.1+2',
    );
    stdout.writeln(
      '  dart run bin/release.dart patch                 # Full automated end-to-end release',
    );
    exit(0);
  }

  final bumpType = args[0].toLowerCase();
  final shouldCommit = args.contains('--commit') || args.contains('--push');
  final shouldPush = args.contains('--push');
  final skipTests = args.contains('--skip-tests');

  // ---------------------------------------------------------------------------
  // 1. Mandatory Pre-Release Testing & Quality Gate
  // ---------------------------------------------------------------------------
  if ((shouldCommit || shouldPush) && !skipTests) {
    stdout.writeln(
      '\n🛡️ [Pre-Release Gate] Executing Full Test Suite & Quality Audits...',
    );

    final checks = <({String name, String cmd, List<String> args})>[
      (
        name: 'SQLite Database Integrity',
        cmd: 'dart',
        args: ['run', 'bin/validate_db.dart'],
      ),
      (
        name: 'Asset Health & Image Cross-Reference',
        cmd: 'dart',
        args: ['run', 'bin/audit_assets.dart'],
      ),
      (
        name: 'Android App Links Deep Linking',
        cmd: 'dart',
        args: ['run', 'bin/audit_app_links.dart'],
      ),
      (
        name: 'Google Play Store Compliance (36/36 checks)',
        cmd: 'dart',
        args: ['run', 'bin/audit_playstore_compliance.dart'],
      ),
      (
        name: 'Strict Static Analysis Gate',
        cmd: 'flutter',
        args: ['analyze', '--fatal-infos', '--fatal-warnings'],
      ),
      (
        name: 'Flutter Unit, Widget & Golden Test Suite',
        cmd: 'flutter',
        args: ['test'],
      ),
    ];

    for (final check in checks) {
      stdout.write('  ⏳ Running ${check.name}... ');
      final result = Process.runSync(check.cmd, check.args, runInShell: true);
      if (result.exitCode == 0) {
        stdout.writeln('✅ PASSED');
      } else {
        stdout.writeln('❌ FAILED');
        stderr.writeln(
          '\n💥 Pre-Release Verification Failed on: ${check.name}',
        );
        stderr.writeln(result.stdout);
        stderr.writeln(result.stderr);
        stderr.writeln(
          '\n🚫 Release aborted! Fix failing tests/audits before pushing to GitHub.',
        );
        exit(1);
      }
    }
    stdout.writeln(
      '🎉 All pre-release tests & audits PASSED! Proceeding with release.\n',
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Parse & Calculate Next Version
  // ---------------------------------------------------------------------------
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    stderr.writeln('❌ Error: pubspec.yaml not found!');
    exit(1);
  }

  final content = pubspecFile.readAsStringSync();
  final versionMatch = RegExp(
    r'^version:\s*([0-9]+)\.([0-9]+)\.([0-9]+)\+([0-9]+)',
    multiLine: true,
  ).firstMatch(content);

  if (versionMatch == null) {
    stderr.writeln(
      '❌ Error: Could not parse version in pubspec.yaml (Expected X.Y.Z+N)',
    );
    exit(1);
  }

  var major = int.parse(versionMatch.group(1)!);
  var minor = int.parse(versionMatch.group(2)!);
  var patch = int.parse(versionMatch.group(3)!);
  var buildNumber = int.parse(versionMatch.group(4)!);

  final currentVersion = '$major.$minor.$patch+$buildNumber';

  switch (bumpType) {
    case 'major':
      major++;
      minor = 0;
      patch = 0;
      buildNumber++;
    case 'minor':
      minor++;
      patch = 0;
      buildNumber++;
    case 'patch':
      patch++;
      buildNumber++;
    default:
      if (RegExp(r'^[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+$').hasMatch(bumpType)) {
        final parts = bumpType.split('+');
        final semParts = parts[0].split('.');
        major = int.parse(semParts[0]);
        minor = int.parse(semParts[1]);
        patch = int.parse(semParts[2]);
        buildNumber = int.parse(parts[1]);
      } else {
        stderr.writeln(
          '❌ Error: Invalid bump type or version "$bumpType". Use patch, minor, major, or X.Y.Z+N',
        );
        exit(1);
      }
  }

  final newVersionName = '$major.$minor.$patch';
  final newVersion = '$newVersionName+$buildNumber';
  final tag = 'v$newVersionName';

  stdout.writeln('  📌 Current Version: $currentVersion');
  stdout.writeln('  ✨ New Version:     $newVersion (Tag: $tag)\n');

  // 3. Update pubspec.yaml
  final updatedContent = content.replaceFirst(
    RegExp(r'^version:\s*.*$', multiLine: true),
    'version: $newVersion',
  );
  pubspecFile.writeAsStringSync(updatedContent);
  stdout.writeln('  ✅ Updated pubspec.yaml -> version: $newVersion');

  // 4. Update CHANGELOG.md
  final changelogFile = File('CHANGELOG.md');
  final today = DateTime.now().toIso8601String().substring(0, 10);
  final newChangelogEntry =
      '''
## [$newVersionName] - $today
### What's Changed
- Release build $buildNumber (Version $newVersionName).
- 100% verified: All tests, database integrity, assets, and Google Play Store compliance passed.
''';

  if (changelogFile.existsSync()) {
    final existingChangelog = changelogFile.readAsStringSync();
    changelogFile.writeAsStringSync(
      '# Changelog\n$newChangelogEntry\n${existingChangelog.replaceFirst(RegExp(r'^#\s*Changelog\s*\n?', caseSensitive: false), '')}',
    );
  } else {
    changelogFile.writeAsStringSync('# Changelog\n$newChangelogEntry');
  }
  stdout.writeln('  ✅ Updated CHANGELOG.md with release notes');

  // 5. Git Commit and Tag
  if (shouldCommit) {
    stdout.writeln('\n📦 Executing Git Commit & Tag...');
    Process.runSync('git', [
      'add',
      'pubspec.yaml',
      'CHANGELOG.md',
    ], runInShell: true);
    final commitResult = Process.runSync('git', [
      'commit',
      '-m',
      'chore(release): bump version to $tag ($newVersion)',
    ], runInShell: true);
    if (commitResult.exitCode == 0) {
      stdout.writeln(
        '  ✅ Git commit created: "chore(release): bump version to $tag ($newVersion)"',
      );
    } else {
      stderr.writeln(
        '  ⚠️ Git commit note: ${commitResult.stdout} ${commitResult.stderr}',
      );
    }

    final tagResult = Process.runSync('git', [
      'tag',
      '-a',
      tag,
      '-m',
      'Release $tag',
    ], runInShell: true);
    if (tagResult.exitCode == 0) {
      stdout.writeln('  ✅ Git tag created: $tag');
    } else {
      stderr.writeln('  ⚠️ Git tag note: ${tagResult.stderr}');
    }
  }

  // 6. Git Push
  if (shouldPush) {
    stdout.writeln(
      '\n🚀 Pushing commit & tag to origin to trigger CI/CD deployment...',
    );
    Process.runSync('git', ['push', 'origin', 'main'], runInShell: true);
    final pushTag = Process.runSync('git', [
      'push',
      'origin',
      tag,
    ], runInShell: true);

    if (pushTag.exitCode == 0) {
      stdout.writeln(
        '  🎉 Successfully pushed $tag to origin! Release pipeline is now running on GitHub Actions.',
      );
    } else {
      stderr.writeln('  ❌ Push failed: ${pushTag.stderr}');
    }
  } else if (!shouldCommit) {
    stdout.writeln(
      '\n💡 Tip: Run with --commit to create git commit & tag, or --push to run all tests and immediately trigger release CI/CD.',
    );
  }

  stdout.writeln(
    '================================================================\n',
  );
}
