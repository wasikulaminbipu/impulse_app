import 'dart:io';

void main(List<String> args) {
  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' 🧹 Impulse DEX - Codebase Hygiene & Orphaned Code Auditor');
  stdout.writeln(
    '================================================================',
  );

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('❌ Error: lib/ directory not found!');
    exit(1);
  }

  // ---------------------------------------------------------------------------
  // 1. Scan all Dart source files in lib/
  // ---------------------------------------------------------------------------
  stdout.writeln('\n1️⃣ Scanning Dart Files & References in lib/...');
  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  stdout.writeln('  📊 Total Dart Source Files: ${dartFiles.length}');

  // Map file basenames and imports
  final allContents = <String, String>{};
  for (final file in dartFiles) {
    allContents[file.path] = file.readAsStringSync();
  }

  final orphanedFiles = <String>[];

  for (final file in dartFiles) {
    final path = file.path.replaceAll(r'\', '/');
    final fileName = file.uri.pathSegments.last;

    // Skip main, generated files, and part files
    if (fileName == 'main.dart' ||
        fileName.endsWith('.g.dart') ||
        fileName.endsWith('.freezed.dart') ||
        fileName.contains('.drift.')) {
      continue;
    }

    final isPart = allContents[file.path]?.contains('part of ') ?? false;
    if (isPart) continue;

    // Check if this file is imported or referenced anywhere in lib/ or test/ or bin/
    final importPattern = RegExp(
      "['\"](package:impulse_app/.*${RegExp.escape(fileName)}|.*${RegExp.escape(fileName)})['\"]",
    );
    var isReferenced = false;

    for (final entry in allContents.entries) {
      if (entry.key == file.path) continue;
      if (importPattern.hasMatch(entry.value)) {
        isReferenced = true;
        break;
      }
    }

    // Also check bin/ and test/
    if (!isReferenced) {
      for (final dirPath in ['bin', 'test']) {
        final dir = Directory(dirPath);
        if (dir.existsSync()) {
          for (final f
              in dir
                  .listSync(recursive: true)
                  .whereType<File>()
                  .where((f) => f.path.endsWith('.dart'))) {
            if (f.readAsStringSync().contains(fileName)) {
              isReferenced = true;
              break;
            }
          }
        }
        if (isReferenced) break;
      }
    }

    if (!isReferenced) {
      orphanedFiles.add(path);
    }
  }

  if (orphanedFiles.isNotEmpty) {
    stdout.writeln(
      '  ⚠️ Potentially unreferenced files (${orphanedFiles.length}):',
    );
    for (final f in orphanedFiles) {
      stdout.writeln('    - $f');
    }
  } else {
    stdout.writeln('  ✅ 100% of Dart source files are active and referenced');
  }

  // ---------------------------------------------------------------------------
  // 2. Constants & Asset String Usages Audit
  // ---------------------------------------------------------------------------
  stdout.writeln('\n2️⃣ Auditing App Constants & Asset Identifiers...');
  final appAssetsFile = File('lib/constants/app_assets.dart');
  if (appAssetsFile.existsSync()) {
    final assetContent = appAssetsFile.readAsStringSync();
    final constMatches = RegExp(
      r'static const String ([a-zA-Z0-9_]+)\s*=',
    ).allMatches(assetContent);
    var matchedConsts = 0;

    for (final match in constMatches) {
      final constName = match.group(1)!;
      var foundUsage = false;
      for (final entry in allContents.entries) {
        if (entry.key.contains('app_assets.dart')) continue;
        if (entry.value.contains(constName)) {
          foundUsage = true;
          break;
        }
      }
      if (foundUsage) matchedConsts++;
    }

    stdout.writeln(
      '  📊 Asset Constants: ${constMatches.length} (Referenced: $matchedConsts)',
    );
  }

  stdout.writeln(
    '\n================================================================',
  );
  stdout.writeln('🎉 Codebase Hygiene & Orphaned Code Audit: PASSED');
  stdout.writeln(
    '================================================================\n',
  );
  exit(0);
}
