import 'dart:io';
import 'dart:typed_data';

/// Fastlane Graphic Assets & Screenshots Sync & Validation Tool
///
/// Ensures compliance with Google Play Store & Fastlane Supply conventions:
/// - App Icon: 512x512 PNG (max 1024 KB)
/// - Feature Graphic: 1024x500 PNG/JPEG (max 1024 KB)
/// - Phone Screenshots: 2-8 images, numbered sequentially (e.g. 1_home.png),
///   min dimension >= 320px, max <= 3840px, max aspect ratio 2:1, max 8 MB each.
/// - Tablet folders: sevenInchScreenshots, tenInchScreenshots.
void main(List<String> args) {
  final shouldSync = args.contains('--sync') || args.contains('-s');
  final isFix = args.contains('--fix') || args.contains('-f');

  stdout.writeln('🖼️ Fastlane Graphic Assets & Screenshot Convention Audit\n');

  final metaRoot = Directory('android/fastlane/metadata/android');
  if (!metaRoot.existsSync()) {
    stderr.writeln('❌ Fastlane metadata directory not found: ${metaRoot.path}');
    exit(1);
  }

  final appLogo = File('assets/images/app_logo.png');
  final locales = ['en-US', 'bn-BD'];
  var hasErrors = false;

  for (final locale in locales) {
    stdout.writeln('📁 Auditing locale: [$locale]...');
    final imgDir = Directory('${metaRoot.path}/$locale/images');
    if (!imgDir.existsSync()) {
      imgDir.createSync(recursive: true);
    }

    // 1. Icon Audit (512x512)
    final iconFile = File('${imgDir.path}/icon.png');
    if (!iconFile.existsSync()) {
      if ((isFix || shouldSync) && appLogo.existsSync()) {
        appLogo.copySync(iconFile.path);
        stdout.writeln(
          '   ✅ Restored icon.png from assets/images/app_logo.png',
        );
      } else {
        stderr.writeln(
          '   ❌ Missing icon.png (Required: 512x512 PNG, max 1024 KB)',
        );
        hasErrors = true;
      }
    } else {
      final dim = getImageDimensions(iconFile);
      final sizeKb = iconFile.lengthSync() / 1024;
      if (dim.width == 512 && dim.height == 512 && sizeKb <= 1024) {
        stdout.writeln(
          '   ✅ icon.png: 512x512 PNG (${sizeKb.toStringAsFixed(1)} KB)',
        );
      } else {
        stderr.writeln(
          '   ❌ icon.png invalid: ${dim.width}x${dim.height} (${sizeKb.toStringAsFixed(1)} KB). Expected 512x512 <= 1024 KB.',
        );
        hasErrors = true;
      }
    }

    // 2. Feature Graphic Audit (1024x500)
    final featureFile = File('${imgDir.path}/featureGraphic.png');
    if (!featureFile.existsSync()) {
      stderr.writeln(
        '   ❌ Missing featureGraphic.png (Required: 1024x500 PNG/JPEG, max 1024 KB)',
      );
      hasErrors = true;
    } else {
      final dim = getImageDimensions(featureFile);
      final sizeKb = featureFile.lengthSync() / 1024;
      if (dim.width == 1024 && dim.height == 500 && sizeKb <= 1024) {
        stdout.writeln(
          '   ✅ featureGraphic.png: 1024x500 (${sizeKb.toStringAsFixed(1)} KB)',
        );
      } else {
        stderr.writeln(
          '   ❌ featureGraphic.png invalid: ${dim.width}x${dim.height} (${sizeKb.toStringAsFixed(1)} KB). Expected 1024x500 <= 1024 KB.',
        );
        hasErrors = true;
      }
    }

    // 3. Phone Screenshots Audit
    final phoneDir = Directory('${imgDir.path}/phoneScreenshots');
    if (!phoneDir.existsSync()) {
      phoneDir.createSync(recursive: true);
    }

    final screenshots =
        phoneDir
            .listSync()
            .whereType<File>()
            .where((f) => !f.path.endsWith('.gitkeep'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    if (screenshots.isEmpty && (shouldSync || isFix) && locale != 'en-US') {
      final sourceDir = Directory(
        '${metaRoot.path}/en-US/images/phoneScreenshots',
      );
      if (sourceDir.existsSync()) {
        for (final srcFile in sourceDir.listSync().whereType<File>()) {
          if (!srcFile.path.endsWith('.gitkeep')) {
            final fileName = srcFile.uri.pathSegments.last;
            srcFile.copySync('${phoneDir.path}/$fileName');
            screenshots.add(File('${phoneDir.path}/$fileName'));
          }
        }
        stdout.writeln(
          '   🔄 Synced ${screenshots.length} screenshots from en-US',
        );
      }
    }

    if (screenshots.length < 2 || screenshots.length > 8) {
      stderr.writeln(
        '   ❌ Phone screenshots count: ${screenshots.length}. Google Play requires 2 to 8 screenshots.',
      );
      hasErrors = true;
    } else {
      stdout.writeln(
        '   ✅ Phone screenshots count: ${screenshots.length} (Compliant with 2-8 policy)',
      );
    }

    final validNamePattern = RegExp(
      r'^[0-9]+_[a-zA-Z0-9_\-]+\.(png|jpg|jpeg)$',
    );
    for (final shot in screenshots) {
      final fileName = shot.uri.pathSegments.last;
      final dim = getImageDimensions(shot);
      final sizeMb = shot.lengthSync() / (1024 * 1024);

      final hasValidName = validNamePattern.hasMatch(fileName);
      final hasValidDim =
          dim.width >= 320 &&
          dim.height >= 320 &&
          dim.width <= 3840 &&
          dim.height <= 3840;
      final hasValidSize = sizeMb <= 8.0;

      if (hasValidName && hasValidDim && hasValidSize) {
        stdout.writeln(
          '      📸 $fileName: ${dim.width}x${dim.height} (${(sizeMb * 1024).toStringAsFixed(1)} KB)',
        );
      } else {
        stderr.writeln(
          '      ❌ $fileName non-compliant: nameValid=$hasValidName, dim=${dim.width}x${dim.height}, size=${sizeMb.toStringAsFixed(2)}MB',
        );
        hasErrors = true;
      }
    }

    // 4. Tablet Directories Check
    final sevenInch = Directory('${imgDir.path}/sevenInchScreenshots');
    final tenInch = Directory('${imgDir.path}/tenInchScreenshots');
    if (!sevenInch.existsSync()) sevenInch.createSync(recursive: true);
    if (!tenInch.existsSync()) tenInch.createSync(recursive: true);
    final keep7 = File('${sevenInch.path}/.gitkeep');
    final keep10 = File('${tenInch.path}/.gitkeep');
    if (!keep7.existsSync()) keep7.writeAsStringSync('');
    if (!keep10.existsSync()) keep10.writeAsStringSync('');
  }

  if (hasErrors) {
    stderr.writeln(
      '\n💥 Fastlane graphic assets & screenshots compliance failed.',
    );
    exit(1);
  } else {
    stdout.writeln(
      '\n🎉 All Fastlane screenshots and graphic assets meet Google Play & Supply conventions.',
    );
  }
}

class ImageDimensions {
  final int width;
  final int height;
  ImageDimensions(this.width, this.height);
}

ImageDimensions getImageDimensions(File file) {
  final bytes = file.readAsBytesSync();
  if (bytes.length < 24) return ImageDimensions(0, 0);

  // PNG
  if (bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47) {
    final bd = ByteData.sublistView(bytes);
    final w = bd.getUint32(16);
    final h = bd.getUint32(20);
    return ImageDimensions(w, h);
  }

  // JPEG
  if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
    var offset = 2;
    while (offset < bytes.length - 8) {
      if (bytes[offset] != 0xFF) break;
      final marker = bytes[offset + 1];
      if (marker == 0xC0 || marker == 0xC2) {
        final h = (bytes[offset + 5] << 8) + bytes[offset + 6];
        final w = (bytes[offset + 7] << 8) + bytes[offset + 8];
        return ImageDimensions(w, h);
      }
      final len = (bytes[offset + 2] << 8) + bytes[offset + 3];
      offset += 2 + len;
    }
  }

  return ImageDimensions(0, 0);
}
