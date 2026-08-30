---
name: playstore-release
description: Use when releasing Flutter applications to Google Play Store, managing Target SDK 35/Android 15 compliance, 16KB page alignment, Data Safety, ProGuard/R8 obfuscation, Fastlane/Supply automation, and GitHub Actions CI/CD publishing.
---

# Google Play Store Release & Policy Compliance Skill

Use this skill when preparing, building, configuring, obfuscating, testing, and publishing Flutter Android applications to the Google Play Console, ensuring full compliance with Google Play Store rules, security policies, and technical requirements.

---

## 1. Prerequisites & Play Console Setup

1. **Google Play Developer Account**:
   - Register at [Google Play Console](https://play.google.com/console).
   - Pay the one-time $25 USD registration fee.
   - Complete identity verification (Individual or Organization D-U-N-S number if required).

2. **Testing & Approval Requirements (Personal Accounts created after Nov 13, 2023)**:
   - **Mandatory Closed Test**: Must run a Closed Test with at least **20 opted-in testers** active for **14 continuous days** before requesting production publishing access.
   - **Best Practices for Passing Production Access Review**:
     - Keep testers active throughout the entire 14-day window (encourage app opens, feedback submission).
     - Submit detailed answers in the production access request form (explain app target audience, bug fixes made during closed testing, and tester engagement).

---

## 2. Technical & Target API Level Requirements (Android 15 / SDK 35+)

1. **Package Name / Application ID**:
   - Ensure a unique `applicationId` in `android/app/build.gradle.kts` (or `build.gradle`):
     ```kotlin
     defaultConfig {
         applicationId = "com.company.impulsedex"
         minSdk = 24
         targetSdk = 35
         versionCode = flutter.versionCode
         versionName = flutter.versionName
     }
     ```

2. **Android 15 Edge-to-Edge Layout & Predictive Back Handling**:
   - **Edge-to-Edge**: Android 15 forces edge-to-edge layouts by default. In `MainActivity.kt`:
     ```kotlin
     import androidx.activity.enableEdgeToEdge
     import io.flutter.embedding.android.FlutterActivity

     class MainActivity: FlutterActivity() {
         override fun onCreate(savedInstanceState: android.os.Bundle?) {
             enableEdgeToEdge()
             super.onCreate(savedInstanceState)
         }
     }
     ```
   - **Predictive Back in Flutter**: Handle gestures using `PopScope`:
     ```dart
     PopScope(
       canPop: false,
       onPopInvokedWithResult: (didPop, result) {
         if (didPop) return;
         // Handle back navigation logic
       },
       child: Scaffold(...),
     )
     ```

3. **Target API Level & 16 KB Page Alignment**:
   - **Target SDK Requirement**: Google Play requires new apps and updates to target Android 15 (Target SDK 35 / API 35+) or latest Google policy threshold.
   - **16 KB Memory Page Alignment**: Ensure native libraries (`.so` files from NDK, C/C++ dependencies, or older Flutter plugins) support 16 KB page sizes required for 64-bit ARM Android 15+ devices.
     - Check alignment using zipinfo:
       ```bash
       zipinfo -v app-release.aab | grep -E 'alig|page'
       ```

4. **Product Flavors Configuration (`build.gradle.kts`)**:
   ```kotlin
   flavorDimensions += "environment"
   productFlavors {
       create("dev") {
           dimension = "environment"
           applicationIdSuffix = ".dev"
           resValue("string", "app_name", "Impulse DEX Dev")
       }
       create("prod") {
           dimension = "environment"
           resValue("string", "app_name", "Impulse DEX")
       }
   }
   ```
   Build flavor AAB:
   ```bash
   flutter build appbundle --flavor prod --target lib/main_prod.dart --release
   ```

5. **App Signing & `key.properties` Setup**:
   - **Generate Upload Keystore**:
     ```bash
     keytool -genkey -v -keystore android/app/release-upload-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
     ```
   - **Store Credentials in `android/key.properties`** (add to `.gitignore`):
     ```properties
     storePassword=YOUR_STORE_PASSWORD
     keyPassword=YOUR_KEY_PASSWORD
     keyAlias=upload
     storeFile=release-upload-key.jks
     ```
   - **Configure Gradle Signing (`android/app/build.gradle.kts`)**:
     ```kotlin
     import java.io.FileInputStream
     import java.util.Properties

     val keystoreProperties = Properties()
     val keystorePropertiesFile = rootProject.file("key.properties")
     if (keystorePropertiesFile.exists()) {
         keystoreProperties.load(FileInputStream(keystorePropertiesFile))
     }

     android {
         signingConfigs {
             create("release") {
                 keyAlias = keystoreProperties["keyAlias"] as String?
                 keyPassword = keystoreProperties["keyPassword"] as String?
                 storeFile = keystoreProperties["storeFile"]?.let { file(it) }
                 storePassword = keystoreProperties["storePassword"] as String?
             }
         }
         buildTypes {
             release {
                 signingConfig = signingConfigs.getByName("release")
                 isMinifyEnabled = true
                 isShrinkResources = true
                 proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
             }
         }
     }
     ```

---

## 3. ProGuard / R8 Obfuscation & Native Symbolization

1. **Obfuscation Rules (`android/app/proguard-rules.pro`)**:
   ```proguard
   # Flutter Core Rules
   -keep class io.flutter.app.** { *; }
   -keep class io.flutter.plugin.** { *; }
   -keep class io.flutter.util.** { *; }
   -keep class io.flutter.view.** { *; }
   -keep class io.flutter.embedding.** { *; }
   -keep class io.flutter.provider.** { *; }
   -keep class io.flutter.plugins.** { *; }

   # Keep Drift / SQLite / Freezed Generated Classes
   -keepclasseswithmembers class * {
       @com.google.gson.annotations.SerializedName <fields>;
   }
   -keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

   # Firebase & Google Play Services
   -keep class com.google.android.gms.** { *; }
   -keep class com.google.firebase.** { *; }
   ```

2. **Native Symbol Extraction & Upload**:
   - Build AAB with split debug symbols:
     ```bash
     flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
     ```
   - Pass symbols & ProGuard mapping file to Fastlane `upload_to_play_store`:
     ```ruby
     upload_to_play_store(
       track: 'production',
       aab: '../build/app/outputs/bundle/prodRelease/app-prod-release.aab',
       mapping_paths: ['../build/app/outputs/mapping/prodRelease/mapping.txt']
     )
     ```

---

## 4. Google Play Commerce & Billing 7.0+ Integration

- **Mandatory Policy**: All apps selling digital goods or subscriptions inside Android apps must use Google Play Billing.
- **Flutter Implementation**: Use `in_app_purchase` package matching Play Billing Library 7.0+:
  ```dart
  import 'package:in_app_purchase/in_app_purchase.dart';

  final InAppPurchase _iap = InAppPurchase.instance;

  Future<void> initializeBilling() async {
    final bool available = await _iap.isAvailable();
    if (available) {
      _iap.purchaseStream.listen((purchaseDetailsList) {
        _handlePurchases(purchaseDetailsList);
      });
    }
  }
  ```
- **Real-Time Developer Notifications (RTDN)**: Set up Google Cloud Pub/Sub topics to receive server-side webhooks for subscription renewals, cancellations, or grace period events.

---

## 5. Local App Bundle Testing (`bundletool` CLI)

Before uploading an `.aab` to Play Console, test device installation locally using `bundletool`:

1. **Generate APK set from AAB**:
   ```bash
   bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab \
     --output=build/app/outputs/bundle/release/app.apks \
     --ks=android/app/release-upload-key.jks \
     --ks-pass=pass:YOUR_STORE_PASSWORD \
     --ks-key-alias=upload \
     --key-pass=pass:YOUR_KEY_PASSWORD
   ```

2. **Install on Connected Android Device**:
   ```bash
   bundletool install-apks --apks=build/app/outputs/bundle/release/app.apks
   ```

3. **Calculate Device Download Size**:
   ```bash
   bundletool get-size total --apks=build/app/outputs/bundle/release/app.apks
   ```

---

## 6. Enterprise Managed Configurations & Store Experiments

### A. Managed Configurations (`app_restrictions.xml`)
For enterprise / B2B deployment via Google Play Private Apps or EMM (Knox / Workspace ONE):
1. Define `android/app/src/main/res/xml/app_restrictions.xml`:
   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <restrictions xmlns:android="http://schemas.android.com/apk/res/android">
       <restriction
           android:key="server_url"
           android:title="Server URL"
           android:restrictionType="string"
           android:defaultValue="https://api.impulsedex.com" />
   </restrictions>
   ```
2. Reference restriction file in `AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="android.content.APP_RESTRICTIONS"
       android:resource="@xml/app_restrictions" />
   ```

### B. Store Listing Experiments (A/B Testing)
- Run Play Console experiments comparing up to 3 graphics/metadata variants against baseline.
- Minimum recommended duration: 7 days or until 90%+ statistical significance is achieved before applying winner.

---

## 7. Specialized Domain Compliance (Health, FinTech, Families, News)

### A. Health & Medical Apps Policy
- **Health Connect Integration**: Declare explicit Health Connect permissions (`android.permission.health.READ_STEPS`, `READ_HEART_RATE`) in manifest and register app in Play Console Health Apps declaration.
- **Medical Disclaimer**: Apps providing health advice must explicitly state in app and listing: *"For informational purposes only; not a substitute for professional medical advice, diagnosis, or treatment."*
- **Privacy & HIPAA**: Health data must never be transmitted unencrypted or shared with ad networks.

### B. Financial Services & FinTech Policy
- **Regulatory Disclosures**: Must provide proof of licensing (e.g. Central Bank, SEC, or Banking License) in Play Console declaration form.
- **Personal Loans**: Short-term loans requiring full repayment in 60 days or less are prohibited.
- **Forbidden Permissions**: Financial apps are strictly prohibited from using `READ_SMS`, `RECEIVE_SMS`, or `READ_CALL_LOG` for credit scoring.

### C. Families & Kids Policy (Target Age < 13)
- **Neutral Age Screen**: Must use an un-populated date-of-birth picker (no default pre-selected year).
- **Certified Ad SDKs**: Must only use Google Play Certified SDKs for Families (e.g. AdMob for Families).
- **AAID & Location Ban**: Never collect Advertising ID (`AAID`) or precise location for users under 13.

### D. News & Media Apps Policy
- Must provide verifiable publisher contact details (physical address, official email, phone number) on the app page and website.
- Complete the News App declaration form in Google Play Console.

---

## 8. In-App Updates, Reviews & Play Asset Delivery (PAD)

### A. In-App Updates (`in_app_update` Package)
Force or suggest updates directly within the application flow:
```dart
import 'package:in_app_update/in_app_update.dart';

Future<void> checkForAppUpdate() async {
  final info = await InAppUpdate.checkForUpdateAvailability();
  if (info.updateAvailability == UpdateAvailability.updateAvailable) {
    if (info.immediateUpdateAllowed) {
      await InAppUpdate.performImmediateUpdate();
    } else if (info.flexibleUpdateAllowed) {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    }
  }
}
```

### B. In-App Reviews (`in_app_review` Package)
Prompt users for rating/reviews without interrupting experience:
```dart
import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

if (await inAppReview.isAvailable()) {
  await inAppReview.requestReview();
}
```

### C. Play Asset Delivery (PAD) for Large Downloads (>150MB)
For Flutter apps with large offline asset bundles (e.g., SQLite databases, videos, 3D assets):
1. Use `fast-follow` or `on-demand` asset packs.
2. Declare pack module in `android/settings.gradle.kts`:
   ```kotlin
   include(":asset_pack_name")
   ```
3. Fetch packs at runtime using Play Asset Delivery API.

---

## 9. Required Documentation & Google Play Policies

1. **Privacy Policy**: Must provide a live, publicly accessible, non-geoblocked HTTPS URL.
2. **Data Safety Questionnaire**: Accurately map SDK usages (Firebase Analytics, Crashlytics, AdMob, Sentry, Location APIs).
3. **Account Deletion & Data Deletion Requirements**: Mandatory in-app deletion settings + web-based deletion request URL.
4. **Restricted Permissions & Declarations**:
   - **Foreground Services (Android 14+)**: Declare explicit `android:foregroundServiceType` in `AndroidManifest.xml`.
   - **High-Risk Permissions**: Justify `QUERY_ALL_PACKAGES`, `READ_MEDIA_*`, `SCHEDULE_EXACT_ALARM`.
5. **Play Integrity API & Security Hygiene**: Protect endpoints against tampered binaries and unauthorized clients.

---

## 10. Play Store Rejection & Policy Recovery Matrix

| Rejection / Warning Issue | Root Cause | Actionable Resolution Strategy |
| :--- | :--- | :--- |
| **`QUERY_ALL_PACKAGES` Rejection** | Broad package visibility permission declared in manifest. | Remove `QUERY_ALL_PACKAGES`. Replace with specific `<queries>` intent declarations in `AndroidManifest.xml`. |
| **Background Location Rejected** | `ACCESS_BACKGROUND_LOCATION` missing video proof or clear core feature justification. | Record video showing clear user opt-in dialog and in-app background usage. Submit link in Play Console permission declaration form. |
| **Play Protect Warning / False Positive** | Unsigned binary, dynamic code loading, or obfuscation flag triggering security scanner. | Verify upload key signature, remove unused third-party binary blobs, and submit SHA256 appeal to Google Play Protect support. |
| **Account Deletion URL Missing** | Play Console policy violation for missing web deletion link. | Deploy web page with a form allowing users to submit account/data deletion requests without app login. |
| **Lost Upload Keystore** | Lost `.jks` file or forgotten passwords. | Generate new keystore, export PEM cert (`keytool -exportcert -alias upload -keystore new-key.jks -rfc -file upload_cert.pem`), and request upload key reset via Play Console Support. |

---

## 11. Automated Deployment via Fastlane & GitHub Actions

### A. Fastlane Setup & Localized Metadata (`android/fastlane`)

Structure localized metadata in `android/fastlane/metadata/android/`:
```text
android/fastlane/metadata/android/
├── en-US/
│   ├── title.txt
│   ├── short_description.txt
│   ├── full_description.txt
│   └── images/
│       ├── icon.png
│       └── phoneScreenshots/
└── bn-BD/
    ├── title.txt
    ├── short_description.txt
    └── full_description.txt
```

### B. Fastlane `Fastfile` (`android/fastlane/Fastfile`)
```ruby
default_platform(:android)

platform :android do
  desc "Deploy Internal QA Build to Firebase App Distribution"
  lane :firebase_qa do
    firebase_app_distribution(
      app: ENV["FIREBASE_APP_ID"],
      groups: "internal-qa",
      release_notes: "Internal build from CLI"
    )
  end

  desc "Deploy to Google Play Internal Testing Track"
  lane :internal do
    upload_to_play_store(
      track: 'internal',
      aab: '../build/app/outputs/bundle/prodRelease/app-prod-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/prodRelease/mapping.txt'],
      skip_upload_apk: true,
      skip_upload_metadata: false,
      skip_upload_images: true
    )
  end

  desc "Deploy to Production with 10% Staged Rollout"
  lane :production do
    upload_to_play_store(
      track: 'production',
      aab: '../build/app/outputs/bundle/prodRelease/app-prod-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/prodRelease/mapping.txt'],
      user_fraction: 0.10
    )
  end
end
```

### C. GitHub Actions CI/CD Pipeline (`.github/workflows/deploy_playstore.yml`)

```yaml
name: Build & Deploy to Play Store

on:
  push:
    tags:
      - 'v*'
  workflow_dispatch:
    inputs:
      track:
        description: 'Play Store Track'
        required: true
        default: 'internal'
        type: choice
        options:
          - internal
          - beta
          - production
      create_github_release:
        description: 'Create GitHub Release'
        required: false
        default: true
        type: boolean

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

permissions:
  contents: write

jobs:
  quality-gate:
    name: Lint & Unit Testing
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v5

      - name: Set up Java JDK (Temurin 17)
        uses: actions/setup-java@v5
        with:
          distribution: 'temurin'
          java-version: '17'
          cache: 'gradle'

      - name: Set up Flutter SDK
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Install Dependencies
        run: flutter pub get

      - name: Run Code Generator Check (Drift & Freezed)
        run: |
          dart run build_runner build --delete-conflicting-outputs
          git diff --exit-code lib/ || (echo "::error::Generated code is out of sync! Please run build_runner locally and commit changes." && exit 1)

      - name: Run Strict Static Analysis (Fatal Warnings)
        run: flutter analyze --fatal-infos --fatal-warnings

      - name: Run Unit & Widget Tests with Coverage
        run: flutter test --coverage

  build-and-deploy:
    name: Build AAB & Deploy via Fastlane
    needs: quality-gate
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v5
        with:
          fetch-depth: 0

      - name: Set up Java JDK (Temurin 17)
        uses: actions/setup-java@v5
        with:
          distribution: 'temurin'
          java-version: '17'
          cache: 'gradle'

      - name: Set up Flutter SDK
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Set up Ruby & Fastlane
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          working-directory: 'android'
          bundler-cache: true

      - name: Validate & Decode Secrets
        env:
          KEYSTORE_BASE64: ${{ secrets.PLAYSTORE_UPLOAD_KEYSTORE_BASE64 }}
          KEY_PROPERTIES: ${{ secrets.PLAYSTORE_KEY_PROPERTIES }}
          PLAYSTORE_JSON_KEY: ${{ secrets.PLAYSTORE_SERVICE_ACCOUNT_JSON }}
        run: |
          set -e
          if [ -z "$KEYSTORE_BASE64" ]; then
            echo "::error::PLAYSTORE_UPLOAD_KEYSTORE_BASE64 secret is missing!"
            exit 1
          fi
          printf '%s' "$KEYSTORE_BASE64" | tr -d ' \r\n' | base64 --decode > android/app/key.p12
          cp android/app/key.p12 android/key.p12 2>/dev/null || true
          if [ -n "$KEY_PROPERTIES" ]; then
            echo "$KEY_PROPERTIES" > android/key.properties
          fi
          if [ -n "$PLAYSTORE_JSON_KEY" ]; then
            echo "$PLAYSTORE_JSON_KEY" > android/pc-api-key.json
          fi

      - name: Install Flutter Dependencies & Run Code Generator
        run: |
          flutter pub get
          dart run build_runner build --delete-conflicting-outputs

      - name: Build Android App Bundle (AAB) & APKs
        run: |
          flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
          flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols

      - name: Upload Build Artifacts
        uses: actions/upload-artifact@v6
        with:
          name: app-release-${{ github.ref_name }}
          path: |
            build/app/outputs/bundle/release/app-release.aab
            build/app/outputs/flutter-apk/*.apk
            build/app/outputs/mapping/release/mapping.txt
            build/app/outputs/symbols/

      - name: Deploy to Play Store via Fastlane
        env:
          TRACK: ${{ github.event.inputs.track || 'internal' }}
        run: |
          if [ ! -s android/pc-api-key.json ]; then
            echo "Skipping Play Store deployment because android/pc-api-key.json is missing or empty."
          else
            cd android
            bundle exec fastlane $TRACK
          fi

      - name: Create GitHub Release
        if: startsWith(github.ref, 'refs/tags/') && (github.event.inputs.create_github_release == 'true' || github.event_name == 'push')
        uses: softprops/action-gh-release@v3
        with:
          files: |
            build/app/outputs/bundle/release/app-release.aab
            build/app/outputs/flutter-apk/app-release.apk
          generate_release_notes: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

---

---

## 12. Automated Enterprise Release Protocol & Verification Matrix

Whenever releasing the app (via AI or terminal `dart run bin/release.dart`), strictly follow the 8-stage publishing pipeline:

| Stage | Action / Step | Command / Tool |
| :--- | :--- | :--- |
| **0. Git & Secrets** | Branch check (`main`), pull rebase, secrets check | `git checkout main && git pull --rebase` & `gh secret list` |
| **1. Regeneration** | Code models, Freezed, Drift DAOs | `dart run build_runner build --delete-conflicting-outputs` |
| | Native Splash Screen | `dart run flutter_native_splash:create` |
| | Launcher Icons (Android/iOS) | `dart run flutter_launcher_icons` |
| | SQLite Database Integrity | `dart run bin/validate_db.dart` |
| | Asset Inventory Audit | `dart run bin/audit_assets.dart` |
| | Android App Links Deep Linking | `dart run bin/audit_app_links.dart` |
| **2. Quality Gate** | Strict Static Analysis | `flutter analyze --fatal-infos --fatal-warnings` |
| | Play Store Policy Audit | `dart run bin/audit_playstore_compliance.dart` |
| | Full Automated Test Suite | `flutter test` |
| **3. Privacy Check** | Policy URL & Data Safety | Verify HTTPS URL accessibility & check manifest permissions |
| **4. Versioning & Changelogs** | Bump SemVer & Fastlane Notes (500 char limit) | `pubspec.yaml` (X.Y.Z+N), `CHANGELOG.md`, `metadata/android/` |
| **5. Git Tagging** | Stage, Commit & Tag | `git add -A && git commit && git tag -a vX.Y.Z` |
| **6. Push to Origin** | Branch & Tag Push | `git push origin main && git push origin vX.Y.Z` |
| **7. CI/CD Monitoring** | Live GitHub Actions Watch & Zero-Guess Loop | `gh run watch` & inspect failures with zero guessing |
| **8. Rollback Protocol** | Tag Abort & Remote Cleanup | `dart run bin/release.dart --abort-tag=vX.Y.Z` |

---

## 13. Pre-Flight Verification Checklist


- [ ] `applicationId` changed from default `com.example.*`.
- [ ] `targetSdkVersion` set to 35+ (Android 15 compliance).
- [ ] Edge-to-edge layout & `PopScope` predictive back tested.
- [ ] Product Flavors (`dev`, `prod`) configured correctly.
- [ ] Native libraries verified for 16KB memory page alignment.
- [ ] Local AAB tested via `bundletool build-apks` and `bundletool install-apks`.
- [ ] Obfuscation `--obfuscate` enabled and ProGuard mapping / split debug symbols uploaded.
- [ ] Enterprise Managed Configurations (`app_restrictions.xml`) declared if applicable.
- [ ] Specialized Domain Policies verified (Health Connect, Financial license disclosures, Neutral Age screen for Kids, News publisher contact info).
- [ ] Google Play Billing Library 7.0+ compliance verified for digital goods.
- [ ] In-App Update API integrated for mandatory update notifications.
- [ ] Live HTTPS Privacy Policy URL configured in Play Console & app settings.
- [ ] Account Deletion web request URL configured.
- [ ] Data Safety Questionnaire accurately matches all SDK dependencies.
- [ ] Fastlane localized metadata (`metadata/android/`) updated.
- [ ] Policy Rejection Matrix reviewed for restricted permissions and manifest declarations.
- [ ] Automated Fastlane / GitHub Actions pipeline verified.

