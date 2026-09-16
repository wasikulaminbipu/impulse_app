# QA & Ad-Hoc Beta Distribution with Fastlane

This guide covers ad-hoc QA distribution channels that bypass production review queues: **Google Play Internal App Sharing** and **Firebase App Distribution**.

---

## 1. Google Play Internal App Sharing

Internal App Sharing allows developers and CI runners to upload APKs and AABs to Google Play and receive an instant download link to share with QA testers.

### Key Advantages
- **Zero Review Time**: Binaries are available for download within seconds.
- **Any Version Code**: You can upload builds with identical version codes or lower version codes without conflicting with production releases.
- **Certificates**: Builds do not need to be signed with the production upload key; testers can install builds signed with debug or internal keys if authorized in the Play Console.

### Fastlane Action: `upload_to_play_store_internal_app_sharing`

```ruby
platform :android do
  desc "Upload build to Google Play Internal App Sharing"
  lane :internal_app_sharing do
    download_url = upload_to_play_store_internal_app_sharing(
      package_name: "com.impulseagriscienceltd.impulse_app",
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      json_key_data: ENV["PLAYSTORE_SERVICE_ACCOUNT_JSON"]
    )

    UI.success("🎉 Internal App Sharing download link ready:")
    UI.message("👉 #{download_url}")

    # Post link to Slack/Discord
    if ENV["SLACK_URL"]
      slack(
        message: "📦 New QA build ready on Internal App Sharing:\n#{download_url}",
        channel: "#qa-builds",
        success: true
      )
    end
  end
end
```

---

## 2. Firebase App Distribution

Firebase App Distribution provides cross-platform (Android & iOS) beta deployment with tester group management and in-app update notifications.

### Setup Plugin
```bash
cd android
bundle exec fastlane add_plugin firebase_app_distribution
```

In `android/fastlane/Pluginfile`:
```ruby
gem 'fastlane-plugin-firebase_app_distribution'
```

### Fastlane Lane Recipe

```ruby
lane :distribute_firebase do |options|
  groups = options[:groups] || "internal-testers"
  release_notes = options[:notes] || "Latest QA build from CI/CD"

  firebase_app_distribution(
    app: ENV["FIREBASE_APP_ID_ANDROID"], # e.g. 1:1234567890:android:abcdef
    groups: groups,
    release_notes: release_notes,
    android_artifact_type: "AAB",
    android_artifact_path: "../build/app/outputs/bundle/release/app-release.aab",
    service_credentials_file: "pc-api-key.json" # Or FIREBASE_TOKEN
  )
end
```

### iOS Firebase App Distribution
```ruby
lane :distribute_firebase_ios do |options|
  groups = options[:groups] || "internal-testers"

  firebase_app_distribution(
    app: ENV["FIREBASE_APP_ID_IOS"],
    groups: groups,
    release_notes: "iOS QA candidate build",
    ipa_path: "../build/ios/ipa/impulse_dex.ipa"
  )
end
```
