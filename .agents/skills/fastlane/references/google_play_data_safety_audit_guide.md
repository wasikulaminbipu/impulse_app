# Google Play Data Safety & Android Permission Audit Guide

This guide details auditing merged Android manifests, runtime permissions, and SDK dependencies against Google Play Data Safety declarations prior to Fastlane deployment.

---

## 1. The Data Safety Gap

Publishing to Google Play requires accurate answers to the Data Safety questionnaire regarding:
- Data Collected (Location, Personal Info, Financial, Health, Messages, Photos/Videos, Audio, Files, Contacts, App Activity, Device IDs).
- Data Shared with 3rd parties (ad networks, analytics, crash reporting).
- Security practices (Data encryption in transit, Account deletion requests).

If an Android App Bundle includes permissions or SDKs that collect data not declared in Google Play Console, Google Play will reject the release during automated review.

---

## 2. High-Risk Permissions Requiring Declaration

| Permission | Google Play Policy Requirement |
|---|---|
| `READ_CONTACTS` / `WRITE_CONTACTS` | Declared under Contact Information; must justify core app functionality. |
| `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION` | Declared under Location; background location (`ACCESS_BACKGROUND_LOCATION`) requires prominent disclosure & video proof. |
| `READ_MEDIA_IMAGES` / `READ_MEDIA_VIDEO` (Android 13+) | Photo/Video Picker API preferred; broad storage access restricted. |
| `POST_NOTIFICATIONS` (Android 13+) | Declared in Data Safety if push tokens are collected/shared. |
| `QUERY_ALL_PACKAGES` | Restricted; requires core utility justification (antivirus, launcher). |

---

## 3. Fastlane Manifest & Permission Audit Lane

Integrate this lane into `android/fastlane/Fastfile` before executing `upload_to_play_store`:

```ruby
desc "Audit merged AndroidManifest for sensitive permissions"
lane :audit_android_permissions do
  manifest_path = "../build/app/intermediates/merged_manifests/release/processReleaseManifest/AndroidManifest.xml"
  
  unless File.exist?(manifest_path)
    UI.message("Merged manifest not generated yet, running assembleRelease pre-flight...")
    sh("cd .. && ./gradlew processReleaseManifest")
  end

  manifest_content = File.read(manifest_path)
  
  # Audit restricted background location
  if manifest_content.include?("android.permission.ACCESS_BACKGROUND_LOCATION")
    UI.important("⚠️ Detected ACCESS_BACKGROUND_LOCATION. Verify Play Console Background Location Declaration approval.")
  end

  # Audit broad storage on Android 11+
  if manifest_content.include?("android.permission.MANAGE_EXTERNAL_STORAGE")
    UI.user_error!("❌ MANAGE_EXTERNAL_STORAGE detected. High risk of immediate Play Store rejection without approved exemption.")
  end

  # Log declared dangerous permissions for audit trail
  dangerous_permissions = manifest_content.scan(/android:name="(android\.permission\.[A-Z_]+)"/).flatten
  UI.message("Audited Permissions Count: #{dangerous_permissions.count}")
  UI.success("✅ Permission pre-flight check completed!")
end
```
