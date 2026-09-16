# Apple App Store Review & Compliance Guide

This guide details configuring Apple App Review information, demo account credentials, IDFA tracking declarations, and export compliance using Fastlane `upload_to_app_store` (`deliver`).

---

## 1. App Review Information Configuration

When submitting an iOS application to the App Store, Apple requires contact details, review notes, and demo login credentials (if your app requires authentication).

### Specifying Review Information in `Fastfile`

```ruby
# ios/fastlane/Fastfile

lane :submit_for_review do
  api_key = load_api_key

  upload_to_app_store(
    api_key: api_key,
    ipa: "../build/ios/ipa/impulse_dex.ipa",
    submit_for_review: true,
    automatic_release: true,
    phased_release: true,
    
    # App Review Contact and Demo Account
    app_review_information: {
      first_name: "Wasikul",
      last_name: "Amin",
      phone_number: "+8801700000000",
      email_address: "dev@impulseagriscience.com",
      demo_user: "reviewer_demo@impulseagriscience.com",
      demo_password: "SecureDemoPassword123!",
      notes: "This app serves agricultural distributors. A pre-loaded offline SQLite database is included. Use demo credentials to test authenticated features."
    },

    # Privacy & Regulatory Compliance Declarations
    submission_information: {
      export_compliance_uses_encryption: false,
      add_id_info_serves_ads: false,
      add_id_info_tracks_install: false,
      add_id_info_tracks_action: false,
      add_id_info_uses_idfa: false
    }
  )
end
```

---

## 2. Privacy Manifests & Required Reason APIs

Starting with iOS 17+, Apple requires third-party SDKs and apps to declare "Required Reason APIs" inside `ios/Runner/PrivacyInfo.xcprivacy`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array>
        <!-- Declare UserDefaults / File timestamp access if required -->
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryUserDefaults</string>
            <key>NSPrivacyAccessedAPITypeReasons</key>
            <array>
                <string>CA92.1</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

---

## 3. Requesting an Expedited Review

If a critical production bug, security patch, or time-sensitive event requires emergency Apple review:
1. Submit the build via Fastlane (`submit_for_review: true`).
2. Go to [Apple Expedited App Review Request](https://developer.apple.com/contact/app-store/?topic=expedite).
3. Select your App ID, select **Critical Bug Fix**, describe the bug, the user impact, and the steps taken to prevent recurrence.
4. Apple typically responds within 24 hours for valid emergency requests.
