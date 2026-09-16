# Conventional Commits to Fastlane Changelogs Automation Guide

This guide details how to transform Git conventional commits (`feat:`, `fix:`, `perf:`) into localized Fastlane store release notes while adhering to store character limits.

---

## 1. Google Play & App Store Release Notes Rules

| Platform | Location | Character Limit | Fallback Behavior |
| :--- | :--- | :--- | :--- |
| **Google Play** | `android/fastlane/metadata/android/<locale>/changelogs/<version_code>.txt` | **Strict $\le 500$ chars** | Uses `default.txt` if version-specific file is missing. Fails upload if $>500$ chars. |
| **Apple TestFlight** | `changelog` parameter in `upload_to_testflight` | Max 4000 chars | Displayed in TestFlight app to beta testers. |
| **Apple App Store** | `release_notes.txt` in `ios/fastlane/metadata/<locale>/` | Max 4000 chars | Displayed under "What's New in This Version" in the App Store. |

---

## 2. Conventional Commit Filtering Pipeline

Not every git commit is customer-facing. The changelog generator filters commits:
- **Include**:
  - `feat:` (New customer-facing capabilities)
  - `fix:` (Bug fixes and resolved issues)
  - `perf:` (Performance optimizations)
- **Exclude**:
  - `chore:`, `ci:`, `docs:`, `test:`, `style:`, `refactor:`
  - Merge commits (`Merge branch...`)
  - Automated release commits (`chore(release):...`)

---

## 3. Localized Changelogs Generation Tool

Run the project's generator:

```bash
# Preview changelog extracted from recent commits
dart run bin/generate_fastlane_changelog.dart --dry-run

# Provide custom marketing release notes
dart run bin/generate_fastlane_changelog.dart --notes="Added offline search and PDF export"

# Commit and write to en-US and bn-BD changelogs
dart run bin/generate_fastlane_changelog.dart
```

---

## 4. Automatic Chaining in Fastlane

In `Fastfile`, invoke the generator prior to running `upload_to_play_store`:

```ruby
lane :deploy_with_changelog do |options|
  # Run changelog generator
  sh("cd ../.. && dart run bin/generate_fastlane_changelog.dart")

  # Upload to Google Play
  upload_to_play_store(
    track: "internal",
    aab: "../build/app/outputs/bundle/release/app-release.aab",
    skip_upload_changelogs: false
  )
end
```
