import 'dart:io';

/// Fastlane Standardized en-US Changelog Generator CLI Tool
///
/// Automatically generates and syncs release notes for Fastlane Supply:
/// - Reads version name and build code from pubspec.yaml
/// - Enforces single-language policy (en-US only for all future release notes)
/// - Formats release notes with a clean, standardized structure
/// - Enforces Google Play's strict 500-character limit
/// - Generates changelog files: en-US/changelogs/`[buildNumber]`.txt and default.txt
/// - Automatically removes legacy multi-language changelog directories (e.g. bn-BD)
void main(List<String> args) {
  final isDryRun = args.contains('--dry-run');
  var customNotes = '';

  for (final arg in args) {
    if (arg.startsWith('--notes=')) {
      customNotes = arg.substring(8).trim();
    } else if (arg.startsWith('--bn-notes=')) {
      stdout.writeln(
        'ℹ️ Note: Multi-language release notes are disabled. Using standardized en-US only.',
      );
    }
  }

  stdout.writeln('📝 Fastlane Standardized Changelog Generator (en-US only)');
  stdout.writeln('-------------------------------------------------------');

  // 1. Read version from pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    stderr.writeln('❌ pubspec.yaml not found!');
    exit(1);
  }

  final pubspecContent = pubspecFile.readAsStringSync();
  final versionMatch = RegExp(
    r'^version:\s*([^\s+]+)\+(\d+)',
    multiLine: true,
  ).firstMatch(pubspecContent);

  if (versionMatch == null) {
    stderr.writeln(
      '❌ Could not parse version and build code from pubspec.yaml',
    );
    exit(1);
  }

  final versionName = versionMatch.group(1)!;
  final buildNumber = int.parse(versionMatch.group(2)!);
  stdout.writeln('ℹ️  Target Version: v$versionName (Build $buildNumber)');

  // 2. Resolve commits if no custom notes provided
  List<String>? commitBullets;
  if (customNotes.isEmpty) {
    final gitResult = Process.runSync('git', [
      'log',
      '-n',
      '5',
      '--pretty=format:%s',
    ], runInShell: true);

    if (gitResult.exitCode == 0 &&
        gitResult.stdout.toString().trim().isNotEmpty) {
      commitBullets = gitResult.stdout
          .toString()
          .trim()
          .split('\n')
          .where(
            (line) =>
                !line.contains('Merge ') && !line.contains('chore(release)'),
          )
          .take(3)
          .toList();
    }
  }

  // 3. Format Standardized en-US Release Notes
  final changelogText = formatStandardReleaseNotes(
    versionName: versionName,
    buildNumber: buildNumber,
    customNotes: customNotes.isNotEmpty ? customNotes : null,
    commitBullets: commitBullets,
  );

  stdout.writeln(
    '\n📄 [en-US] Standardized Changelog Preview (${changelogText.length}/500 chars):',
  );
  stdout.writeln(changelogText);
  stdout.writeln('-------------------------------------------------------');

  if (isDryRun) {
    stdout.writeln('🔎 Dry-run mode: No files were modified.');
    exit(0);
  }

  // 4. Ensure legacy bn-BD changelog directory is removed
  final legacyBnDir = Directory(
    'android/fastlane/metadata/android/bn-BD/changelogs',
  );
  if (legacyBnDir.existsSync()) {
    legacyBnDir.deleteSync(recursive: true);
    stdout.writeln('🧹 Cleaned up legacy bn-BD changelogs directory');
  }

  // 5. Write to en-US changelog directory
  final enDir = Directory('android/fastlane/metadata/android/en-US/changelogs');
  if (!enDir.existsSync()) {
    enDir.createSync(recursive: true);
  }

  final targetFile = File('${enDir.path}/$buildNumber.txt');
  final defaultFile = File('${enDir.path}/default.txt');

  targetFile.writeAsStringSync(changelogText);
  defaultFile.writeAsStringSync(changelogText);
  stdout.writeln(
    '✅ Written: ${targetFile.path} (${changelogText.length} chars)',
  );
  stdout.writeln(
    '✅ Written: ${defaultFile.path} (${changelogText.length} chars)',
  );

  stdout.writeln(
    '\n🎉 Fastlane standardized en-US changelogs generated successfully!',
  );
}

/// Builds a standardized, professional release note within Google Play's 500-char limit
String formatStandardReleaseNotes({
  required String versionName,
  int? buildNumber,
  String? customNotes,
  List<String>? commitBullets,
}) {
  final buffer = StringBuffer("What's new in v$versionName:\n");
  final bullets = <String>[];

  if (customNotes != null && customNotes.trim().isNotEmpty) {
    final lines = customNotes
        .split(RegExp(r'[\r\n]+'))
        .map((l) => l.trim().replaceFirst(RegExp(r'^[•\-\*]\s*'), ''))
        .where((l) => l.isNotEmpty);
    bullets.addAll(lines);
  } else if (commitBullets != null && commitBullets.isNotEmpty) {
    for (final commit in commitBullets) {
      final clean = commit.trim().replaceFirst(RegExp(r'^[•\-\*]\s*'), '');
      if (clean.isNotEmpty) {
        bullets.add(clean);
      }
    }
  }

  final hasDbNote = bullets.any(
    (b) =>
        b.toLowerCase().contains('database') ||
        b.toLowerCase().contains('catalog'),
  );
  final hasPerfNote = bullets.any(
    (b) =>
        b.toLowerCase().contains('performance') ||
        b.toLowerCase().contains('stability') ||
        b.toLowerCase().contains('optimization'),
  );

  if (!hasDbNote && bullets.length < 3) {
    bullets.add('Offline database & product catalog updates');
  }
  if (!hasPerfNote && bullets.length < 4) {
    bullets.add('Performance optimizations & stability improvements');
  }

  if (bullets.isEmpty) {
    bullets.addAll([
      'Offline database & product catalog updates',
      'General performance optimizations',
      'UI refinements & stability improvements',
    ]);
  }

  for (final bullet in bullets) {
    buffer.writeln('• $bullet');
  }

  var result = buffer.toString().trim();
  if (result.length > 500) {
    result = '${result.substring(0, 496)}...';
  }
  return result;
}
