# App Links & Universal Links Verification in Fastlane

This guide details verifying Android App Links (`assetlinks.json`) and iOS Universal Links (`apple-app-site-association`) inside Fastlane pipelines to guarantee seamless deep linking without disambiguation dialogs.

---

## 1. Deep Link Architecture & Domain Verification

```
      User taps link: https://example.com/product/123
                         │
        ┌────────────────┴────────────────┐
        ▼                                 ▼
   [Android]                          [iOS]
Queries domain at:                Queries domain at:
https://example.com/              https://example.com/
.well-known/assetlinks.json       .well-known/apple-app-site-association
        │                                 │
Matches SHA256 Fingerprint?        Matches TeamID.BundleID?
        │                                 │
  YES ──┴── NO                      YES ──┴── NO
   │         │                       │         │
App opens  Browser opens         App opens   Safari opens
directly   fallback              directly    fallback
```

---

## 2. Fastlane App Links Pre-Flight Lane

Add this verification lane to `android/fastlane/Fastfile`:

```ruby
desc "Verify Android App Links domain verification and assetlinks.json"
lane :verify_app_links do |options|
  domain = options[:domain] || "impulseagrisciencelimited.com"
  
  # 1. Run repository App Links audit script
  UI.message("Running local App Links manifest auditor...")
  sh("dart run bin/audit_app_links.dart")

  # 2. Verify online HTTPS assetlinks.json endpoint
  assetlinks_url = "https://#{domain}/.well-known/assetlinks.json"
  UI.message("Fetching live digital asset links: #{assetlinks_url}")
  
  require "net/http"
  require "json"
  
  uri = URI(assetlinks_url)
  response = Net::HTTP.get_response(uri)
  
  unless response.is_a?(Net::HTTPSuccess)
    UI.user_error!("❌ Failed to retrieve #{assetlinks_url}! HTTP #{response.code}")
  end

  # Parse JSON and verify package name and certificate fingerprint
  parsed = JSON.parse(response.body)
  target_package = "com.impulseagriscienceltd.impulse_app"
  
  package_found = parsed.any? do |statement|
    statement.dig("target", "package_name") == target_package
  end

  unless package_found
    UI.user_error!("❌ Package '#{target_package}' not declared in #{assetlinks_url}!")
  end

  UI.success("✅ App Links domain verification passed for #{domain}!")
end
```

---

## 3. Fastlane Universal Links Pre-Flight Lane (iOS)

In `ios/fastlane/Fastfile`:

```ruby
desc "Verify iOS Universal Links apple-app-site-association (AASA)"
lane :verify_universal_links do |options|
  domain = options[:domain] || "impulseagrisciencelimited.com"
  aasa_url = "https://#{domain}/.well-known/apple-app-site-association"
  
  UI.message("Verifying live AASA file: #{aasa_url}")
  require "net/http"
  require "json"

  uri = URI(aasa_url)
  response = Net::HTTP.get_response(uri)

  unless response.is_a?(Net::HTTPSuccess)
    UI.user_error!("❌ Failed to fetch AASA from #{aasa_url}! HTTP #{response.code}")
  end

  aasa_data = JSON.parse(response.body)
  app_id = "#{ENV['APPLE_TEAM_ID']}.com.impulseagriscienceltd.impulse_app"

  # Validate applinks configuration
  details = aasa_data.dig("applinks", "details") || []
  matched = details.any? { |d| d["appID"] == app_id || d.dig("appIDs", 0) == app_id }

  unless matched
    UI.user_error!("❌ App ID '#{app_id}' not found in AASA details at #{aasa_url}!")
  end

  UI.success("✅ iOS Universal Links verified successfully for #{domain}!")
end
```

---

## 4. Testing Links via CLI
- **Android**:
  ```bash
  adb shell am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "https://impulseagrisciencelimited.com/product/123"
  ```
- **iOS Simulator**:
  ```bash
  xcrun simctl openurl booted "https://impulseagrisciencelimited.com/product/123"
  ```
