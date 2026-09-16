import 'dart:io';

/// Fastlane Localized Changelog Generator CLI Tool
///
/// Automatically generates and syncs release notes for Fastlane Supply:
/// - Reads version name and build code from pubspec.yaml
/// - Extracts recent conventional commits from git log (or uses --notes)
/// - Supports optional localized Bengali release notes via --bn-notes
/// - Enforces Google Play's strict 500-character limit per locale
/// - Generates changelog files in en-US and bn-BD
void main(List<String> args) {
  final isDryRun = args.contains('--dry-run');
  var customNotes = '';
  var bnNotes = '';

  for (final arg in args) {
    if (arg.startsWith('--notes=')) {
      customNotes = arg.substring(8).trim();
    } else if (arg.startsWith('--bn-notes=')) {
      bnNotes = arg.substring(11).trim();
    }
  }

  stdout.writeln('📝 Fastlane Localized Changelog Generator');
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

  // 2. Resolve English Changelog Text
  String enChangelogText;
  if (customNotes.isNotEmpty) {
    enChangelogText = '- Release v$versionName: $customNotes';
  } else {
    // Attempt to extract recent git commits since last tag
    final gitResult = Process.runSync('git', [
      'log',
      '-n',
      '5',
      '--pretty=format:- %s',
    ], runInShell: true);

    if (gitResult.exitCode == 0 &&
        gitResult.stdout.toString().trim().isNotEmpty) {
      final commitLines = gitResult.stdout
          .toString()
          .trim()
          .split('\n')
          .where(
            (line) =>
                !line.contains('Merge ') && !line.contains('chore(release)'),
          )
          .take(4)
          .join('\n');

      if (commitLines.isNotEmpty) {
        enChangelogText =
            'Release v$versionName (Build $buildNumber):\n$commitLines';
      } else {
        enChangelogText =
            '- Release v$versionName (Build $buildNumber): General performance improvements, updated asset catalog, and database optimizations.';
      }
    } else {
      enChangelogText =
          '- Release v$versionName (Build $buildNumber): General performance improvements, updated asset catalog, and database optimizations.';
    }
  }

  // 3. Resolve Bengali Changelog Text
  String bnChangelogText;
  if (bnNotes.isNotEmpty) {
    bnChangelogText = '- Release v$versionName: $bnNotes';
  } else {
    bnChangelogText = enChangelogText;
  }

  // 4. Enforce 500-Character Google Play Limit
  if (enChangelogText.length > 500) {
    enChangelogText = '${enChangelogText.substring(0, 496)}...';
  }
  if (bnChangelogText.length > 500) {
    bnChangelogText = '${bnChangelogText.substring(0, 496)}...';
  }

  stdout.writeln(
    '\n📄 [en-US] Changelog Preview (${enChangelogText.length}/500 chars):',
  );
  stdout.writeln(enChangelogText);
  stdout.writeln(
    '\n📄 [bn-BD] Changelog Preview (${bnChangelogText.length}/500 chars):',
  );
  stdout.writeln(bnChangelogText);
  stdout.writeln('-------------------------------------------------------');

  if (isDryRun) {
    stdout.writeln('🔎 Dry-run mode: No files were modified.');
    exit(0);
  }

  // 5. Write to en-US and bn-BD changelog directories
  final localeMap = {'en-US': enChangelogText, 'bn-BD': bnChangelogText};

  for (final entry in localeMap.entries) {
    final locale = entry.key;
    final text = entry.value;
    final changelogDir = Directory(
      'android/fastlane/metadata/android/$locale/changelogs',
    );
    if (!changelogDir.existsSync()) {
      changelogDir.createSync(recursive: true);
    }

    final targetFile = File('${changelogDir.path}/$buildNumber.txt');
    final defaultFile = File('${changelogDir.path}/default.txt');

    targetFile.writeAsStringSync(text);
    defaultFile.writeAsStringSync(text);
    stdout.writeln('✅ Written: ${targetFile.path} (${text.length} chars)');
  }

  stdout.writeln('\n🎉 Fastlane localized changelogs generated successfully!');
}
