# Automated App Icon Badging with Fastlane

This guide demonstrates how to automatically overlay visual badges (such as "BETA", "DEV", or the build number) onto Flutter launcher icons during CI/CD execution using `fastlane-plugin-badge`.

---

## 1. Why Badge QA Builds?

When QA testers or internal stakeholders have multiple builds installed on the same device, identical icons cause confusion. Fastlane badging automatically burns a colored banner onto the icon before building:

- **Dev / Nightly Builds**: Yellow / orange banner with "DEV" + git commit hash.
- **Beta / Staging Builds**: Blue banner with "BETA" + version code.
- **Production Builds**: Clean icon without any badge.

---

## 2. Installing Prerequisites

The `badge` action requires `ImageMagick`:
```bash
# macOS
brew install imagemagick

# Ubuntu / Linux CI Runner
sudo apt-get install -y imagemagick

# Add fastlane plugin
cd android
bundle exec fastlane add_plugin badge
```

---

## 3. Fastlane Lane Implementation

```ruby
# android/fastlane/Fastfile

desc "Add beta badge to launcher icons before compilation"
lane :badge_icons do |options|
  version = load_flutter_version
  badge_text = options[:text] || "BETA"

  # Backup pristine icons before modifying
  sh("cp -r ../app/src/main/res/mipmap-* /tmp/icon_backup/ 2>/dev/null || true")

  badge(
    text: "#{badge_text} #{version[:code]}",
    dark: true,
    shield_geometry: "+0+15%",
    glob: "/../app/src/main/res/mipmap-*/ic_launcher.png"
  )

  UI.success("🏷️ Launcher icons badged with: #{badge_text} #{version[:code]}")
end

desc "Restore pristine launcher icons after build"
lane :restore_icons do
  sh("cp -r /tmp/icon_backup/* ../app/src/main/res/ 2>/dev/null || true")
  sh("rm -rf /tmp/icon_backup")
  UI.success("🧹 Restored pristine launcher icons.")
end
```

### Chaining with Build Lanes

```ruby
lane :build_beta_with_badge do
  begin
    badge_icons(text: "BETA")
    sh("cd ../.. && flutter build appbundle --release")
  ensure
    restore_icons # Always restore even if compilation fails!
  end
end
```
