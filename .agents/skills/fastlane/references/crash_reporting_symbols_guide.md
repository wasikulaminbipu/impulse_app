# Crash Reporting & Symbol De-obfuscation Guide for Fastlane

This guide details the automated extraction, packaging, and uploading of Flutter debug symbols, native `.so` de-symbolication files, ProGuard/R8 mappings, and iOS dSYMs to Firebase Crashlytics and Sentry via Fastlane.

---

## 1. Symbol Architecture in Flutter

When Flutter apps are built with `--obfuscate --split-debug-info`, crash stack traces contain hexadecimal memory offsets rather than readable file and line numbers. Full symbolication requires multiple independent symbol files:

| Artifact Type | Path | Purpose | Target Service |
|---|---|---|---|
| **Dart AOT Symbols** | `<split-dir>/app.android-arm64.symbols` | Symbolicate Flutter Dart exceptions | Crashlytics / Sentry |
| **ProGuard/R8 Mapping** | `android/app/build/outputs/mapping/release/mapping.txt` | De-obfuscate Java/Kotlin Android runtime stack traces | Google Play / Crashlytics |
| **Native C/C++ Symbols** | `android/app/build/intermediates/merged_native_libs/release/out/lib/` | Symbolicate NDK and Flutter engine native crashes | Google Play Console / Crashlytics |
| **iOS dSYMs** | `build/ios/archive/Runner.xcarchive/dSYMs` | Symbolicate iOS native Objective-C/Swift & Mach-O crashes | App Store Connect / Crashlytics |

---

## 2. Firebase Crashlytics Symbol Upload in Fastlane

### Android Fastfile Lane
```ruby
desc "Upload Android symbols to Firebase Crashlytics"
lane :upload_android_crashlytics_symbols do |options|
  # 1. Upload ProGuard / R8 mapping file
  mapping_file = "../build/app/outputs/mapping/release/mapping.txt"
  if File.exist?(mapping_file)
    upload_symbols_to_crashlytics(
      mapping_path: mapping_file,
      gsp_path: "../android/app/google-services.json"
    )
  end

  # 2. Upload Native C++ & Dart symbols using Firebase CLI
  symbols_dir = "../build/app/outputs/symbols"
  if Dir.exist?(symbols_dir)
    sh("firebase crashlytics:symbols:upload --app=#{ENV['FIREBASE_ANDROID_APP_ID']} #{symbols_dir}")
  end
end
```

### iOS Fastfile Lane
```ruby
desc "Upload iOS dSYMs to Firebase Crashlytics"
lane :upload_ios_crashlytics_symbols do
  # Download dSYMs from App Store Connect (if bitcode was enabled or processed on Apple servers)
  # download_dsyms(version: "latest")

  # Upload local build dSYMs
  upload_symbols_to_crashlytics(
    dsym_path: "../build/ios/archive/Runner.xcarchive/dSYMs",
    gsp_path: "../ios/Runner/GoogleService-Info.plist"
  )

  clean_build_artifacts
end
```

---

## 3. Sentry Symbol Upload via Fastlane

Using the `fastlane-plugin-sentry`:

```ruby
desc "Upload debug symbols and create release on Sentry"
lane :sentry_release do |options|
  version = options[:version] # e.g. "1.0.4+5"

  sentry_create_release(
    auth_token: ENV["SENTRY_AUTH_TOKEN"],
    org_slug: ENV["SENTRY_ORG_SLUG"],
    project_slug: ENV["SENTRY_PROJECT_SLUG"],
    version: version,
    finalize: true
  )

  # Upload Android ProGuard + Dart symbols
  sentry_upload_dif(
    auth_token: ENV["SENTRY_AUTH_TOKEN"],
    org_slug: ENV["SENTRY_ORG_SLUG"],
    project_slug: ENV["SENTRY_PROJECT_SLUG"],
    path: "../build/symbols",
    include_sources: false
  )
end
```

---

## 4. Google Play Console Native Debug Symbol Upload (Supply)

Fastlane `upload_to_play_store` (`supply`) natively supports uploading native debug symbols (`native_symbols`) alongside the App Bundle:

```ruby
upload_to_play_store(
  track: "production",
  aab: "../build/app/outputs/bundle/release/app-release.aab",
  mapping_paths: ["../build/app/outputs/mapping/release/mapping.txt"],
  # Zipped native C++ and Dart symbols for Play Console ANR & Crash de-symbolication
  native_symbols: "../build/app/outputs/symbols/native-symbols.zip"
)
```
