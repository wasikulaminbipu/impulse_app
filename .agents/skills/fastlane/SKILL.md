---
name: fastlane
description: Use when configuring, executing, or debugging Fastlane automation for Flutter, Android, or iOS apps, including Google Play Store deployment (supply), TestFlight/App Store (pilot, gym, match, deliver), metadata sync, release promotion, and CI/CD execution.
---

# Enterprise Fastlane Automation Skill for Flutter

Use this skill when designing, configuring, executing, debugging, or maintaining Fastlane automation pipelines for Flutter applications across Android and iOS. This guide reflects Fastlane 2.239+ conventions, Google Play Developer API v3, App Store Connect API authentication, Android 15 (Target SDK 35+) 16KB page alignment, and enterprise CI/CD integration patterns.

---

## 1. Overview & Flutter Architecture Topology

In cross-platform Flutter codebases, Fastlane operates natively within the `android/` and `ios/` platform subdirectories. Flutter handles cross-platform compilation and obfuscation (`flutter build appbundle`, `flutter build ipa`), while Fastlane manages code signing, provisioning, artifact verification, store metadata synchronization, track deployment, and staged release promotion.

```mermaid
graph TD
    subgraph Flutter_Host ["Flutter Workspace Root"]
        Dev["Developer CLI / GitHub Actions"] --> Flutter_Build["Flutter Build Phase<br/>• `flutter build appbundle --release`<br/>• `flutter build ipa --release`<br/>• De-obfuscation Symbols & Mapping"]
    end

    subgraph Android_Engine ["Android Engine (`android/`)"]
        Flutter_Build --> Android_Fastlane["`android/fastlane/Fastfile`<br/>• `upload_to_play_store` (`supply`)"]
        Android_Fastlane --> Play_Tracks["Google Play Console Tracks<br/>• Internal Testing<br/>• Closed Testing (Alpha / Beta)<br/>• Production (Staged Rollout)"]
        Android_Fastlane --> Play_Meta["Store Metadata & Assets<br/>• `metadata/android/<locale>/`<br/>• Title, Short/Full Descriptions<br/>• Changelogs (<= 500 chars)<br/>• Icons & Screenshots"]
    end

    subgraph iOS_Engine ["iOS Engine (`ios/`)"]
        Flutter_Build --> iOS_Fastlane["`ios/fastlane/Fastfile`<br/>• `match` (Certificates & Profiles)<br/>• `build_app` (`gym`)<br/>• `upload_to_testflight` (`pilot`)<br/>• `upload_to_app_store` (`deliver`)"]
        iOS_Fastlane --> TestFlight["TestFlight Beta"]
        iOS_Fastlane --> AppStore["Apple App Store Production"]
    end
```

### Reference Architecture & Templates
- [Play Store & Fastlane Supply Deep Reference](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/playstore_supply_reference.md)
- [iOS Match, TestFlight & App Store Deep Reference](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/ios_match_appstore_reference.md)
- [In-App Updates & Release Priority Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/in_app_updates_and_version_priority_guide.md)
- [Store Publishing & Technical Compliance Pre-Flight Checklist](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/store_compliance_preflight_checklist.md)
- [Automated Versioning & Git Tagging Architecture](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/automated_versioning_and_git_tagging_guide.md)
- [Monorepo & Multi-App Fastlane Architecture Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/monorepo_multi_package_fastlane_guide.md)
- [ChatOps & Multi-Platform Webhooks Guide (Slack/Discord/Teams)](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/chatops_and_webhooks_guide.md)
- [Bidirectional Metadata Sync & Localization Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/metadata_sync_and_localization_guide.md)
- [Deep Gradle & Fastlane Integration Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/gradle_fastlane_integration_guide.md)
- [Staged Rollout Management & Emergency Rollback Playbook](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/staged_rollout_and_rollback_guide.md)
- [Apple App Store Review & Compliance Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/app_store_review_and_compliance_guide.md)
- [Conventional Commits to Fastlane Changelogs Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/changelog_automation_guide.md)
- [Fastlane Performance & CI Optimization Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_performance_guide.md)
- [QA & Ad-Hoc Beta Distribution Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/qa_and_beta_distribution_guide.md)
- [Automated App Icon Badging & Versioning Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/icon_badging_and_versioning_guide.md)
- [Fastlane Pre-Flight & Dry-Run Verification Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_preflight_and_dry_run_guide.md)
- [Automated Store Screenshots Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/automated_screenshots_guide.md)
- [Multi-Flavor Flutter Deployments Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/multi_flavor_flutter_guide.md)
- [Security & Secrets Management Playbook](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_security_secrets_guide.md)
- [Crash Reporting & Symbol De-obfuscation Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/crash_reporting_symbols_guide.md)
- [App Size Budgeting & Delta Analysis Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/app_size_budgeting_guide.md)
- [In-App Purchases (IAP) & Subscription Sync Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/in_app_purchases_and_subscriptions_guide.md)
- [Android Keystore, Cloud KMS & Play App Signing Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/android_keystore_vault_guide.md)
- [Shorebird Code Push & Fastlane Dual-Track Delivery Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/shorebird_ota_fastlane_guide.md)
- [Fastlane Plugin Ecosystem & Custom Plugin Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_plugins_guide.md)
- [Apple Privacy Manifests & Required Reason APIs Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/apple_privacy_manifests_fastlane_guide.md)
- [Google Play Data Safety & Android Permission Audit Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/google_play_data_safety_audit_guide.md)
- [Play Asset Delivery (PAD) & Dynamic Feature Modules Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/dynamic_feature_modules_and_asset_packs_guide.md)
- [Enterprise MDM, Google Managed Play & Apple Business Manager Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/enterprise_mdm_private_store_guide.md)
- [App Links & Universal Links Verification Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/app_links_and_universal_links_fastlane_guide.md)
- [Android Baseline Profiles & DEX Optimization Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/baseline_profiles_and_dex_optimization_guide.md)
- [Google Play Developer API Quotas, Concurrency & Rate Limits Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/play_developer_api_quotas_and_rate_limits_guide.md)
- [Authoring Custom Fastlane Actions for Flutter](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/custom_fastlane_actions_guide.md)
- [Comprehensive Troubleshooting & Recovery Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_troubleshooting_guide.md)
- [Fastlane Environment & Toolchain Doctor CLI Tool (`bin/fastlane_doctor.dart`)](file:///d:/App%20Development/impulse_products/impulse_dex/bin/fastlane_doctor.dart)
- [Fastlane Localized Changelog Generator CLI Tool (`bin/generate_fastlane_changelog.dart`)](file:///d:/App%20Development/impulse_products/impulse_dex/bin/generate_fastlane_changelog.dart)
- [Fastlane Health & Configuration Audit CLI Tool (`bin/audit_fastlane.dart`)](file:///d:/App%20Development/impulse_products/impulse_dex/bin/audit_fastlane.dart)
- [Fastlane Doctor CLI Automated Unit Test](file:///d:/App%20Development/impulse_products/impulse_dex/test/tools/fastlane_doctor_test.dart)
- [Fastlane Audit Tool Automated Unit Test](file:///d:/App%20Development/impulse_products/impulse_dex/test/tools/audit_fastlane_test.dart)
- [Fastlane Changelog Generator Unit Test](file:///d:/App%20Development/impulse_products/impulse_dex/test/tools/generate_fastlane_changelog_test.dart)
- [Android Appfile Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Appfile.android.example)
- [iOS Appfile Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Appfile.ios.example)
- [iOS Matchfile Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Matchfile.example)
- [Android Fastfile Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Fastfile.android.example)
- [iOS Fastfile Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Fastfile.ios.example)
- [iOS Fastfile Swift Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/Fastfile.swift.example)
- [GitHub Actions Fastlane Workflow Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/fastlane_github_actions.yml.example)
- [GitLab CI Fastlane Deployment Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/fastlane_gitlab_ci.yml.example)
- [Bitrise CI/CD Fastlane Deployment Template](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/templates/fastlane_bitrise.yml.example)

### Standard Workspace File Layout

```
impulse_dex/
├── pubspec.yaml                    # Canonical version source (e.g., version: 1.0.4+5)
├── android/
│   ├── Gemfile                     # Ruby dependencies (fastlane gem pinned)
│   ├── Gemfile.lock                # Deterministic gem lockfile
│   └── fastlane/
│       ├── Appfile                 # Package name & API key path
│       ├── Fastfile                # Lanes for internal, alpha, beta, prod, promote
│       ├── Pluginfile              # Optional fastlane plugins
│       └── metadata/
│           └── android/
│               ├── en-US/
│               │   ├── title.txt
│               │   ├── short_description.txt
│               │   ├── full_description.txt
│               │   ├── changelogs/
│               │   │   └── default.txt (or <version_code>.txt)
│               │   └── images/
│               │       ├── icon.png (512x512)
│               │       ├── featureGraphic.png (1024x500)
│               │       └── phoneScreenshots/
│               └── bn-BD/
│                   └── ... (localized assets)
└── ios/
    ├── Gemfile                     # Ruby dependencies for iOS fastlane
    └── fastlane/
        ├── Appfile                 # app_identifier, apple_id, team_id, itc_team_id
        ├── Fastfile                # Lanes for match, beta, release
        └── Matchfile               # Git storage & certificate config for match
```

---

## 2. Environment & Dependency Setup

### Gemfile (`android/Gemfile` & `ios/Gemfile`)
Always manage Fastlane via Ruby Bundler to guarantee deterministic execution across developer workstations and CI runners:

```ruby
# frozen_string_literal: true

source "https://rubygems.org"

gem "fastlane", ">= 2.239.0"
```

### Initializing & Running Fastlane Commands
Execute commands from the respective platform directory (`android/` or `ios/`):

```bash
# Navigate to platform directory
cd android

# Install gems specified in Gemfile
bundle install

# Execute a fastlane lane
bundle exec fastlane internal

# Inspect parameters for any action
bundle exec fastlane action upload_to_play_store
bundle exec fastlane action app_store_connect_api_key
```

---

## 3. Dynamic Version Extraction from `pubspec.yaml`

Rather than hardcoding version numbers or relying on extra native plugins, parse the root `pubspec.yaml` directly in Ruby inside `Fastfile`:

```ruby
require "yaml"

def load_flutter_version
  pubspec_path = File.expand_path("../../pubspec.yaml", __dir__)
  unless File.exist?(pubspec_path)
    UI.user_error!("Could not find pubspec.yaml at #{pubspec_path}")
  end

  pubspec = YAML.load_file(pubspec_path)
  version_raw = pubspec["version"] || "1.0.0+1"
  version_name, version_code = version_raw.split("+")
  { name: version_name, code: (version_code || "1").to_i }
end
```

---

## 4. Android Deployment with `supply` (`upload_to_play_store`)

The `upload_to_play_store` action (alias `supply`) orchestrates distribution to the Google Play Store using the Google Play Developer API v3.

### `android/fastlane/Appfile`
Defines project-level defaults for Android lanes:

```ruby
# Path to service account JSON key (or use ENV['PLAYSTORE_SERVICE_ACCOUNT_JSON'])
json_key_file(ENV["PLAY_STORE_JSON_KEY"] || ENV["JSON_KEY_FILE"] || "pc-api-key.json")

# Google Play application ID (must match applicationId in build.gradle.kts)
package_name("com.impulseagriscienceltd.impulse_app")
```

### Modern Authentication: File vs In-Memory Secret
Fastlane supports two authentication methods for Google Play Developer API:

1. **Physical File Path (`json_key` / `json_key_file`)**:
   Points to a file decoded on the runner (e.g. `android/pc-api-key.json`).
2. **In-Memory / Secret Content (`json_key_data`)**:
   Accepts the raw JSON string directly from an environment variable, avoiding disk persistence:
   ```ruby
   upload_to_play_store(
     package_name: "com.impulseagriscienceltd.impulse_app",
     json_key_data: ENV["PLAYSTORE_SERVICE_ACCOUNT_JSON"],
     track: "internal",
     aab: "../build/app/outputs/bundle/release/app-release.aab"
   )
   ```

### Comprehensive `upload_to_play_store` Parameters Reference

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `package_name` | String | From `Appfile` | Android package application ID (e.g. `com.company.app`). |
| `track` | String | `'production'` | Target release track: `'internal'`, `'alpha'`, `'beta'`, or `'production'`. |
| `track_promote_to` | String | `nil` | Target track when promoting an existing release without rebuilding. |
| `rollout` | String | `nil` | Staged rollout fraction (e.g., `'0.10'` for 10%, `'0.25'` for 25%, `'0.50'` for 50%, `'1.0'` for 100%). |
| `release_status` | String | `'completed'` | Release state: `'completed'`, `'draft'`, `'inProgress'`, or `'halted'`. |
| `aab` | String | `nil` | Relative or absolute path to `.aab` bundle file. |
| `aab_paths` | Array | `nil` | List of `.aab` paths for multi-bundle configurations. |
| `apk` | String | `nil` | Path to standalone `.apk` (prefer AAB for Google Play). |
| `mapping_paths` | Array | `nil` | Array of ProGuard/R8 obfuscation symbol files (`mapping.txt`). |
| `native_debug_symbol_paths` | Array | `nil` | Native C/C++ `.so` symbol zip archives (required for 16KB ARM64 crash reports). |
| `changes_not_sent_for_review` | Boolean | `false` | When `true`, submits changes directly when Google Play Managed Publishing is active. |
| `version_code` | Integer | `nil` | Target specific version code when promoting or modifying releases. |
| `version_name` | String | `nil` | Version name label to associate with the release. |
| `skip_upload_apk` | Boolean | `false` | Skip APK binary upload. |
| `skip_upload_aab` | Boolean | `false` | Skip AAB binary upload (useful for metadata-only updates or track promotions). |
| `skip_upload_metadata` | Boolean | `false` | Skip title, short description, and full description sync. |
| `skip_upload_changelogs`| Boolean | `false` | Skip release notes / changelog upload. |
| `skip_upload_images` | Boolean | `false` | Skip icons and feature graphics upload. |
| `skip_upload_screenshots` | Boolean| `false` | Skip phone and tablet screenshot upload. |
| `validate_only` | Boolean | `false` | Validate the release with Google Play API without publishing. |

### Canonical Android Fastfile (`android/fastlane/Fastfile`)

```ruby
fastlane_version "2.239.0"
default_platform(:android)

require "yaml"

platform :android do
  def load_flutter_version
    pubspec_path = File.expand_path("../../pubspec.yaml", __dir__)
    pubspec = YAML.load_file(pubspec_path)
    raw = pubspec["version"] || "1.0.0+1"
    name, code = raw.split("+")
    { name: name, code: (code || "1").to_i }
  end

  before_all do |lane, options|
    v = load_flutter_version
    UI.message("🚀 Running Fastlane lane: #{lane} for v#{v[:name]}+#{v[:code]}")
  end

  desc "Deploy Internal QA Build to Google Play Internal Track"
  lane :internal do
    upload_to_play_store(
      track: 'internal',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/release/mapping.txt'],
      skip_upload_apk: true,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      skip_upload_changelogs: false,
      changes_not_sent_for_review: true
    )
  end

  desc "Deploy Closed Testing Build to Alpha Track"
  lane :alpha do
    upload_to_play_store(
      track: 'alpha',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/release/mapping.txt'],
      skip_upload_apk: true,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      skip_upload_changelogs: false,
      changes_not_sent_for_review: true
    )
  end

  desc "Deploy Closed Testing Build to Beta Track"
  lane :beta do
    upload_to_play_store(
      track: 'beta',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/release/mapping.txt'],
      skip_upload_apk: true,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      skip_upload_changelogs: false,
      changes_not_sent_for_review: true
    )
  end

  desc "Deploy to Google Play Production Track with Configurable Staged Rollout"
  lane :production do |options|
    rollout = (options[:rollout] || ENV['ROLLOUT_FRACTION'] || '0.10').to_s

    upload_to_play_store(
      track: 'production',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      mapping_paths: ['../build/app/outputs/mapping/release/mapping.txt'],
      rollout: rollout,
      skip_upload_apk: true,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      skip_upload_changelogs: false,
      changes_not_sent_for_review: true
    )
  end

  desc "Promote Release Track (e.g. Beta -> Production) without Rebuilding"
  lane :promote do |options|
    from_track = options[:from_track] || ENV['FROM_TRACK'] || 'beta'
    to_track   = options[:to_track]   || ENV['TO_TRACK']   || 'production'
    rollout    = (options[:rollout]   || ENV['ROLLOUT_FRACTION'] || '1.0').to_f

    UI.message("Promoting release from #{from_track} to #{to_track} with #{rollout * 100}% rollout...")

    params = {
      track: from_track,
      track_promote_to: to_track,
      skip_upload_apk: true,
      skip_upload_aab: true,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      changes_not_sent_for_review: true
    }

    if to_track == 'production' && rollout < 1.0
      params[:rollout] = rollout.to_s
    end

    upload_to_play_store(params)
  end

  desc "Upload Store Descriptions, Graphics & Metadata Only"
  lane :metadata do
    upload_to_play_store(
      skip_upload_apk: true,
      skip_upload_aab: true,
      skip_upload_metadata: false,
      skip_upload_images: false,
      skip_upload_screenshots: false,
      skip_upload_changelogs: true,
      changes_not_sent_for_review: true
    )
  end

  after_all do |lane|
    UI.success("🎉 Fastlane successfully executed lane: #{lane}")
  end

  error do |lane, exception|
    UI.error("💥 Fastlane error in lane #{lane}: #{exception.message}")
  end
end
```

---

## 5. Google Play Store Metadata & Character Limits

Fastlane expects metadata stored in `android/fastlane/metadata/android/<locale>/`:

| Asset File / Folder | Constraint / Character Limit | Purpose |
| :--- | :--- | :--- |
| `title.txt` | **$\le 30$ characters** | App title in Play Store search and header. |
| `short_description.txt` | **$\le 80$ characters** | Tagline displayed on app store listing card. |
| `full_description.txt` | **$\le 4000$ characters** | Detailed product overview, features, and specs. |
| `changelogs/<version_code>.txt` | **$\le 500$ characters** | Specific release notes for that version code. |
| `changelogs/default.txt` | **$\le 500$ characters** | Fallback release notes if specific code is omitted. |
| `images/icon.png` | **$512 \times 512$ PNG (32-bit)** | Play Store app icon (max 1024KB). |
| `images/featureGraphic.png`| **$1024 \times 500$ PNG/JPEG** | Header banner on store listing (no alpha channel). |
| `images/phoneScreenshots/` | Min 2, max 8 screenshots | $1080 \times 1920$ or $1080 \times 2400$ PNG/JPEG. |

> [!WARNING]
> Google Play enforces strict 500-character limits on changelogs. If `changelogs/<version_code>.txt` exceeds 500 characters, Fastlane will fail during upload with `Google Api Error: Invalid request - changelog too long`.

---

## 6. iOS Automation with Fastlane (`match`, `gym`, `pilot`, `deliver`)

For Flutter iOS automation, Fastlane standardizes code signing, archive generation, TestFlight distribution, and App Store releases.

### Modern App Store Connect API Key Authentication
Never rely on Apple ID username/password with SMS 2FA in CI. Use the official App Store Connect API Key (`.p8`):

```ruby
lane :auth do
  app_store_connect_api_key(
    key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
    issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
    key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"], # Raw .p8 string from CI secret
    is_key_content_base64: false,
    in_house: false
  )
end
```

### Code Signing with `match`
`match` syncs certificates and provisioning profiles across team members using an encrypted Git repository, S3 bucket, or Google Cloud Storage.

```ruby
# ios/fastlane/Matchfile
git_url("git@github.com:company/ios-certificates.git")
storage_mode("git")
type("appstore")
app_identifier(["com.company.impulsedex"])
username("apple-developer@company.com")
```

Running `match`:
```ruby
lane :certificates do
  # readonly: true in CI environments to prevent accidental certificate revocation
  match(type: "appstore", readonly: is_ci)
end
```

### Building iOS with `build_app` (`gym`)
While `flutter build ipa --release` compiles the archive, `build_app` can package the Runner workspace:

```ruby
lane :build_ios do
  build_app(
    workspace: "Runner.xcworkspace",
    scheme: "Runner",
    export_method: "app-store",
    output_directory: "../build/ios/ipa",
    output_name: "impulse_dex.ipa",
    clean: true
  )
end
```

### Deploying to TestFlight with `upload_to_testflight` (`pilot`)

```ruby
lane :beta do
  api_key = app_store_connect_api_key(
    key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
    issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
    key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"]
  )

  upload_to_testflight(
    api_key: api_key,
    ipa: "../build/ios/ipa/impulse_dex.ipa",
    skip_waiting_for_build_processing: true,
    distribute_external: true,
    groups: ["Internal QA", "Beta Testers"],
    changelog: "Automated CI/CD build deployment"
  )
end
```

### Releasing to App Store with `upload_to_app_store` (`deliver`)

```ruby
lane :release do
  api_key = app_store_connect_api_key(
    key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
    issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
    key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"]
  )

  upload_to_app_store(
    api_key: api_key,
    ipa: "../build/ios/ipa/impulse_dex.ipa",
    submit_for_review: true,
    phased_release: true,
    automatic_release: true,
    force: true,
    skip_metadata: true,
    skip_screenshots: true,
    submission_information: {
      export_compliance_uses_encryption: false,
      add_id_info_serves_ads: false
    }
  )
end
```

---

## 7. Fastlane Plugins & Ecosystem

Extend Fastlane functionality with plugins stored in `android/fastlane/Pluginfile`:

```ruby
# In android/fastlane/Pluginfile
gem 'fastlane-plugin-badge'
gem 'fastlane-plugin-versioning_android'
```

Install plugins via Bundler:
```bash
cd android
bundle exec fastlane add_plugin badge
```

Common Flutter-relevant plugins:
- **`fastlane-plugin-badge`**: Automatically watermarks app launcher icons with "BETA" ribbons or build numbers for QA releases.
- **`fastlane-plugin-sentry`**: Uploads de-obfuscation mapping files and native symbols to Sentry directly from Fastlane.

---

## 8. Webhook Notifications (Slack & Discord)

Keep the team informed on deployment milestones and build failures via the `after_all` and `error` lifecycle hooks:

```ruby
after_all do |lane|
  if ENV["SLACK_URL"]
    slack(
      message: "✅ Successfully deployed to #{lane} track!",
      channel: "#mobile-releases",
      success: true,
      payload: {
        "Build Version" => load_flutter_version[:name],
        "Build Number"  => load_flutter_version[:code]
      }
    )
  end
end

error do |lane, exception|
  if ENV["SLACK_URL"]
    slack(
      message: "❌ Fastlane deployment failed on lane: #{lane}",
      channel: "#mobile-releases",
      success: false,
      payload: {
        "Error" => exception.message
      }
    )
  end
end
```

---

## 9. Pre-Deployment Quality Verification Lanes

Fastlane can orchestrate the complete local-to-CI verification workflow before invoking compilation or distribution lanes. This guarantees that unformatted, unanalyzed, or failing test code never reaches store tracks:

```ruby
platform :android do
  desc "Execute full pre-deployment quality and test suite gate"
  lane :check do
    UI.message("🧪 Running static analysis and automated tests...")
    
    # 1. Format check
    sh("cd ../.. && dart format --output=none --set-exit-if-changed .")
    
    # 2. Strict static analysis
    sh("cd ../.. && flutter analyze --fatal-infos --fatal-warnings")
    
    # 3. Test suite with code coverage
    sh("cd ../.. && flutter test --coverage")
    
    # 4. Enforce project coverage threshold (70% minimum)
    sh("cd ../.. && dart run bin/generate_coverage_badge.dart --min-coverage=70.0")
    
    UI.success("✅ All pre-deployment quality gates passed!")
  end
  
  # Chain verification into deployment lanes
  lane :deploy_with_checks do
    check
    internal
  end
end
```

---

## 10. Automated Store Screenshots (`screengrab`, `snapshot`, `frameit`)

Capturing localized screenshots across device dimensions (phones, 7-inch tablets, 10-inch tablets, iPads) is automated through Fastlane tools:

- **Android (`screengrab`)**: Integrates with Android instrumentation or Flutter integration tests (`integration_test/screenshot_test.dart`) to capture localized PNGs directly into `metadata/android/<locale>/images/`.
- **iOS (`snapshot` & `frameit`)**: Simulates iOS devices, captures screens, and automatically frames them inside native device bezels with localized headline banners via `Framefile.json`.

For full setup instructions, see the [Automated Store Screenshots Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/automated_screenshots_guide.md).

---

## 11. GitHub Actions CI/CD Integration & Zero-Cache Policy

In CI/CD environments, Fastlane runs headlessly. Adhere strictly to the project's **Zero-Cache Policy** (`bundler-cache: false`).

### Step-by-Step CI Runner Recipe

```yaml
    steps:
      - name: "Check out source code repository"
        uses: actions/checkout@v6

      - name: "Set up Ruby 3.3 & Bundler for Fastlane"
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.3'
          working-directory: 'android'
          bundler-cache: false # Zero-Cache Policy strictly enforced

      - name: "Install Fastlane Gem Dependencies"
        run: |
          cd android
          bundle install

      - name: "Download compiled release artifacts"
        uses: actions/download-artifact@v8
        with:
          name: release-artifacts
          path: build/app/outputs

      - name: "Validate Google Play Service Account Credentials"
        env:
          PLAYSTORE_JSON_KEY: ${{ secrets.PLAYSTORE_SERVICE_ACCOUNT_JSON }}
        run: |
          set -e
          if [ -z "$PLAYSTORE_JSON_KEY" ]; then
            echo "::error::PLAYSTORE_SERVICE_ACCOUNT_JSON secret is missing!"
            exit 1
          fi
          echo "$PLAYSTORE_JSON_KEY" > android/pc-api-key.json

      - name: "Execute Fastlane deployment"
        env:
          CI: "true"
          FASTLANE_SKIP_UPDATE_CHECK: "1"
          FASTLANE_HIDE_CHANGELOG: "1"
          FASTLANE_DISABLE_ANIMATION: "1"
        run: |
          cd android
          bundle exec fastlane beta

      - name: "Securely wipe credentials from runner disk"
        if: always()
        run: |
          rm -f android/pc-api-key.json
```

---

## 12. Fastlane CLI Operations & Comprehensive Troubleshooting Matrix

For detailed breakdown of 15+ real-world errors and exact fixes, see the [Comprehensive Troubleshooting & Recovery Guide](file:///d:/App%20Development/impulse_products/impulse_dex/.agents/skills/fastlane/references/fastlane_troubleshooting_guide.md).

### Common Terminal Commands

| Task | Command (run inside `android/` or `ios/`) |
| :--- | :--- |
| List all available lanes | `bundle exec fastlane lanes` |
| Inspect parameters for an action | `bundle exec fastlane action <action_name>` |
| Test release upload in validate-only mode | `bundle exec fastlane internal validate_only:true` |
| Download current metadata from Play Console | `bundle exec fastlane supply init` |
| Download current metadata from App Store | `bundle exec fastlane deliver init` |
| Install a fastlane plugin | `bundle exec fastlane add_plugin <plugin_name>` |
| Update bundle dependencies | `bundle update fastlane` |

### Troubleshooting & Common Pitfalls

| Symptom / Error Message | Root Cause | Immediate Remediation |
| :--- | :--- | :--- |
| `Google Api Error: Invalid request - Package not found` | The app has never had an initial binary uploaded manually to Google Play Console. | **First-Release Rule:** Google Play Developer API prohibits initial app creation via API. You MUST manually upload the first `.aab` via the Play Console web UI before Fastlane can publish. |
| `Google Api Error: 403 Forbidden / Not authorized` | Service account lacks permissions or Google Play Developer API is not enabled in Google Cloud Console. | 1. Enable **Google Play Android Developer API** in Google Cloud.<br/>2. Link Service Account in Play Console under **API Access**.<br/>3. Grant **Admin** or **Release Manager** permissions to the service account. |
| `Changelog exceeds 500 characters` | Google Play strictly limits release notes to 500 characters per locale. | Truncate changelog file (`changelogs/<version_code>.txt`) to $\le 500$ chars or use automated script (`bin/release.dart`). |
| `Track promotion failed: Release already exists in draft` | A pending draft release is blocking automated promotion. | Delete the pending draft release in the target track via Google Play Console web interface and re-run Fastlane. |
| `Changes cannot be sent for review while an existing review is pending` | An earlier release is currently under policy review in Google Play. | Wait for the review to complete or reject/cancel the previous submission before uploading another update. |
| `Could not find a matching SDK for targetSdk 35/36` | CI runner missing Android SDK platform. | Add `sdkmanager "platforms;android-36" "build-tools;36.0.0"` step before build. |
| `Could not find fastlane (Bundler::GemNotFound)` | `bundle exec` omitted or gems not installed. | Run `bundle install` and always prefix Fastlane commands with `bundle exec fastlane <lane>`. |
| `Apple ID 2-Step Verification session expired` | Using username/password in CI instead of API key. | Migrate to `app_store_connect_api_key` with `.p8` key. |
