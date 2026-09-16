# Automated Versioning & Git Tagging Architecture

This guide explains how to coordinate semantic version increments in `pubspec.yaml`, Fastlane localized changelog generation, and annotated Git tagging to trigger automated CI/CD release deployments.

---

## 1. Version Format Conventions (`X.Y.Z+N`)

Flutter encodes versioning in `pubspec.yaml`:
- **`X.Y.Z` (Version Name)**: Semantic version (`MAJOR.MINOR.PATCH`) displayed to users in store listings.
- **`N` (Version Code / Build Number)**: Strictly monotonically increasing integer required by Google Play and App Store Connect for every new upload.

Example:
```yaml
version: 1.0.9+10  # VersionName: 1.0.9, VersionCode: 10
```

---

## 2. Fastlane Lane: `bump_and_tag`

Create a Fastlane lane that chains version bumping with Git tagging:

```ruby
# android/fastlane/Fastfile

desc "Increment version, generate changelogs, and create release git tag"
lane :bump_and_tag do |options|
  bump_type = options[:type] || "patch" # patch, minor, or major
  custom_notes = options[:notes]

  # 1. Bump version in pubspec.yaml using project Dart CLI
  sh("cd ../.. && dart run bin/bump_version.dart #{bump_type}")

  # 2. Extract new version info
  version = load_flutter_version
  new_tag = "v#{version[:name]}+#{version[:code]}"

  # 3. Generate localized Fastlane changelogs (< 500 chars)
  notes_flag = custom_notes ? "--notes=\"#{custom_notes}\"" : ""
  sh("cd ../.. && dart run bin/generate_fastlane_changelog.dart #{notes_flag}")

  # 4. Commit modified pubspec.yaml, CHANGELOG.md, and Fastlane changelogs
  sh("cd ../.. && git add pubspec.yaml CHANGELOG.md android/fastlane/metadata/")
  sh("cd ../.. && git commit -m 'chore(release): bump version to #{new_tag}'")

  # 5. Create annotated Git tag
  sh("cd ../.. && git tag -a #{new_tag} -m 'Release #{new_tag}'")
  UI.success("🏷️ Created annotated release tag: #{new_tag}")

  # 6. Push to trigger GitHub Actions release CI
  if options[:push]
    sh("cd ../.. && git push origin main && git push origin #{new_tag}")
    UI.success("🚀 Pushed #{new_tag} to origin — CI/CD deployment triggered!")
  end
end
```

Execution commands:
```bash
cd android
bundle exec fastlane bump_and_tag type:patch
bundle exec fastlane bump_and_tag type:minor notes:"Major directory feature launch" push:true
```
