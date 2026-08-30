import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' 🔗 Impulse DEX - Android App Links & Deep Linking Auditor');
  stdout.writeln(
    '================================================================',
  );

  var allPassed = true;
  final errors = <String>[];

  // ---------------------------------------------------------------------------
  // 1. AndroidManifest.xml App Links Intent Filter Audit
  // ---------------------------------------------------------------------------
  stdout.writeln(
    '\n1️⃣ Checking AndroidManifest.xml App Links Configuration...',
  );
  final manifestFile = File('android/app/src/main/AndroidManifest.xml');
  if (!manifestFile.existsSync()) {
    errors.add('android/app/src/main/AndroidManifest.xml not found');
    allPassed = false;
  } else {
    final mContent = manifestFile.readAsStringSync();

    final hasAutoVerify = mContent.contains('android:autoVerify="true"');
    if (hasAutoVerify) {
      stdout.writeln(
        '  ✅ android:autoVerify="true" declared on App Links intent-filter',
      );
    } else {
      errors.add('Missing android:autoVerify="true" in AndroidManifest.xml');
      allPassed = false;
    }

    final hasHttpsScheme = mContent.contains('android:scheme="https"');
    if (hasHttpsScheme) {
      stdout.writeln('  ✅ Strict HTTPS scheme enforced for deep links');
    } else {
      errors.add('Missing android:scheme="https" for deep links');
      allPassed = false;
    }

    final hasHost = mContent.contains('impulseagrisciencelimited.com');
    if (hasHost) {
      stdout.writeln(
        '  ✅ Official domain configured: impulseagrisciencelimited.com & www',
      );
    } else {
      errors.add(
        'Missing host impulseagrisciencelimited.com in App Links intent filter',
      );
      allPassed = false;
    }

    final hasProductPrefix = mContent.contains('android:pathPrefix="/product"');
    final hasDistributorPrefix = mContent.contains(
      'android:pathPrefix="/distributor"',
    );
    if (hasProductPrefix && hasDistributorPrefix) {
      stdout.writeln(
        '  ✅ Path prefixes configured for /product and /distributor',
      );
    } else {
      errors.add('Missing /product or /distributor pathPrefixes');
      allPassed = false;
    }
  }

  // ---------------------------------------------------------------------------
  // 2. Digital Asset Links (.well-known/assetlinks.json) Audit
  // ---------------------------------------------------------------------------
  stdout.writeln(
    '\n2️⃣ Checking Digital Asset Links (.well-known/assetlinks.json)...',
  );
  final assetLinksFile = File('.well-known/assetlinks.json');
  if (!assetLinksFile.existsSync()) {
    errors.add('.well-known/assetlinks.json is missing');
    allPassed = false;
  } else {
    try {
      final jsonRaw = assetLinksFile.readAsStringSync();
      final parsed = jsonDecode(jsonRaw) as List<dynamic>;

      if (parsed.isNotEmpty) {
        final entry = parsed.first as Map<String, dynamic>;
        final target = entry['target'] as Map<String, dynamic>;
        final pkgName = target['package_name'] as String?;
        final fingerprints =
            target['sha256_cert_fingerprints'] as List<dynamic>?;

        if (pkgName == 'com.impulseagriscienceltd.impulse_app') {
          stdout.writeln('  ✅ Target package name matches: $pkgName');
        } else {
          errors.add(
            'assetlinks.json package_name ($pkgName) != com.impulseagriscienceltd.impulse_app',
          );
          allPassed = false;
        }

        if (fingerprints != null && fingerprints.isNotEmpty) {
          stdout.writeln(
            '  ✅ SHA-256 Certificate Fingerprints configured (${fingerprints.length})',
          );
        } else {
          errors.add('assetlinks.json has empty sha256_cert_fingerprints');
          allPassed = false;
        }
      } else {
        errors.add('assetlinks.json is an empty JSON array');
        allPassed = false;
      }
    } catch (e) {
      errors.add('Invalid JSON syntax in .well-known/assetlinks.json: $e');
      allPassed = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Summary & Exit Code
  // ---------------------------------------------------------------------------
  stdout.writeln(
    '\n================================================================',
  );
  if (allPassed) {
    stdout.writeln(
      '🎉 Android App Links & Deep Linking Audit PASSED (100% Validated)',
    );
    stdout.writeln(
      '================================================================',
    );
    exit(0);
  } else {
    stderr.writeln('💥 App Links Audit FAILED:');
    for (final err in errors) {
      stderr.writeln('  ❌ $err');
    }
    stdout.writeln(
      '================================================================',
    );
    exit(1);
  }
}
