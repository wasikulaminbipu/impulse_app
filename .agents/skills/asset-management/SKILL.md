---
name: asset-management
description: Use when adding, optimizing, or referencing images, vector icons, logos, audio/video assets, or custom fonts in this Flutter project.
---

# Asset Management & Media Optimization Guide

This skill details standard operating procedures, architectural conventions, type-safety patterns, and performance optimization rules for managing assets in this Flutter project.

---

## 1. Directory Structure & Conventions

Keep asset directories organized by functional domain under `assets/`. Always reference directory paths with a trailing slash (`/`) in `pubspec.yaml`.

```text
assets/
├── db/                       # Initial database seeds / SQLite pre-populated files
├── fonts/                    # Custom font binaries (.ttf, .otf)
├── icons/                    # General app UI SVG vector icons
├── images/                   # Raster images (splash screen, banners, illustrations)
├── product_image/            # Product-specific catalog images
└── manufacturers_logo/       # Brand & manufacturer logos
```

### Path Declaration (`pubspec.yaml`)
Always register newly added asset folders under `flutter.assets`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/db/
    - assets/images/
    - assets/icons/
    - assets/product_image/
    - assets/manufacturers_logo/
```

---

## 2. Asset Usage Guidelines

### 2.1 Raster Images (`PNG`, `WebP`, `JPEG`)
* **Preferred Format:** Prefer `.webp` (lossy 80-85% quality or lossless) for raster assets (illustrations, photos) due to 30-50% smaller bundle size and faster image decoding performance.
* **Resolution-Aware Density Variants:** For static crisp visuals across DPI densities (MDPI 1.0x, XHDPI 2.0x, XXHDPI 3.0x), place scaling variants in sub-folders matching the asset filename:
  ```text
  assets/images/logo.png
  assets/images/2.0x/logo.png
  assets/images/3.0x/logo.png
  ```
* **Memory-Optimized Rendering:** Always decode high-res images at target container dimensions using `cacheWidth` and `cacheHeight` to avoid excessive RAM consumption:
  ```dart
  Image.asset(
    AppAssets.banner,
    cacheWidth: 800, // Decodes to matching logical density width
    fit: BoxFit.cover,
  );
  ```
* **Network Images:** For dynamic remote assets, use `cached_network_image` with explicit placeholders, error widgets, and disk cache limits instead of bare `Image.network`.

---

### 2.2 Vector Icons & Graphics (`SVG`)
* **Package:** Use the `flutter_svg` package via `SvgPicture.asset()`.
* **Standard Icons:** Prefer native Flutter Material 3 `Icons` / `CupertinoIcons` for standard UI symbols before introducing standalone SVG assets.
* **SVG Usage Pattern:**
  ```dart
  import 'package:flutter_svg/flutter_svg.dart';

  SvgPicture.asset(
    AppAssets.Icons.filter,
    width: 24,
    height: 24,
    colorFilter: ColorFilter.mode(
      Theme.of(context).colorScheme.primary,
      BlendMode.srcIn,
    ),
  );
  ```
* **SVG Optimization:** Run raw SVGs through `svgo` or vector optimizers before checking them into source control to remove unnecessary metadata, editor tags, and unused paths:
  ```bash
  npx svgo -f assets/icons/ -o assets/icons/ --multipass
  ```

---

### 2.3 Fonts & Typography
* **Primary Family:** `Inter` is configured locally in `pubspec.yaml`.
* **Font Registry Standard:**
  ```yaml
  flutter:
    fonts:
      - family: Inter
        fonts:
          - asset: assets/fonts/Inter-Regular.ttf
          - asset: assets/fonts/Inter-Medium.ttf
            weight: 500
          - asset: assets/fonts/Inter-SemiBold.ttf
            weight: 600
          - asset: assets/fonts/Inter-Bold.ttf
            weight: 700
          - asset: assets/fonts/Inter-ExtraBold.ttf
            weight: 800
  ```
* **Theming:** Apply fonts globally via `ThemeData` (e.g. `fontFamily: 'Inter'` or `TextTheme`). Avoid inline string font overrides inside deep child widget `TextStyle`s.
* **Font Subsetting:** For custom icon fonts or non-Latin scripts, use `pyftsubset` to strip unused glyphs and keep font file sizes under 50KB.

---

## 3. Type-Safe Asset Access Strategy

To avoid string typo bugs (`'assets/images/logo.png'`), follow class-based static references:

### Recommended Class Access Pattern
```dart
abstract final class AppAssets {
  static const String logo = 'assets/images/impulse_logo.webp';
  static const String placeholderProduct = 'assets/product_image/placeholder.webp';

  abstract final class Icons {
    static const String filter = 'assets/icons/filter.svg';
    static const String search = 'assets/icons/search.svg';
    static const String phone = 'assets/icons/phone.svg';
    static const String whatsapp = 'assets/icons/whatsapp.svg';
  }

  abstract final class Db {
    static const String preloadedDb = 'assets/db/impulse.db';
  }
}
```

> **Automation (`flutter_gen`):** If adding automated asset code generation, configure `flutter_gen` in `pubspec.yaml` and execute `dart run build_runner build` to produce compile-time safe `Assets.gen.dart` bindings.

---

## 4. Code Quality & Verification Checklist

When adding or updating assets:
1. **Naming:** Use `lower_snake_case` for asset filenames (e.g., `company_logo_dark.webp`, `ic_search.svg`).
2. **Declaration Check:** Verify the folder or file path is present in `pubspec.yaml` under `flutter.assets`.
3. **Format & Sizing:** Check image size (compress large assets >300KB; convert raw PNGs/JPEGs to WebP where appropriate).
4. **Memory Guard:** Verify that large raster images in UI specify `cacheWidth` or `cacheHeight`.
5. **Validation:** Run static code analysis after updating asset logic or constants:
   ```bash
   flutter analyze
   ```
