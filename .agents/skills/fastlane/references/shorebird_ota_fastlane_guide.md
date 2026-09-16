# Shorebird Code Push & Fastlane Dual-Track Delivery Guide

This guide details how to integrate **Shorebird (Flutter Over-The-Air Code Push)** with **Fastlane** to establish a modern dual-track mobile delivery pipeline:
1. **Binary Track (Fastlane)**: Native code updates, SDK upgrades, permissions changes, store review releases.
2. **OTA Patch Track (Shorebird)**: Instant Dart code bugfixes, UI tweaks, business logic updates deployed in minutes without store review delays.

---

## 1. Dual-Track Architecture Topology

```
                  ┌───────────────────────────────┐
                  │ Git Push / Release Trigger    │
                  └──────────────┬────────────────┘
                                 │
                 Is Native Code / SDK Changed?
                                 │
               ┌─────────────────┴─────────────────┐
              YES                                  NO
               │                                   │
      [Full Binary Track]                  [OTA Patch Track]
               │                                   │
      ┌────────┴────────┐                 ┌────────┴────────┐
      │ Flutter AAB/IPA │                 │ Shorebird Patch │
      │ Compilation     │                 │ Compilation     │
      └────────┬────────┘                 └────────┬────────┘
               │                                   │
      ┌────────┴────────┐                 ┌────────┴────────┐
      │ Fastlane Supply │                 │ Shorebird CLI   │
      │ / Pilot Deploy  │                 │ Distribution    │
      └────────┬────────┘                 └────────┬────────┘
               │                                   │
      ┌────────┴────────┐                 ┌────────┴────────┐
      │ Store Review &  │                 │ Instant Client  │
      │ Staged Rollout  │                 │ OTA Ingestion   │
      └─────────────────┘                 └─────────────────┘
```

---

## 2. Setting Up Shorebird in a Fastlane Pipeline

### A. Shorebird Installation in CI
```bash
# In CI runner (GitHub Actions / GitLab / Bitrise)
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh | bash
echo "$HOME/.shorebird/bin" >> $GITHUB_PATH
```

### B. Shorebird Token Management
Generate a CI token:
```bash
shorebird login:ci
```
Store the resulting token as `SHOREBIRD_TOKEN` in CI repository secrets.

---

## 3. Fastlane Lanes for Shorebird

Add the following lanes to `android/fastlane/Fastfile` and `ios/fastlane/Fastfile`:

### Android Fastfile Shorebird Lanes

```ruby
platform :android do
  desc "Create a new baseline Shorebird release and upload to Google Play"
  lane :shorebird_release do |options|
    track = options[:track] || "internal"

    # 1. Build and register release with Shorebird
    sh("shorebird release android --no-confirm")

    # 2. Deploy generated AAB via Fastlane Supply
    aab_path = "../build/app/outputs/bundle/release/app-release.aab"
    upload_to_play_store(
      track: track,
      aab: aab_path,
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )
  end

  desc "Deploy an instant OTA patch for current Flutter release"
  lane :shorebird_patch do |options|
    target_track = options[:track] || "production"
    
    # Verify clean working tree and build Shorebird patch
    sh("shorebird patch android --no-confirm")
    
    # Notify Slack/Discord of patch deployment
    post_chatops_notification(
      channel: "#mobile-releases",
      message: "🚀 Shorebird OTA Patch deployed successfully to #{target_track}!"
    )
  end
end
```

---

## 4. Operational Rules & Guardrails

1. **Never Patch Native Code**:
   - Shorebird cannot patch Kotlin/Java, Swift/Obj-C, AndroidManifest, Info.plist, or native C/C++ plugins.
   - Attempting to patch native changes will cause client crashes or silent failure.
2. **Version Pinning**:
   - Every patch is bound strictly to the `version` and `build_number` specified in `pubspec.yaml`.
   - Never bump the build number when issuing a patch; it must match the base binary release.
3. **Patch Rollback**:
   - If a bad patch is deployed, disable it instantly in the Shorebird Console or run:
   ```bash
   shorebird patch android --rollback
   ```
