# Automated Store Screenshots with Fastlane & Flutter

This guide explains how to generate, localize, and frame automated store screenshots for Google Play Store and Apple App Store using Fastlane (`screengrab` on Android, `snapshot` & `frameit` on iOS) integrated with Flutter's `integration_test`.

---

## 1. Overview & Architecture

Generating screenshots manually across multiple screen sizes, orientations, and localized languages (e.g. `en-US` and `bn-BD`) is error-prone. Fastlane automates UI test driving, capture, and framing with device bezels.

```mermaid
graph TD
    Flutter_Test["Flutter `integration_test`<br/>(`integration_test/screenshot_test.dart`)"] --> Runner["Native Test Runner<br/>(Android Instrumentation / iOS XCTest)"]
    Runner --> Fastlane_Tool["Fastlane Screenshot Tool<br/>• `screengrab` (Android)<br/>• `snapshot` (iOS)"]
    Fastlane_Tool --> Raw_Screenshots["Raw Screenshots Directory<br/>• `android/fastlane/metadata/android/<locale>/images/`<br/>• `ios/fastlane/screenshots/<locale>/`"]
    Raw_Screenshots --> Frameit["`frameit` (Optional)<br/>Add device frames, titles & localized banners"]
    Frameit --> Store_Upload["Fastlane Store Upload<br/>• `upload_to_play_store`<br/>• `upload_to_app_store`"]
```

---

## 2. Android Automated Screenshots with `screengrab`

Fastlane `screengrab` uses Android Espresso / UI Automator or Flutter integration test drivers to capture screenshots on emulators or real devices.

### Directory Configuration
Ensure `android/fastlane/Screengrabfile` is defined:

```ruby
# android/fastlane/Screengrabfile

app_package_name('com.impulseagriscienceltd.impulse_app')
use_tests_in_packages(['com.impulseagriscienceltd.impulse_app.test'])

# Locales to capture
locales(['en-US', 'bn-BD'])

# Target device forms
device_type('phone') # options: phone, seven_inch, ten_inch

# Output path conforming to supply metadata structure
output_directory('fastlane/metadata/android')

clear_previous_screenshots(true)
```

### Running Screengrab
```bash
cd android
bundle exec fastlane screengrab
```

### Required Dimensions for Google Play Store

| Device Category | Min Resolution | Preferred Dimensions | Aspect Ratio |
| :--- | :--- | :--- | :--- |
| **Phone** | $1080 \times 1920$ px | $1080 \times 2400$ px | 16:9 or 20:9 portrait |
| **7-inch Tablet** | $1200 \times 1920$ px | $1200 \times 1920$ px | 16:10 portrait/landscape |
| **10-inch Tablet**| $1600 \times 2560$ px | $1600 \times 2560$ px | 16:10 portrait/landscape |

---

## 3. iOS Automated Screenshots with `snapshot` & `frameit`

### `ios/fastlane/Snapfile` Configuration

```ruby
# ios/fastlane/Snapfile

devices([
  "iPhone 16 Pro Max",
  "iPhone 16",
  "iPad Pro (12.9-inch) (6th generation)"
])

languages([
  "en-US",
  "bn"
])

scheme("Runner")
output_directory("./fastlane/screenshots")
clear_previous_screenshots(true)
```

### Framing Screenshots with `frameit`
Fastlane's `frameit` tool automatically places screenshots inside realistic Apple device frames with customizable colored backgrounds and marketing headlines:

```
fastlane/
└── screenshots/
    ├── Framefile.json
    ├── en-US/
    │   ├── title.strings
    │   ├── keyword.strings
    │   └── ... (raw screenshots)
    └── bn/
        └── ...
```

#### Example `Framefile.json`
```json
{
  "default": {
    "keyword": {
      "font": "./fonts/Roboto-Bold.ttf",
      "color": "#1A56DB"
    },
    "title": {
      "font": "./fonts/Roboto-Regular.ttf",
      "color": "#1F2A37"
    },
    "background": "./backgrounds/clean_slate.png",
    "padding": 50,
    "show_complete_frame": true
  }
}
```

Run framing:
```bash
cd ios
bundle exec fastlane frameit
```

---

## 4. Flutter `integration_test` Integration Recipe

In Flutter, capture points can be triggered directly in integration tests using `integration_test` package:

```dart
// integration_test/screenshot_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:impulse_dex/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture store marketing screenshots', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 1. Home Dashboard
    await binding.takeScreenshot('1_home_dashboard');

    // 2. Product Directory
    final directoryTab = find.text('Products');
    await tester.tap(directoryTab);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('2_product_directory');

    // 3. Product Detail View
    final firstItem = find.byType(ProductCard).first;
    await tester.tap(firstItem);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('3_product_detail');
  });
}
```

---

## 5. Syncing Generated Screenshots to Store Folders

In this repository, `bin/sync_fastlane_assets.dart` audits and syncs screenshots into the exact Fastlane Supply directory hierarchy:

```bash
dart run bin/sync_fastlane_assets.dart
```

Ensure screenshots follow the sequential naming standard:
`1_home.png`, `2_directory.png`, `3_detail.png`, `4_contacts.png`, `5_search.png`.
