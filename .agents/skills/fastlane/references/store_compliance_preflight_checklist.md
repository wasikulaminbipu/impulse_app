# Store Publishing & Technical Compliance Pre-Flight Checklist

Before publishing Flutter mobile applications to the Google Play Console or Apple App Store via Fastlane, execute this technical compliance checklist to prevent store rejections.

---

## 1. Google Play Store Technical Checklist (Android 15 / API 35+)

- [ ] **Target API Level**: `targetSdk = 35` (or higher) configured in `android/app/build.gradle.kts`.
- [ ] **16 KB Memory Page Size Alignment**: Native C/C++ libraries (`.so` files in NDK, SQLite, or image rendering plugins) must support 16 KB memory page sizes required by 64-bit ARM Android 15+ devices:
  ```bash
  zipinfo -v build/app/outputs/bundle/release/app-release.aab | grep -E 'alig|page'
  ```
- [ ] **ProGuard/R8 De-obfuscation Mapping**: Verification that `build/app/outputs/mapping/release/mapping.txt` exists and is passed to `upload_to_play_store(mapping_paths: [...])`.
- [ ] **Native Debug Symbols**: Native unstripped `.so` debug archives passed to `native_debug_symbol_paths` for C/C++ crash stack trace reconstruction.
- [ ] **Metadata Character Lengths**:
  - `title.txt`: $\le 30$ characters.
  - `short_description.txt`: $\le 80$ characters.
  - `full_description.txt`: $\le 4000$ characters.
  - `changelogs/<version_code>.txt`: **Strict $\le 500$ characters**.
- [ ] **Graphic Asset Dimensions**:
  - App Icon: $512 \times 512$ PNG (32-bit with alpha, max 1024 KB).
  - Feature Graphic: $1024 \times 500$ PNG/JPEG (no alpha channel).
  - Screenshots: Minimum 2 per device form, $1080 \times 1920$ or $1080 \times 2400$ px.
- [ ] **Data Safety & Permissions Alignment**: Every permission in `AndroidManifest.xml` (e.g. `INTERNET`, `READ_CONTACTS`, `POST_NOTIFICATIONS`) must have a corresponding declaration in the Play Console Data Safety form.

---

## 2. Apple App Store Compliance Checklist (iOS 17+)

- [ ] **Privacy Manifest (`PrivacyInfo.xcprivacy`)**: Required Reason APIs (e.g. UserDefaults access, file timestamps) declared in `ios/Runner/PrivacyInfo.xcprivacy`.
- [ ] **Export Compliance Declaration**: Ensure `ITSAppUsesNonExemptEncryption` is set to `<false/>` in `Info.plist` or configured in Fastlane:
  ```ruby
  submission_information: {
    export_compliance_uses_encryption: false
  }
  ```
- [ ] **App Store Connect API Authentication**: Using `.p8` key content rather than username/password.
- [ ] **TestFlight Internal vs External Groups**: Verify external groups have release notes and required tester permissions.
- [ ] **Phased Release Protocol**: Enabled (`phased_release: true`) to mitigate critical day-1 regressions.

---

## 3. Automated Gating Command in This Project

In this codebase, compliance checks are executed automatically via:

```bash
# 1. Play Store 36-Point Compliance Audit
dart run bin/audit_playstore_compliance.dart

# 2. Fastlane Configuration & Metadata Limits Audit
dart run bin/audit_fastlane.dart

# 3. Fastlane Store Graphics & Screenshots Audit
dart run bin/sync_fastlane_assets.dart
```
