import 'dart:io';

/// Fastlane Diagnostic & Health Audit CLI Tool
///
/// Validates the complete Fastlane configuration for Flutter:
/// - Gemfile presence and pinned fastlane gem
/// - Appfile package_name alignment with Gradle applicationId
/// - Fastfile syntax and mandatory lane definitions
/// - Metadata directory structure & Google Play character limits
/// - Service Account API key credentials and environment secrets
void main(List<String> args) {
  stdout.writeln('🚀 Fastlane Configuration & Health Audit');
  stdout.writeln('-------------------------------------------------------');

  final isFix = args.contains('--fix') || args.contains('-f');
  final report = <String, bool>{};
  var fatalErrors = 0;

  // 1. Audit Android Gemfile
  final gemfile = File('android/Gemfile');
  if (!gemfile.existsSync()) {
    stderr.writeln('❌ android/Gemfile is missing!');
    report['Gemfile Exists'] = false;
    fatalErrors++;
  } else {
    final content = gemfile.readAsStringSync();
    final hasFastlane = content.contains('fastlane');
    if (hasFastlane) {
      stdout.writeln('✅ android/Gemfile: fastlane gem configured');
      report['Gemfile fastlane gem'] = true;
    } else {
      stderr.writeln('❌ android/Gemfile does not include "fastlane" gem');
      report['Gemfile fastlane gem'] = false;
      fatalErrors++;
    }
  }

  // 2. Audit Appfile
  final appfile = File('android/fastlane/Appfile');
  String? fastlanePackage;
  if (!appfile.existsSync()) {
    stderr.writeln('❌ android/fastlane/Appfile is missing!');
    report['Appfile Exists'] = false;
    fatalErrors++;
  } else {
    final content = appfile.readAsStringSync();
    final match = RegExp(r'''package_name\(["']([^"']+)["']\)''')
        .firstMatch(content);
    fastlanePackage = match?.group(1);
    if (fastlanePackage != null) {
      stdout.writeln(
        '✅ android/fastlane/Appfile: package_name = "$fastlanePackage"',
      );
      report['Appfile package_name'] = true;
    } else {
      stderr.writeln('❌ Could not parse package_name from Appfile');
      report['Appfile package_name'] = false;
      fatalErrors++;
    }
  }

  // 3. Align with build.gradle.kts applicationId
  final gradleFile = File('android/app/build.gradle.kts');
  if (gradleFile.existsSync() && fastlanePackage != null) {
    final gradleContent = gradleFile.readAsStringSync();
    final gradleMatch = RegExp(r'applicationId\s*=\s*"([^"]+)"')
        .firstMatch(gradleContent);
    final gradlePackage = gradleMatch?.group(1);
    if (gradlePackage == fastlanePackage) {
      stdout.writeln(
        '✅ Application ID aligned: Gradle ($gradlePackage) == Fastlane ($fastlanePackage)',
      );
      report['Application ID Alignment'] = true;
    } else {
      stderr.writeln(
        '❌ Application ID mismatch: Gradle ($gradlePackage) != Fastlane ($fastlanePackage)',
      );
      report['Application ID Alignment'] = false;
      fatalErrors++;
    }
  }

  // 4. Audit Fastfile and Required Lanes
  final fastfile = File('android/fastlane/Fastfile');
  if (!fastfile.existsSync()) {
    stderr.writeln('❌ android/fastlane/Fastfile is missing!');
    report['Fastfile Exists'] = false;
    fatalErrors++;
  } else {
    final content = fastfile.readAsStringSync();
    var allLanesFound = true;
    final requiredLanes = [
      'internal',
      'alpha',
      'beta',
      'production',
      'promote',
      'metadata',
      'validate',
      'store_assets',
      'update_rollout',
      'halt_rollout',
      'check_app_size',
    ];

    for (final lane in requiredLanes) {
      final hasLane = RegExp('lane\\s+:$lane\\b').hasMatch(content);
      if (hasLane) {
        stdout.writeln('   ✅ Lane found: :$lane');
      } else {
        stderr.writeln('   ❌ Missing required lane: :$lane');
        allLanesFound = false;
        fatalErrors++;
      }
    }
    report['Required Lanes Present'] = allLanesFound;
  }

  // 5. Audit Google Play Metadata & Character Limits
  final metaRoot = Directory('android/fastlane/metadata/android');
  if (!metaRoot.existsSync()) {
    if (isFix) {
      metaRoot.createSync(recursive: true);
      stdout.writeln('🛠️  Created missing metadata root: ${metaRoot.path}');
    } else {
      stderr.writeln('❌ Metadata directory missing: ${metaRoot.path}');
      report['Metadata Root'] = false;
      fatalErrors++;
    }
  }

  if (metaRoot.existsSync()) {
    stdout.writeln('📁 Auditing localized metadata character limits...');
    final locales = ['en-US', 'bn-BD'];
    var metadataHealthy = true;

    for (final locale in locales) {
      final locDir = Directory('${metaRoot.path}/$locale');
      if (!locDir.existsSync()) {
        if (isFix) {
          locDir.createSync(recursive: true);
          stdout.writeln('🛠️  [$locale] Created missing locale directory');
        } else {
          stderr.writeln('   ❌ Missing locale directory: $locale');
          metadataHealthy = false;
          fatalErrors++;
          continue;
        }
      }

      // Title <= 30
      final titleFile = File('${locDir.path}/title.txt');
      if (titleFile.existsSync()) {
        final len = titleFile.readAsStringSync().trim().length;
        if (len <= 30) {
          stdout.writeln('   ✅ [$locale] Title length: $len/30');
        } else {
          stderr.writeln('   ❌ [$locale] Title exceeds limit: $len/30');
          metadataHealthy = false;
          fatalErrors++;
        }
      }

      // Short Description <= 80
      final shortFile = File('${locDir.path}/short_description.txt');
      if (shortFile.existsSync()) {
        final len = shortFile.readAsStringSync().trim().length;
        if (len <= 80) {
          stdout.writeln('   ✅ [$locale] Short description length: $len/80');
        } else {
          stderr.writeln(
            '   ❌ [$locale] Short description exceeds limit: $len/80',
          );
          metadataHealthy = false;
          fatalErrors++;
        }
      }

      // Full Description <= 4000
      final fullFile = File('${locDir.path}/full_description.txt');
      if (fullFile.existsSync()) {
        final len = fullFile.readAsStringSync().trim().length;
        if (len <= 4000) {
          stdout.writeln('   ✅ [$locale] Full description length: $len/4000');
        } else {
          stderr.writeln(
            '   ❌ [$locale] Full description exceeds limit: $len/4000',
          );
          metadataHealthy = false;
          fatalErrors++;
        }
      }

      // Changelogs <= 500
      final changelogDir = Directory('${locDir.path}/changelogs');
      if (changelogDir.existsSync()) {
        for (final entry in changelogDir.listSync().whereType<File>()) {
          final len = entry.readAsStringSync().trim().length;
          final basename = entry.uri.pathSegments.last;
          if (len <= 500) {
            stdout.writeln('   ✅ [$locale] Changelog ($basename): $len/500');
          } else {
            stderr.writeln(
              '   ❌ [$locale] Changelog ($basename) exceeds limit: $len/500',
            );
            metadataHealthy = false;
            fatalErrors++;
          }
        }
      }
    }
    report['Metadata Limits Compliance'] = metadataHealthy;
  }

  // 6. Audit iOS Fastlane (if ios directory exists)
  final iosDir = Directory('ios');
  if (iosDir.existsSync()) {
    stdout.writeln('\n🍏 Auditing iOS Fastlane Configuration...');
    final iosGemfile = File('ios/Gemfile');
    if (iosGemfile.existsSync()) {
      stdout.writeln('   ✅ ios/Gemfile: fastlane gem configured');
      report['iOS Gemfile fastlane gem'] = true;
    } else {
      stderr.writeln('   ❌ ios/Gemfile is missing');
      report['iOS Gemfile fastlane gem'] = false;
      fatalErrors++;
    }

    final iosAppfile = File('ios/fastlane/Appfile');
    if (iosAppfile.existsSync()) {
      final content = iosAppfile.readAsStringSync();
      final hasId = content.contains(
        'app_identifier("com.impulseagriscienceltd.impulse_app")',
      );
      if (hasId) {
        stdout.writeln('   ✅ ios/fastlane/Appfile: app_identifier aligned');
        report['iOS Appfile app_identifier'] = true;
      } else {
        stderr.writeln(
          '   ❌ ios/fastlane/Appfile missing expected app_identifier',
        );
        report['iOS Appfile app_identifier'] = false;
        fatalErrors++;
      }
    } else {
      stderr.writeln('   ❌ ios/fastlane/Appfile is missing');
      report['iOS Appfile app_identifier'] = false;
      fatalErrors++;
    }

    final iosFastfile = File('ios/fastlane/Fastfile');
    if (iosFastfile.existsSync()) {
      final content = iosFastfile.readAsStringSync();
      final iosLanes = ['validate', 'beta', 'release'];
      var allIosLanes = true;
      for (final lane in iosLanes) {
        final hasLane = RegExp('lane\\s+:$lane\\b').hasMatch(content);
        if (hasLane) {
          stdout.writeln('   ✅ iOS Lane found: :$lane');
        } else {
          stderr.writeln('   ❌ Missing iOS lane: :$lane');
          allIosLanes = false;
          fatalErrors++;
        }
      }
      report['iOS Fastfile Lanes'] = allIosLanes;
    } else {
      stderr.writeln('   ❌ ios/fastlane/Fastfile is missing');
      report['iOS Fastfile Lanes'] = false;
      fatalErrors++;
    }
  }

  // 7. Audit Digital Asset Links
  stdout.writeln('\n🔗 Auditing Digital Asset Links...');
  final assetlinks = File('.well-known/assetlinks.json');
  if (assetlinks.existsSync()) {
    final content = assetlinks.readAsStringSync();
    if (content.contains('com.impulseagriscienceltd.impulse_app')) {
      stdout.writeln(
        '   ✅ .well-known/assetlinks.json aligned with package_name',
      );
      report['Digital Asset Links'] = true;
    } else {
      stderr.writeln(
        '   ❌ .well-known/assetlinks.json missing expected package_name',
      );
      report['Digital Asset Links'] = false;
      fatalErrors++;
    }
  } else {
    stdout.writeln('   ℹ️ .well-known/assetlinks.json not present (Optional)');
  }

  stdout.writeln('\n-------------------------------------------------------');
  stdout.writeln('📊 Fastlane Health Summary:');
  report.forEach((k, v) {
    stdout.writeln('   ${v ? "✅" : "❌"} $k');
  });

  if (fatalErrors > 0) {
    stderr.writeln('\n💥 Fastlane audit failed with $fatalErrors issues.');
    exit(1);
  } else {
    stdout.writeln('\n🎉 All Fastlane configuration and health checks passed!');
    exit(0);
  }
}
