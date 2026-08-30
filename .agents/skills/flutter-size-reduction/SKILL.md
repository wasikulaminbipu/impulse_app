---
name: flutter-size-reduction
description: Use when analyzing, optimizing, and reducing Flutter app bundle sizes across Android (APK/AAB), iOS (IPA), and Web, including Dart 3 AOT profiling, R8 Full Mode, ProGuard shrinking, font subsetting, asset compression, and code bloat mitigation.
---

# Flutter App Size Reduction & Optimization Skill

Use this skill when auditing, diagnosing, and optimizing Flutter application bundle sizes (APK, Android App Bundle `.aab`, iOS `.ipa`, Web build). Follow this systematic engineering approach to minimize download size, install footprint, and runtime memory overhead while maintaining high performance, policy compliance, and crash-free execution.

---

## 1. Baseline Size Breakdown & Profiling

Before attempting optimization, measure and profile the app size using Flutter's official diagnostic tools.

### 1.1 Generate Size Analysis File
Run the Flutter build command with the `--analyze-size` flag for your target platform:

```bash
# Android App Bundle (Recommended for Google Play Store)
flutter build appbundle --release --analyze-size

# Android APK (Targeting ARM64 to isolate 64-bit architecture size)
flutter build apk --release --analyze-size --target-platform android-arm64

# iOS Release Build (Requires macOS + Xcode)
flutter build ios --release --analyze-size

# Web Assembly (Wasm) & JS Release Build
flutter build web --release --wasm --analyze-size
```

This generates a JSON size analysis file (e.g., `apk-code-size-analysis_01.json` or `app-code-size-analysis_01.json`) in the build output directory.

### 1.2 Inspect with Flutter DevTools
1. Launch DevTools:
   ```bash
   flutter pub global run devtools
   ```
2. Open the **App Size** tab in DevTools.
3. Drag & drop or load the generated `.json` analysis file.
4. Use the **Treemap** to inspect hierarchical package sizes.
5. Use the **Diff** tab to compare size analysis JSON files between git branches or releases to isolate size regressions.

### 1.3 Deep Binary Inspection (`bloaty` & `apktool` & `llvm-objdump`)

For granular C++ and native ELF binary inspection beyond DevTools:

```bash
# Analyze APK inner layout and uncompressed size
apktool d build/app/outputs/flutter-apk/app-release.apk -o apk_dump

# Inspect Dart AOT ELF sections & C++ symbols using Bloaty McBloatface
bloaty apk_dump/lib/arm64-v8a/libapp.so -d symbols,compileunits

# Inspect iOS binary symbol sizes
xcrun size -m ios/build/Runner.framework/Runner
llvm-objdump -h ios/build/Runner.framework/Runner
```

### 1.4 Typical Anatomy of a Release Flutter App

| Component | Description | Typical Base Size | Primary Optimization Strategy |
| :--- | :--- | :--- | :--- |
| **Flutter Engine** | C++ runtime, Impeller/Skia renderer, Dart VM engine | ~3.5 MB – 5.5 MB | Immutable base; isolate target ABIs via Android App Bundles |
| **Dart AOT Snapshot** | Compiled business logic, UI code, & framework | ~2.0 MB – 7.0 MB | Obfuscation, code shrinking, tree-shaking, deferred loading |
| **Assets & Fonts** | Images, custom fonts, audio, video, Lottie/Rive | ~5.0 MB – 50 MB+ | WebP conversion, font subsetting, remote asset hosting, PAD/ODR |
| **Native Libraries (.so/.dylib)** | Native plugins (SQLite, Firebase, OpenCV, WebRTC) | ~2.0 MB – 25 MB+ | Exclude unused ABIs, strip native symbols, trim plugin dependencies |

---

## 2. Compiler Flags & Code Shrinking (Immediate Wins)

### 2.1 Split APKs by Target ABI (Android Sideloading / Development)
Fat APKs contain native binaries for `armeabi-v7a`, `arm64-v8a`, and `x86_64`. Split them into architecture-specific APKs:

```bash
flutter build apk --release --split-per-abi
```
* **Impact**: Reduces APK size by **50%–60%** (e.g., 35 MB Fat APK $\rightarrow$ 12 MB per-ABI APK).
* **Note**: When publishing to the Google Play Store, publish an **Android App Bundle (`.aab`)** instead; Play Store automatically generates per-device optimized APKs.

### 2.2 Dart Symbol Stripping & Obfuscation
Stripping debug symbols and obfuscating Dart AOT code removes human-readable class names, field names, and stack trace metadata from the release binary snapshot:

```bash
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
```
* `--obfuscate`: Obfuscates Dart code symbols.
* `--split-debug-info`: Extracts symbol maps out of the app binary into a separate directory for stack trace de-obfuscation.
* **Impact**: Reduces Dart AOT snapshot size by **10%–20%**.

### 2.3 Icon Tree-Shaking
Flutter automatically tree-shakes Material and Cupertino icon fonts in release mode (including only used codepoints).

* **Ensure Icon Shaking is Active**: Avoid using `--no-tree-shake-icons` in production build pipelines.
* **Dynamic Icon Safety**: If accessing icons dynamically via runtime variables (`IconData(codePoint, ...)`), tree-shaking might strip required glyphs or fail the build. In such cases, explicitly declare static references or construct a custom icon subset font.

---

## 3. Asset & Multimedia Compression Pipelines

Assets typically account for **60%–80%** of bloated Flutter app bundles.

### 3.1 Convert Raster Images to WebP Format
Replace PNG and JPEG images with compressed **Lossless** or **Lossy WebP**:

```bash
# Convert PNG to Lossy WebP (Quality 80%) via cwebp CLI tool
cwebp -q 80 input.png -o output.webp

# Convert PNG to Lossless WebP
cwebp -lossless input.png -o output.webp

# Batch convert all PNG images in asset directory
find assets/images -name "*.png" -exec sh -c 'cwebp -q 80 "$1" -o "${1%.png}.webp" && rm "$1"' _ {} \;
```
* **Compression Target**: 80% quality lossy WebP provides near-identical visual fidelity with **60%–80% file size reduction**.
* **Flutter Native Support**: WebP is natively supported across iOS, Android, Desktop, and Web in Flutter without extra dependencies.

### 3.2 Vector Graphics & SVG Optimization
* Use `flutter_svg` for logos, UI icons, and line graphics instead of high-density `@2x` / `@3x` PNG rasters.
* Optimize SVGs with `svgo` to remove unnecessary metadata, hidden elements, and redundant paths:
  ```bash
  npx svgo -f assets/svgs/ --multipass
  ```

### 3.3 Animation Formats: Rive vs Lottie
* Prefer **Rive (`.riv`)** over **Lottie (`.json`)** or video/GIF formats for complex UI animations.
* Rive binary files are typically **70%–90% smaller** than equivalent uncompressed Lottie JSON files and consume less CPU/memory during rendering.

### 3.4 Audio & Video Asset Compression (FFmpeg)
If bundling offline audio or video assets:

```bash
# Compress Audio to AAC (m4a) at 96 kbps stereo or 64 kbps mono
ffmpeg -i input.wav -c:a aac -b:a 96k output.m4a

# Compress Video to H.264 / AAC MP4 with CRF 28 (High compression)
ffmpeg -i input.mp4 -vcodec libx264 -crf 28 -preset slow -acodec aac -b:a 96k output_compressed.mp4
```

### 3.5 Font Subsetting & Dynamic Font Delivery
Custom `.ttf` or `.otf` font files often carry thousands of unused international glyphs and weights.

#### Option A: Subset Fonts using `pyftsubset` (`fonttools`)
Keep only required ASCII/Latin characters:

```bash
# Install fonttools
pip install fonttools brotli

# Subset font to basic Latin + Latin-1 Supplement
pyftsubset custom_font.ttf \
  --unicodes="U+0000-00FF,U+0100-017F" \
  --output-file="custom_font_subset.ttf" \
  --flavor=woff2
```
* **Impact**: Shrinks a 3–5 MB font file down to **20 KB – 50 KB**.

#### Option B: Google Fonts Package
Use `google_fonts` to fetch fonts on demand or cache them locally instead of bundling every weight variant into the binary asset folder:

```dart
// pubspec.yaml
dependencies:
  google_fonts: ^6.2.0
```

### 3.6 Automated Asset Audit Tooling (Dart CLI)
Create `tool/audit_assets.dart` to automatically detect oversized assets:

```dart
// tool/audit_assets.dart
import 'dart:io';

void main() {
  final dir = Directory('assets');
  if (!dir.existsSync()) {
    print('No assets directory found.');
    return;
  }

  int totalBytes = 0;
  final largeFiles = <File, int>{};

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      final bytes = entity.lengthSync();
      totalBytes += bytes;
      if (bytes > 150 * 1024) { // Flag files > 150 KB
        largeFiles[entity] = bytes;
      }
    }
  }

  print('========================================');
  print('Total Assets Size: ${(totalBytes / (1024 * 1024)).toStringAsFixed(2)} MB');
  print('Oversized Assets (>150KB): ${largeFiles.length}');
  print('========================================');
  largeFiles.forEach((file, bytes) {
    print('  - ${file.path}: ${(bytes / 1024).toStringAsFixed(1)} KB');
  });
}
```

---

## 4. Android-Specific Size Reduction (AGP 8+, R8 Full Mode, & Rules)

### 4.1 Enable R8 Code & Resource Shrinking (AGP 8+ Kotlin DSL)
In `android/app/build.gradle.kts`:

```kotlin
android {
    buildTypes {
        getByName("release") {
            // Enable R8 Code Shrinking & Obfuscation
            isMinifyEnabled = true
            
            // Enable Resource Shrinking (removes unused raw assets from native dependencies)
            isShrinkResources = true
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

### 4.2 Essential R8 / ProGuard Keep Rules (`proguard-rules.pro`)
When `isMinifyEnabled = true` is active, keep rules prevent runtime crashes for JNI bindings, reflection, and SQLite/Drift:

```proguard
# Flutter Engine Keep Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Drift / SQLite Native Bindings
-keep class net.sqlcipher.** { *; }
-keep class io.simform.custom_sqlite.** { *; }
-dontwarn androidx.sqlite.**

# Keep annotations used by Riverpod / Freezed / JSON Serializable
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Gson / Jackson / Moshi serialization keep rules (if used in native plugins)
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
```

### 4.3 Exclude Unused Native Resources in Gradle
Filter unnecessary native translation strings and unused native library metadata:

```kotlin
android {
    defaultConfig {
        // Limit packaged resources to app's supported locales
        resourceConfigurations += setOf("en", "es", "fr")
    }

    packaging {
        resources {
            excludes += setOf(
                "META-INF/*.version",
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE*",
                "META-INF/NOTICE*",
                "**/libjsse.so",
                "DebugProbesKt.bin"
            )
        }
    }
}
```

### 4.4 Native ABI NDK Filtering
If using plugins containing C++ libraries (e.g. OpenCV, TensorFlow Lite, Realm, SQLCipher):

```kotlin
android {
    defaultConfig {
        ndk {
            // Only package architectures relevant for production devices
            abiFilters += setOf("armeabi-v7a", "arm64-v8a")
        }
    }
}
```

### 4.5 Android 15 (Target SDK 35) 16KB Page Alignment & Native Symbol Stripping
Android 15 requires ELF native libraries (`.so`) to be aligned to 16KB page boundaries. Aligning and stripping native C++ symbols prevents uncompressed padding bloat in `.aab` bundles:

```kotlin
android {
    defaultConfig {
        externalNativeBuild {
            cmake {
                // Ensure 16KB page alignment and strip debug symbols in C++ builds
                cppFlags("-O3 -flto -ffunction-sections -fdata-sections")
                arguments("-DANDROID_STL=c++_shared", "-DCMAKE_SHARED_LINKER_FLAGS=-Wl,--gc-sections -Wl,-z,max-page-size=16384")
            }
        }
    }
}
```
* **Impact**: Keeps 16KB-aligned native libraries compact while maintaining mandatory Android 15 Google Play policy compliance.

---

## 5. iOS-Specific Size Optimization (Xcode 15/16 Configuration)

### 5.1 Xcode Build Settings
Ensure the following build settings are configured in `ios/Runner.xcodeproj` or `Podfile`:

* **`DEAD_CODE_STRIPPING`**: `YES` (removes unreferenced code blocks during linking).
* **`STRIP_INSTALLED_PRODUCT`**: `YES` (strips debug and local symbols from release binary).
* **`DEPLOYMENT_POSTPROCESSING`**: `YES`
* **`STRIP_STYLE`**: `all-symbols`
* **`GCC_OPTIMIZATION_LEVEL`**: `s` (Optimize for size) or `fast` (Release).

### 5.2 Podfile Post-Install Strip Configurations
Add symbol stripping directly into `ios/Podfile`:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      if config.name == 'Release'
        config.build_settings['DEAD_CODE_STRIPPING'] = 'YES'
        config.build_settings['STRIP_INSTALLED_PRODUCT'] = 'YES'
        config.build_settings['DEPLOYMENT_POSTPROCESSING'] = 'YES'
        config.build_settings['STRIP_STYLE'] = 'all-symbols'
      end
    end
  end
end
```

### 5.3 Framework Thinning & Asset Catalogs
* Store images inside `Assets.xcassets` rather than loose file paths. Xcode automatically slices and delivers only the specific `@2x` or `@3x` asset required for the target iOS device via App Store App Thinning.

---

## 6. On-Demand Assets & Dynamic Feature Modules

When assets (like ML models, offline database seeds, or video tutorials) exceed 10 MB, keep them out of the initial download payload using Play Asset Delivery (PAD) or iOS On-Demand Resources (ODR).

### 6.1 Play Asset Delivery (Android PAD)
1. Define asset packs in `android/settings.gradle.kts`:
   ```kotlin
   include(":app")
   include(":large_asset_pack")
   project(":large_asset_pack").projectDir = File("large_asset_pack")
   ```
2. Configure `large_asset_pack/build.gradle.kts`:
   ```kotlin
   plugins {
       id("com.android.asset-pack")
   }

   assetPack {
       packName.set("large_asset_pack")
       dynamicDelivery {
           deliveryType.set("on-demand") // Options: "on-demand", "fast-follow", "install-time"
       }
   }
   ```
3. Request & download at runtime in Dart using official Play Asset Delivery plugins.

### 6.2 Deferred Loading (Dart AOT Dynamic Modules)

Deferred loading allows splitting Dart code into separate chunks, downloading or loading code modules on demand rather than inflating the main application binary payload.

```dart
import 'package:impulse_dex/features/admin/admin_screen.dart' deferred as admin_feature;
import 'package:flutter/material.dart';

class AdminLoaderWidget extends StatelessWidget {
  const AdminLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: admin_feature.loadLibrary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Network error loading module.'),
                ElevatedButton(
                  onPressed: () => (context as Element).markNeedsBuild(),
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          return admin_feature.AdminScreen();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
```

* **Effect**: The Dart AOT compiler isolates `admin_feature` into a separate `.so` / `.js` file, reducing the initial executable size.

---

## 7. Dependency Hygiene & Code Generator Bloat Mitigation

### 7.1 Audit Dependency Tree
Run `flutter pub deps` to identify transitive dependencies and bloated packages:

```bash
flutter pub deps --style=compact
```

### 7.2 Code Generator Optimization (`freezed`, `json_serializable`, `drift`)
Code generators can inflate the Dart AOT snapshot if generating unused code:

* **Freezed**: Disable unused `toString`, `equal`, or `copyWith` if unneeded in data-heavy models:
  ```dart
  @Freezed(toJson: true, fromJson: true, copyWith: false, equal: false, makeCollectionsUnmodifiable: false)
  class Product with _$Product { ... }
  ```
* **JsonSerializable**: Enable `explicit_to_json: false` and `field_rename: FieldRename.snake` globally in `build.yaml` to reuse serializer functions.
* **Drift Database**: Disable unused query generators and FTS5 features if not utilized:
  ```yaml
  # build.yaml
  targets:
    $default:
      builders:
        drift_dev:
          options:
            override_hash_code_and_equals: false
            store_date_time_as_text: true
  ```

### 7.4 SQLite & Drift Pre-Populated Database Asset Optimization

When bundling pre-populated SQLite databases (`.db` or `.sqlite` files) in Flutter assets:

1. **Compact & De-fragment Database Prior to Packaging**:
   Run compaction and index optimization commands in SQLite before copying into `assets/`:
   ```sql
   -- Optimize FTS5 index segments into a single compact tree
   INSERT INTO fts_products(fts_products) VALUES('optimize');

   -- Re-pack pages and reclaim deleted space
   PRAGMA page_size = 4096;
   VACUUM;
   PRAGMA integrity_check;
   ```
2. **Gzip Asset Compression with On-First-Boot Streaming Decompression**:
   Compress pre-populated `.sqlite` database files before adding them to Flutter `pubspec.yaml` assets:
   ```bash
   # Gzip compress database asset (e.g. 15 MB -> 3.8 MB)
   gzip -9 -c assets/database/app_seed.db > assets/database/app_seed.db.gz
   ```
   Decompress to app storage on first boot using Dart's native `GZipDecoder`:
   ```dart
   import 'dart:io';
   import 'package:flutter/services.dart';
   import 'package:archive/archive.dart';

   Future<File> unpackDatabaseAsset(String assetPath, String targetFileName) async {
     final dbFile = File('${(await getApplicationDocumentsDirectory()).path}/$targetFileName');
     if (!await dbFile.exists()) {
       final compressedData = await rootBundle.load(assetPath);
       final decompressedBytes = GZipDecoder().decodeBytes(compressedData.buffer.asUint8List());
       await dbFile.writeAsBytes(decompressedBytes, flush: true);
     }
     return dbFile;
   }
   ```
   * **Impact**: Reduces raw SQLite asset payload size by **60%–75%** inside the APK / AAB.

3. **Data Type & Schema Hygiene**:
   * Store timestamps as **Unix Epoch Integers** (4/8 bytes) instead of ISO8601 strings (24+ bytes).
   * Use integer foreign keys and lookup dictionary tables for repeated strings (e.g., manufacturer/category names).

---

## 8. Web App Bundle Size Optimization (Flutter 3.22+)

For Flutter Web apps, size directly impacts First Contentful Paint (FCP) and Time to Interactive (TTI).

### 8.1 WebAssembly (Wasm) vs CanvasKit vs HTML
Flutter 3.22+ supports **WebAssembly (Wasm)** compilation for Web:

```bash
# Build with WebAssembly (requires modern browser Wasm support)
flutter build web --release --wasm

# Standard JS build flags
flutter build web --release --pwa-strategy=offline-first
```

### 8.2 Server-Side Compression (Gzip / Brotli)
Ensure your host server (Nginx, Firebase Hosting, Cloudflare, Vercel) compresses `.js`, `.wasm`, and `.canvas.js` files:

```nginx
# Nginx Brotli configuration example
brotli on;
brotli_comp_level 6;
brotli_types text/plain text/css application/json application/javascript application/wasm image/svg+xml;
```
* **Impact**: Reduces download payload size by **70%–80%** over the wire.

---

## 9. Real-World Optimization Benchmark & Impact Matrix

Here is a typical production benchmark showing file size reductions across optimization phases:

| Optimization Step | Initial Size | Optimized Size | Size Reduction |
| :--- | :--- | :--- | :--- |
| **Initial Unoptimized Build** (Fat APK) | 48.5 MB | 48.5 MB | Baseline |
| **Android App Bundle (.aab) / ABI Split** | 48.5 MB | 21.2 MB | **-56%** |
| **R8 Shrinking + Resource Shrinking** | 21.2 MB | 16.8 MB | **-21%** |
| **Dart `--obfuscate --split-debug-info`** | 16.8 MB | 14.5 MB | **-14%** |
| **Asset WebP Conversion & Font Subsetting** | 14.5 MB | 9.8 MB | **-32%** |
| **Total Cumulative Savings** | **48.5 MB** | **9.8 MB** | **-79.8%** |

---

## 10. Troubleshooting & Common Pitfalls

| Issue / Crash | Root Cause | Resolution Strategy |
| :--- | :--- | :--- |
| **`ClassNotFoundException` or Drift SQLite crash in release** | R8 stripped Reflection / JNI code | Add `@Keep` annotations or explicit `proguard-rules.pro` keep rules for Drift & SQLite native bindings. |
| **Icons rendered as empty squares `[?]` in release** | Tree-shaking stripped codepoints due to dynamic `IconData` instantiation | Pass static `IconData` constants or use `--no-tree-shake-icons` (only if necessary). |
| **`DeferredLoadException` on feature navigation** | Device lost network connectivity before loading deferred module | Wrap `loadLibrary()` in a retry loop with user error feedback. |
| **App Store rejection: Missing 64-bit architecture** | ABI filter excluded `arm64-v8a` | Ensure `abiFilters += setOf("arm64-v8a")` is included in Gradle settings. |

---

## 11. Size Budgeting & CI/CD Automated Guardrails

Prevent size regression by enforcing automated size limits in CI/CD pipelines (GitHub Actions, Bitrise, Codemagic).

```yaml
name: App Size Audit

on:
  pull_request:
    branches: [ main, master ]

jobs:
  size-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Build AAB and Analyze Size
        run: |
          flutter build appbundle --release --analyze-size > size_report.txt

      - name: Verify Size Threshold (Max 15MB AAB)
        run: |
          AAB_SIZE=$(stat -c%s "build/app/outputs/bundle/release/app-release.aab")
          MAX_SIZE=$((15 * 1024 * 1024))
          echo "Current AAB Size: $AAB_SIZE bytes"
          if [ $AAB_SIZE -gt $MAX_SIZE ]; then
            echo "ERROR: AAB size exceeded budget threshold of 15MB!"
            exit 1
          fi
```

---

## 12. Ultimate Size Reduction Checklist

- [ ] Build release with `--obfuscate --split-debug-info`.
- [ ] Publish as **Android App Bundle (`.aab`)** for Android.
- [ ] Convert all PNG/JPEG assets to lossy/lossless **WebP** (`cwebp -q 80`).
- [ ] Optimize SVG assets using `svgo` and animations using Rive (`.riv`).
- [ ] Subset custom `.ttf`/`.otf` fonts using `pyftsubset`.
- [ ] Enable R8 `isMinifyEnabled = true` and `isShrinkResources = true` in Gradle.
- [ ] Include explicit ProGuard keep rules for Drift, Flutter Engine JNI, and serializations.
- [ ] Exclude unused native locale files and `META-INF` bloat in Gradle packaging options.
- [ ] Set `DEAD_CODE_STRIPPING = YES` and symbol stripping in Xcode.
- [ ] Implement `deferred as` loading for large, non-critical feature screens.
- [ ] Move dynamic heavy assets (>10MB) to Play Asset Delivery (PAD) or On-Demand Resources (ODR).
- [ ] Audit `pubspec.yaml` dependencies and code generator configs (`freezed`, `drift`, `json_serializable`).
- [ ] Enable Gzip / Brotli compression on Web deployment servers.
