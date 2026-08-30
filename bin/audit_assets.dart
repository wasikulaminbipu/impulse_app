import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main(List<String> args) {
  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' 📦 Impulse DEX - Asset Health, Integrity & Bloat Auditor');
  stdout.writeln(
    '================================================================',
  );

  final warnings = <String>[];
  final errors = <String>[];

  final assetsDir = Directory('assets');
  if (!assetsDir.existsSync()) {
    stderr.writeln('❌ Error: assets/ directory does not exist!');
    exit(1);
  }

  // ---------------------------------------------------------------------------
  // 1. Scan All Asset Files & Measure Total Bloat
  // ---------------------------------------------------------------------------
  stdout.writeln('\n1️⃣ Scanning Asset Inventory & File Sizes...');
  final allAssetFiles = assetsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => !f.path.contains('.gitkeep'))
      .toList();

  var totalBytes = 0;
  final largeAssets = <File>[];

  for (final file in allAssetFiles) {
    final size = file.lengthSync();
    totalBytes += size;
    // 350 KB threshold for single asset bloat
    if (size > 350 * 1024) {
      largeAssets.add(file);
    }
  }

  final totalMb = (totalBytes / (1024 * 1024)).toStringAsFixed(2);
  stdout.writeln(
    '  📊 Total Assets: ${allAssetFiles.length} files ($totalMb MB)',
  );

  if (largeAssets.isNotEmpty) {
    stdout.writeln(
      '  ⚠️ Assets exceeding 350 KB size threshold (${largeAssets.length}):',
    );
    for (final la in largeAssets) {
      final sizeKb = (la.lengthSync() / 1024).toStringAsFixed(1);
      final relPath = la.path.replaceAll(r'\', '/');
      stdout.writeln(
        '    - $relPath: $sizeKb KB (Consider WebP/lossless compression)',
      );
      warnings.add('Asset $relPath is $sizeKb KB (> 350 KB threshold)');
    }
  } else {
    stdout.writeln(
      '  ✅ All individual assets are lightweight and optimized (< 350 KB)',
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Cross-Reference SQLite Database Product Images with Disk
  // ---------------------------------------------------------------------------
  stdout.writeln(
    '\n2️⃣ Cross-Referencing SQLite Database Product Images with Disk...',
  );
  final productsDbFile = File('assets/db/products.db');
  if (productsDbFile.existsSync()) {
    try {
      final db = sqlite3.open(productsDbFile.path);

      // Check product images
      final productRows = db.select(
        "SELECT id, title_en, image_url FROM products WHERE image_url IS NOT NULL AND image_url != '';",
      );
      var matchedProductImages = 0;
      var missingProductImages = 0;

      for (final row in productRows) {
        final imgUrl = row['image_url'] as String;
        final sanitized = imgUrl.startsWith('assets/')
            ? imgUrl
            : 'assets/product_image/$imgUrl';
        final file = File(sanitized);
        if (file.existsSync()) {
          matchedProductImages++;
        } else {
          final altFile = File('assets/product_image/$imgUrl');
          final altWebpFile = File('assets/product_image/$imgUrl.webp');
          if (altFile.existsSync() || altWebpFile.existsSync()) {
            matchedProductImages++;
          } else {
            missingProductImages++;
            errors.add(
              'Product #${row['id']} (${row['title_en']}) references missing image: $imgUrl',
            );
          }
        }
      }

      stdout.writeln(
        '  📊 Products with Images: ${productRows.length} (Verified on disk: $matchedProductImages, Missing: $missingProductImages)',
      );
      if (missingProductImages == 0) {
        stdout.writeln(
          '  ✅ 100% of product database image references exist on disk',
        );
      }

      // Check manufacturer logos
      final mfgRows = db.select(
        "SELECT id, name_en, logo_url FROM manufacturers WHERE logo_url IS NOT NULL AND logo_url != '';",
      );
      var matchedMfgLogos = 0;
      var missingMfgLogos = 0;

      for (final row in mfgRows) {
        final logoUrl = row['logo_url'] as String;
        final file = File('assets/manufacturers_logo/$logoUrl');
        final fileWebp = File('assets/manufacturers_logo/$logoUrl.webp');
        if (file.existsSync() ||
            fileWebp.existsSync() ||
            File(logoUrl).existsSync()) {
          matchedMfgLogos++;
        } else {
          missingMfgLogos++;
          warnings.add(
            'Manufacturer #${row['id']} (${row['name_en']}) logo not found on disk: $logoUrl',
          );
        }
      }

      stdout.writeln(
        '  📊 Manufacturers with Logos: ${mfgRows.length} (Verified on disk: $matchedMfgLogos, Missing: $missingMfgLogos)',
      );

      db.close();
    } catch (e) {
      warnings.add('Could not query products.db for image validation: $e');
    }
  } else {
    errors.add('assets/db/products.db not found for image validation');
  }

  // ---------------------------------------------------------------------------
  // 3. Pubspec.yaml Asset Declarations Audit
  // ---------------------------------------------------------------------------
  stdout.writeln('\n3️⃣ Auditing pubspec.yaml Asset Directories...');
  final pubspecFile = File('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final pContent = pubspecFile.readAsStringSync();
    final expectedAssetDirs = [
      'assets/images/',
      'assets/icons/',
      'assets/fonts/',
      'assets/db/',
      'assets/product_image/',
      'assets/manufacturers_logo/',
    ];

    for (final dir in expectedAssetDirs) {
      if (pContent.contains(dir)) {
        stdout.writeln('  ✅ Declared in pubspec.yaml: $dir');
      } else {
        warnings.add(
          'Asset folder $dir is not explicitly declared under flutter.assets in pubspec.yaml',
        );
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Summary & Exit Code
  // ---------------------------------------------------------------------------
  stdout.writeln(
    '\n================================================================',
  );
  if (errors.isEmpty) {
    stdout.writeln(
      '🎉 Asset Integrity & Bloat Audit PASSED (Total: $totalMb MB)',
    );
    if (warnings.isNotEmpty) {
      stdout.writeln(
        'ℹ️ Non-fatal optimization suggestions (${warnings.length}):',
      );
      for (final w in warnings) {
        stdout.writeln('  - $w');
      }
    }
    stdout.writeln(
      '================================================================',
    );
    exit(0);
  } else {
    stderr.writeln('💥 Asset Audit FAILED with ${errors.length} error(s):');
    for (final err in errors) {
      stderr.writeln('  ❌ $err');
    }
    stdout.writeln(
      '================================================================',
    );
    exit(1);
  }
}
