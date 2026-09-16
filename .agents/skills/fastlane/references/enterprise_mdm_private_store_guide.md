# Enterprise MDM, Google Managed Play & Apple Business Manager Guide

This guide details configuring Fastlane for private B2B and enterprise internal distribution without public store listings.

---

## 1. Enterprise Distribution Channels

| Platform | Channel | Technology | Target Users |
|---|---|---|---|
| **Android** | Google Managed Play (Private Apps) | Fastlane `supply` with private organization targeting | Managed corporate devices (Intune, Knox, MobileIron, Workspace ONE) |
| **iOS** | Apple Business Manager (Custom Apps) | Fastlane `deliver` with private distribution setting | Specific enterprise organizations via Volume Purchase Program (VPP) |
| **iOS** | Apple Enterprise Program (In-House) | Fastlane `match(type: "enterprise")` + internal web portal/OTA manifest | Internal employees without App Store review (Ad-Hoc/Enterprise cert) |

---

## 2. Google Managed Play (Private Apps) in Fastlane

Publishing a private Android app restricted to specific Google Workspace / enterprise tenant organizations:

In Google Play Console, associate the enterprise organization ID with the app. In Fastlane:

```ruby
desc "Deploy to Google Managed Play Private Track"
lane :deploy_private_managed_play do |options|
  upload_to_play_store(
    track: "production",
    aab: "../build/app/outputs/bundle/release/app-release.aab",
    # Only roll out to targeted enterprise accounts
    release_status: "completed",
    skip_upload_metadata: true,
    skip_upload_images: true,
    skip_upload_screenshots: true
  )
end
```

---

## 3. Apple Business Manager (Custom Apps) in Fastlane

Custom Apps allow publishing proprietary iOS apps through App Store Connect while restricting visibility to selected organizations:

In `ios/fastlane/Fastfile`:

```ruby
desc "Deploy private B2B Custom App to Apple Business Manager"
lane :deploy_custom_app do
  # 1. Synchronize App Store signing certificates
  match(type: "appstore", readonly: is_ci)

  # 2. Build iOS Archive
  build_app(
    scheme: "Runner",
    export_method: "app-store"
  )

  # 3. Deliver to App Store Connect with private availability
  deliver(
    submit_for_review: false,
    automatic_release: true,
    force: true,
    skip_screenshots: true
  )
end
```
