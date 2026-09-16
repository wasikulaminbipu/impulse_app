# Fastlane Pre-Flight & Dry-Run Verification Guide

Before initiating production releases or committing store changes, Fastlane can execute pre-flight audits and dry-run validations that verify API connectivity, credential validity, and schema correctness without modifying live store tracks.

---

## 1. Fastlane Validate-Only Mode (`validate_only: true`)

The `upload_to_play_store` action provides a `validate_only` parameter. When set to `true`, the Google Play Developer API validates the APK/AAB transaction, tracks, signatures, and version codes, but rolls back the transaction before publication:

```ruby
# android/fastlane/Fastfile

desc "Dry-run validate production release bundle against Google Play API"
lane :validate_release do
  upload_to_play_store(
    track: "production",
    aab: "../build/app/outputs/bundle/release/app-release.aab",
    mapping_paths: ["../build/app/outputs/mapping/release/mapping.txt"],
    validate_only: true, # Simulates the upload without publishing!
    changes_not_sent_for_review: true
  )
  UI.success("🎉 Release AAB successfully validated by Google Play Developer API!")
end
```

Running the validation lane:
```bash
cd android
bundle exec fastlane validate_release
```

---

## 2. API Credentials Pre-Flight Check

To verify that your Google Play service account JSON key has valid permissions before compiling long builds:

```ruby
desc "Verify Google Play Service Account API connectivity"
lane :check_api_credentials do
  package_name = "com.impulseagriscienceltd.impulse_app"

  UI.message("🔐 Testing Google Play API connection for: #{package_name}...")

  # Attempt a read-only metadata fetch to test authorization
  begin
    client = Supply::Client.make_from_config
    client.begin_edit(package_name: package_name)
    UI.success("✅ Google Play Developer API connection authenticated successfully!")
  rescue => ex
    UI.user_error!("❌ Google Play API authentication failed: #{ex.message}")
  end
end
```

---

## 3. Fastlane Dry-Run Matrix in CI/CD

Integrate dry-run validation into pull request checks:

```yaml
      - name: "Fastlane Dry-Run Pre-Flight Audit"
        run: |
          # 1. Audit local configuration and metadata limits
          dart run bin/audit_fastlane.dart

          # 2. Run Fastlane in validate-only mode if credentials are present
          if [ -n "$PLAYSTORE_SERVICE_ACCOUNT_JSON" ]; then
            cd android
            bundle exec fastlane validate_release
          fi
```
