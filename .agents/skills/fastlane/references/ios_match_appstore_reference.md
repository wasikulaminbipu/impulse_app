# Fastlane iOS: Match, TestFlight & App Store Reference Guide

This document provides deep technical reference for configuring iOS continuous delivery with Fastlane for Flutter applications.

---

## 1. Modern App Store Connect API Key Authentication

Fastlane officially deprecates interactive Apple ID 2-Factor Authentication (2FA) in headless CI/CD environments. You MUST use an App Store Connect API Key (`.p8`).

### Generating the API Key
1. In [App Store Connect](https://appstoreconnect.apple.com/), go to **Users and Access** > **Integrations** > **App Store Connect API**.
2. Click **Generate API Key** (or `+`).
3. Set the Name (e.g. `fastlane-ci-key`) and select the **Admin** or **App Manager** role.
4. Note the following values:
   - **Key ID** (10 characters, e.g. `2X9R4HXF34`)
   - **Issuer ID** (UUID, e.g. `69a6de70-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)
   - **Private Key (`.p8`)**: Download the key file (can only be downloaded once!).

### Authenticating in `Fastfile`

```ruby
# In ios/fastlane/Fastfile

lane :load_api_key do
  app_store_connect_api_key(
    key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
    issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
    key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"], # Raw .p8 file text or base64
    is_key_content_base64: false,
    in_house: false
  )
end
```

---

## 2. Code Signing with `match`

`match` creates and syncs certificates and provisioning profiles across your team and CI runners using a secure encrypted Git repository, Google Cloud Storage, or Amazon S3 bucket.

### `ios/fastlane/Matchfile` Configuration

```ruby
# Git Storage Example
git_url("git@github.com:your-org/ios-certificates.git")
storage_mode("git")
type("appstore") # Options: appstore, adhoc, development, enterprise

app_identifier(["com.impulseagriscienceltd.impulse_app"])
username("apple-developer@company.com")
```

### Running `match` in CI vs Local

```ruby
lane :sync_certificates do
  # In CI: readonly: true prevents revoking existing production certificates
  is_ci_runner = ENV["CI"] == "true"

  match(
    type: "appstore",
    readonly: is_ci_runner,
    app_identifier: "com.impulseagriscienceltd.impulse_app"
  )
end
```

### Environment Variables Required for `match` in CI
- `MATCH_PASSWORD`: Passphrase used to decrypt the certificates repo.
- `MATCH_GIT_PRIVATE_KEY` / SSH deploy key: SSH key with read/write access to the certificates repository.

---

## 3. Building iOS with `build_app` (`gym`)

While `flutter build ipa --release` is the primary command in Flutter, Fastlane's `build_app` packages the compiled Xcode archive into an `.ipa`:

```ruby
lane :package_ipa do
  build_app(
    workspace: "Runner.xcworkspace",
    scheme: "Runner",
    export_method: "app-store",
    output_directory: "../build/ios/ipa",
    output_name: "impulse_dex.ipa",
    clean: true,
    export_options: {
      provisioningProfiles: {
        "com.impulseagriscienceltd.impulse_app" => "match AppStore com.impulseagriscienceltd.impulse_app"
      }
    }
  )
end
```

---

## 4. TestFlight Distribution with `upload_to_testflight` (`pilot`)

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
    skip_waiting_for_build_processing: false,
    distribute_external: true,
    groups: ["Internal QA", "Beta Testers"],
    changelog: "Bug fixes and performance improvements",
    demo_account_required: false
  )
end
```

### Key `upload_to_testflight` Options

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `api_key` | Hash | Token returned by `app_store_connect_api_key`. |
| `ipa` | String | Path to `.ipa` file. |
| `skip_waiting_for_build_processing` | Boolean | If `true`, returns immediately without waiting for Apple's processing (faster CI, but cannot distribute to external groups immediately). |
| `distribute_external` | Boolean | Distribute build to external testing groups. |
| `groups` | Array | Names of TestFlight groups to distribute to. |
| `changelog` | String | TestFlight release notes for testers. |

---

## 5. App Store Release with `upload_to_app_store` (`deliver`)

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
    phased_release: true,               # 7-day phased rollout
    automatic_release: true,            # Auto-release after Apple approval
    force: true,                        # Skip interactive HTML verification
    skip_metadata: true,                # Set false if syncing store descriptions
    skip_screenshots: true,
    submission_information: {
      export_compliance_uses_encryption: false,
      add_id_info_serves_ads: false
    }
  )
end
```

### Phased Release Schedule (7 Days)
When `phased_release: true` is enabled, Apple rolls out the update gradually:
- Day 1: 1%
- Day 2: 2%
- Day 3: 5%
- Day 4: 10%
- Day 5: 20%
- Day 6: 50%
- Day 7: 100%
*(Can be paused or accelerated to 100% at any time in App Store Connect).*
