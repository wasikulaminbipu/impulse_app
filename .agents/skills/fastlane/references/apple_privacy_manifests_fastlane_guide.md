# Apple Privacy Manifests & Required Reason APIs in Fastlane

This guide details enforcing Apple Privacy Manifest (`PrivacyInfo.xcprivacy`) compliance in Flutter iOS pipelines before submitting with Fastlane `deliver` or `pilot`.

---

## 1. Apple Privacy Manifest Requirements

Starting Spring 2024, Apple requires all apps and third-party SDKs that access **Required Reason APIs** to declare the approved reason in a `PrivacyInfo.xcprivacy` file. Submissions lacking this manifest trigger rejection `ITMS-91053`.

### Key Required Reason API Categories
- **File Timestamp APIs**: `stat`, `getattrlist`
- **System Boot Time APIs**: `sysctlbyname`, `clock_gettime`
- **Disk Space APIs**: `statfs`, `volumeAvailableCapacity`
- **Keyboard Metrics APIs**: `activeInputModes`
- **User Defaults APIs**: `NSUserDefaults` (used by `shared_preferences`)

---

## 2. Privacy Manifest Structure (`PrivacyInfo.xcprivacy`)

Place `PrivacyInfo.xcprivacy` in `ios/Runner/`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyTrackingDomains</key>
    <array/>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array>
        <!-- UserDefaults reason declaration for shared_preferences -->
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

## 3. Fastlane Privacy Manifest Audit Lane

Add this verification lane before building the iOS archive with `gym`:

```ruby
desc "Audit iOS Privacy Manifest presence and required reason keys"
lane :audit_privacy_manifest do
  manifest_path = "../ios/Runner/PrivacyInfo.xcprivacy"
  unless File.exist?(manifest_path)
    UI.user_error!("❌ Missing PrivacyInfo.xcprivacy in ios/Runner/! Required by Apple App Store.")
  end

  content = File.read(manifest_path)
  
  # Ensure tracking declaration exists
  unless content.include?("NSPrivacyTracking")
    UI.user_error!("❌ Privacy manifest missing NSPrivacyTracking key.")
  end

  # Check for common UserDefaults requirement if shared_preferences is used
  if File.read("../../pubspec.yaml").include?("shared_preferences")
    unless content.include?("NSPrivacyAccessedAPICategoryUserDefaults")
      UI.user_error!("❌ Missing NSPrivacyAccessedAPICategoryUserDefaults reason in PrivacyInfo.xcprivacy.")
    end
  end

  UI.success("✅ Apple Privacy Manifest audit passed!")
end
```
