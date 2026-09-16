# Multi-Flavor Deployments with Flutter & Fastlane

This guide details configuring and deploying multi-environment Flutter applications (`dev`, `staging`, `prod`) using native Android product flavors, iOS build schemes, and dynamic Fastlane lanes.

---

## 1. Architecture & Naming Conventions

Multi-flavor architectures allow developers to install `dev`, `staging`, and `production` builds simultaneously on the same physical device without overwriting databases or preferences.

```mermaid
graph TD
    subgraph Flavors ["Flutter Product Flavors"]
        Dev["`dev`<br/>`com.company.impulse_app.dev`<br/>Entry: `lib/main_dev.dart`"]
        Staging["`staging`<br/>`com.company.impulse_app.staging`<br/>Entry: `lib/main_staging.dart`"]
        Prod["`prod`<br/>`com.company.impulse_app`<br/>Entry: `lib/main_prod.dart`"]
    end

    subgraph Fastlane_Routing ["Fastlane Lane Routing"]
        Dev --> Lane_Dev["`lane :build_dev`<br/>Firebase App Distribution / Internal"]
        Staging --> Lane_Staging["`lane :build_staging`<br/>Play Store Internal / TestFlight Internal"]
        Prod --> Lane_Prod["`lane :production`<br/>Play Store Closed/Production + App Store"]
    end
```

---

## 2. Android Configuration (`android/app/build.gradle.kts`)

Configure flavor dimensions in `android/app/build.gradle.kts`:

```kotlin
android {
    ...
    flavorDimensions += "environment"

    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Impulse DEX Dev")
        }
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Impulse DEX Staging")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "Impulse DEX")
        }
    }
}
```

---

## 3. Dynamic Android Fastfile for Multi-Flavor Builds

```ruby
# android/fastlane/Fastfile

default_platform(:android)

platform :android do
  desc "Deploy a specific flavor (dev, staging, prod) to Google Play"
  lane :deploy_flavor do |options|
    flavor = options[:flavor] || "prod"
    track  = options[:track]  || (flavor == "prod" ? "production" : "internal")

    # Map package name based on flavor
    base_pkg = "com.impulseagriscienceltd.impulse_app"
    package_name = case flavor
                   when "dev" then "#{base_pkg}.dev"
                   when "staging" then "#{base_pkg}.staging"
                   else base_pkg
                   end

    UI.message("📦 Building and deploying flavor: #{flavor} (#{package_name}) to track: #{track}")

    # 1. Compile flavor with Flutter
    sh("cd ../.. && flutter build appbundle --flavor #{flavor} -t lib/main_#{flavor}.dart --release --obfuscate --split-debug-info=build/app/outputs/symbols")

    # 2. Upload with Supply
    upload_to_play_store(
      package_name: package_name,
      track: track,
      aab: "../build/app/outputs/bundle/#{flavor}Release/app-#{flavor}-release.aab",
      mapping_paths: ["../build/app/outputs/mapping/#{flavor}Release/mapping.txt"],
      skip_upload_apk: true,
      skip_upload_metadata: (flavor != "prod"),
      changes_not_sent_for_review: true
    )
  end
end
```

Running multi-flavor deployments:
```bash
# Deploy dev build to internal track
bundle exec fastlane deploy_flavor flavor:dev

# Deploy staging build
bundle exec fastlane deploy_flavor flavor:staging

# Deploy prod build to production track
bundle exec fastlane deploy_flavor flavor:prod track:production
```

---

## 4. iOS Multi-Scheme Configuration

On iOS, create matching Schemes in Xcode:
- `Runner-Dev` (Bundle ID: `com.impulseagriscienceltd.impulse_app.dev`)
- `Runner-Staging` (Bundle ID: `com.impulseagriscienceltd.impulse_app.staging`)
- `Runner-Prod` (Bundle ID: `com.impulseagriscienceltd.impulse_app`)

In `ios/fastlane/Fastfile`:
```ruby
lane :deploy_ios_flavor do |options|
  flavor = options[:flavor] || "prod"
  scheme = "Runner-#{flavor.capitalize}"

  match(type: "appstore", app_identifier: "com.impulseagriscienceltd.impulse_app#{flavor == 'prod' ? '' : '.' + flavor}")

  build_app(
    workspace: "Runner.xcworkspace",
    scheme: scheme,
    output_directory: "../build/ios/ipa",
    output_name: "impulse_#{flavor}.ipa"
  )

  upload_to_testflight(
    ipa: "../build/ios/ipa/impulse_#{flavor}.ipa",
    groups: ["#{flavor.capitalize} Testers"]
  )
end
```
