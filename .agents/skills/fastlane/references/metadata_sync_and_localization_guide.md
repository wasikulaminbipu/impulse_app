# Bidirectional Metadata Sync & Localization Guide

This guide details synchronizing store descriptions, titles, localized marketing assets, and screenshots between Google Play Store, Apple App Store, and the Git repository using Fastlane.

---

## 1. Downloading Live Store Metadata (`init`)

When onboarding an existing app to Fastlane, download the current live store listings to establish a baseline:

### Google Play Store (`supply init`)
```bash
cd android
# Downloads all localized listings, descriptions, and changelogs to metadata/android/
bundle exec fastlane supply init
```

### Apple App Store (`deliver init`)
```bash
cd ios
# Downloads App Store Connect metadata, keywords, and descriptions to metadata/
bundle exec fastlane deliver init
```

> [!TIP]
> After running `init`, review and format downloaded files into UTF-8 without BOM. Commit the directory to version control so all future store changes are tracked in Git history with PR reviews.

---

## 2. Managing Multi-Locale Directories

In this project, metadata is maintained for English (`en-US`) and Bengali (`bn-BD`):

```
android/fastlane/metadata/android/
├── en-US/
│   ├── title.txt                  # <= 30 chars
│   ├── short_description.txt      # <= 80 chars
│   └── full_description.txt       # <= 4000 chars
└── bn-BD/
    ├── title.txt                  # ইমপালস ডিইএক্স (<= 30 chars)
    ├── short_description.txt      # কৃষি পরিবেশক এবং পণ্য নির্দেশিকা (<= 80 chars)
    └── full_description.txt       # বিস্তারিত বিবরণ (<= 4000 chars)
```

### Unicode & UTF-8 Character Length Gotchas
Google Play counts **characters**, not bytes. In UTF-8, Bengali characters consume 3 bytes each, but Google Play enforces the character count limit (e.g. 30 characters for `title.txt`). Fastlane handles multi-byte UTF-8 strings natively in Ruby 3.x.

---

## 3. Uploading Metadata Without Recompiling Binaries

To update store descriptions, keywords, or release notes without triggering a lengthy app compilation:

```ruby
# android/fastlane/Fastfile

desc "Synchronize store text descriptions and graphics only"
lane :sync_metadata do
  upload_to_play_store(
    skip_upload_apk: true,
    skip_upload_aab: true,
    skip_upload_metadata: false,       # Sync text descriptions
    skip_upload_images: false,         # Sync icon & feature graphic
    skip_upload_screenshots: true,     # Skip large screenshots unless modified
    skip_upload_changelogs: true,
    changes_not_sent_for_review: true
  )
  UI.success("🎉 Store text descriptions synchronized successfully!")
end
```
