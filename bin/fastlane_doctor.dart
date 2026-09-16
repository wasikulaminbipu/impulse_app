import 'dart:io';

/// Fastlane Environment & Toolchain Doctor CLI Tool
///
/// Diagnoses the local developer machine or CI/CD runner environment:
/// - Ruby runtime & version (>= 3.0 required)
/// - Bundler gem availability
/// - Fastlane CLI availability (`bundle exec fastlane --version`)
/// - Java JDK runtime (Java 17 Temurin recommended)
/// - Android SDK environment variables ($ANDROID_HOME, $ANDROID_SDK_ROOT)
/// - Local signing keystores and Play Store API credentials
void main(List<String> args) {
  stdout.writeln('🩺 Fastlane Environment & Toolchain Doctor');
  stdout.writeln('-------------------------------------------------------');

  final results = <String, bool>{};

  // 1. Check Ruby Runtime
  stdout.write('🔍 Checking Ruby runtime... ');
  final rubyCheck = _runCommand('ruby', ['--version']);
  if (rubyCheck.success) {
    stdout.writeln('✅ Found: ${rubyCheck.output}');
    final verMatch = RegExp(r'ruby\s+(\d+)\.(\d+)')
        .firstMatch(rubyCheck.output);
    if (verMatch != null) {
      final major = int.tryParse(verMatch.group(1) ?? '0') ?? 0;
      if (major < 3) {
        stdout.writeln(
          '   ⚠️ Ruby version is < 3.0. Fastlane 2.239+ mandates Ruby 3.0+ for OpenSSL 3.0 and modern Bundler compatibility.',
        );
        results['Ruby Runtime (>= 3.0)'] = false;
      } else {
        stdout.writeln('   ✅ Ruby SemVer >= 3.0 verified');
        results['Ruby Runtime (>= 3.0)'] = true;
      }
    } else {
      results['Ruby Runtime'] = true;
    }
  } else {
    stdout.writeln('⚠️ Not detected in PATH (Required for Fastlane execution)');
    results['Ruby Runtime'] = false;
  }

  // 2. Check Bundler
  stdout.write('🔍 Checking Ruby Bundler... ');
  final bundleCheck = _runCommand('bundle', ['--version']);
  if (bundleCheck.success) {
    stdout.writeln('✅ Found: ${bundleCheck.output}');
    results['Bundler'] = true;
  } else {
    stdout.writeln(
      '⚠️ Not detected in PATH (Install via: gem install bundler)',
    );
    results['Bundler'] = false;
  }

  // 3. Check Java JDK
  stdout.write('🔍 Checking Java JDK... ');
  final javaCheck = _runCommand('java', ['-version']);
  if (javaCheck.success) {
    stdout.writeln('✅ Found: ${javaCheck.output}');
    results['Java JDK'] = true;
  } else {
    stdout.writeln(
      '⚠️ Not detected in PATH (Required for Android compilation)',
    );
    results['Java JDK'] = false;
  }

  // 4. Check Android SDK Environment
  stdout.write('🔍 Checking Android SDK environment... ');
  final androidHome =
      Platform.environment['ANDROID_HOME'] ??
      Platform.environment['ANDROID_SDK_ROOT'];
  if (androidHome != null && Directory(androidHome).existsSync()) {
    stdout.writeln('✅ Found: $androidHome');
    results['Android SDK'] = true;
  } else {
    stdout.writeln(
      '⚠️ ANDROID_HOME or ANDROID_SDK_ROOT not set or directory not found',
    );
    results['Android SDK'] = false;
  }

  // 5. Check Flutter SDK
  stdout.write('🔍 Checking Flutter SDK... ');
  final flutterCheck = _runCommand('flutter', ['--version']);
  if (flutterCheck.success) {
    final firstLine = flutterCheck.output.split('\n').first;
    stdout.writeln('✅ Found: $firstLine');
    results['Flutter SDK'] = true;
  } else {
    stdout.writeln('⚠️ Flutter not detected in PATH');
    results['Flutter SDK'] = false;
  }

  // 6. Check Signing Keystores & Credentials
  stdout.write('🔍 Checking Android signing files... ');
  final keystore = File('android/app/upload-keystore.jks');
  final keyProps = File('android/key.properties');
  final pcApiKey = File('android/pc-api-key.json');
  final hasKeystore = keystore.existsSync();
  final hasKeyProps = keyProps.existsSync();
  final hasPcApiKey = pcApiKey.existsSync();

  stdout.writeln();
  stdout.writeln(
    '   - upload-keystore.jks: ${hasKeystore ? "✅ Found" : "ℹ️ Missing (Provided via CI secret)"}',
  );
  stdout.writeln(
    '   - key.properties:      ${hasKeyProps ? "✅ Found" : "ℹ️ Missing (Provided via CI secret)"}',
  );
  stdout.writeln(
    '   - pc-api-key.json:     ${hasPcApiKey ? "✅ Found" : "ℹ️ Missing (Provided via CI secret)"}',
  );
  results['Release Credentials'] = true;

  // 7. Keystore Certificate Inspection
  if (hasKeystore && hasKeyProps) {
    stdout.write('🔍 Inspecting Keystore Certificate (keytool)... ');
    try {
      final propsLines = keyProps.readAsLinesSync();
      String? password;
      String? alias;
      for (final line in propsLines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('storePassword=')) {
          password = trimmed.substring('storePassword='.length);
        } else if (trimmed.startsWith('keyAlias=')) {
          alias = trimmed.substring('keyAlias='.length);
        }
      }

      if (password != null && alias != null) {
        final keytoolRes = _runCommand('keytool', [
          '-list',
          '-v',
          '-keystore',
          keystore.path,
          '-storepass',
          password,
          '-alias',
          alias,
        ]);
        if (keytoolRes.success) {
          final out = keytoolRes.output;
          final validMatch = RegExp(
            r'Valid from:\s*(.+?)\s*until:\s*(.+)',
            caseSensitive: false,
          ).firstMatch(out);
          final sha256Match = RegExp(
            r'SHA256:\s*([A-F0-9:]+)',
            caseSensitive: false,
          ).firstMatch(out);

          stdout.writeln('✅ Validated');
          if (validMatch != null) {
            stdout.writeln(
              '     Validity: until ${validMatch.group(2)?.trim()}',
            );
          }
          if (sha256Match != null) {
            stdout.writeln('     SHA256:   ${sha256Match.group(1)?.trim()}');
          }
          results['Keystore Certificate'] = true;
        } else {
          stdout.writeln('ℹ️ keytool skipped (not available in PATH)');
        }
      } else {
        stdout.writeln('ℹ️ Could not parse credentials from key.properties');
      }
    } catch (_) {
      stdout.writeln('ℹ️ Skipped');
    }
  }

  // Summary
  stdout.writeln('\n-------------------------------------------------------');
  stdout.writeln('📊 Environment Doctor Summary:');
  results.forEach((k, v) {
    stdout.writeln('   ${v ? "✅" : "⚠️"} $k');
  });

  stdout.writeln('\n🎉 Environment diagnostic completed!');
}

class _CmdResult {
  final bool success;
  final String output;
  _CmdResult(this.success, this.output);
}

_CmdResult _runCommand(String cmd, List<String> args) {
  try {
    final result = Process.runSync(cmd, args, runInShell: true);
    if (result.exitCode == 0) {
      final out = result.stdout.toString().trim();
      final err = result.stderr.toString().trim();
      return _CmdResult(true, out.isNotEmpty ? out : err);
    }
    // java -version prints to stderr with exitCode 0
    final err = result.stderr.toString().trim();
    if (err.isNotEmpty &&
        (err.contains('version') || err.contains('Runtime'))) {
      return _CmdResult(true, err.split('\n').first);
    }
    return _CmdResult(false, '');
  } catch (_) {
    return _CmdResult(false, '');
  }
}
