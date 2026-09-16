# Play Asset Delivery (PAD) & Dynamic Feature Modules with Fastlane

This guide explains how to package, verify, and upload Android App Bundles containing **Play Asset Delivery (PAD)** and **Dynamic Feature Modules (DFMs)** using Fastlane and `bundletool`.

---

## 1. Play Asset Delivery (PAD) Architecture

For Flutter applications requiring large offline assets (e.g. multi-gigabyte SQLite databases, video datasets, 3D models), embedding assets directly in the base APK bloats download sizes. PAD enables splitting assets into:
- **`install-time`**: Downloaded concurrently with base app; transparent to app code via native asset managers.
- **`fast-follow`**: Downloaded automatically immediately after installation.
- **`on-demand`**: Downloaded programmatically in Dart via `flutter_play_asset_delivery`.

---

## 2. Directory Structure in Flutter/Gradle

```
android/
├── app/
│   └── build.gradle.kts
├── asset_pack_offline_db/
│   ├── build.gradle.kts      # apply plugin: "com.android.asset-pack"
│   └── src/
│       └── main/
│           └── assets/       # Large assets placed here
└── settings.gradle.kts       # include(":asset_pack_offline_db")
```

`asset_pack_offline_db/build.gradle.kts`:
```kotlin
plugins {
    id("com.android.asset-pack")
}

assetPack {
    packName.set("asset_pack_offline_db")
    dynamicDelivery {
        deliveryType.set("install-time")
    }
}
```

In `android/app/build.gradle.kts`:
```kotlin
android {
    assetPacks = [":asset_pack_offline_db"]
}
```

---

## 3. Fastlane Verification for Asset Packs

When compiling with Flutter, run `flutter build appbundle`. Fastlane verifies that the asset pack is bundled inside the generated `.aab`:

```ruby
desc "Verify Android App Bundle contains all expected Asset Packs"
lane :verify_asset_packs do |options|
  aab_path = options[:aab] || "../build/app/outputs/bundle/release/app-release.aab"
  expected_pack = options[:pack_name] || "asset_pack_offline_db"

  UI.message("Auditing AAB asset pack archive...")
  entries = sh("unzip -l #{aab_path}")

  unless entries.include?("#{expected_pack}/")
    UI.user_error!("❌ Asset pack '#{expected_pack}' not found in App Bundle!")
  end

  UI.success("✅ Asset pack '#{expected_pack}' successfully verified in AAB.")
end
```

Fastlane's standard `upload_to_play_store` (`supply`) uploads the complete multi-gigabyte bundle directly via Google Play Developer API v3 chunked upload.
