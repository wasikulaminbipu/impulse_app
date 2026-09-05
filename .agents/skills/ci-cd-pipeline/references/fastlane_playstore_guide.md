# Fastlane & Google Play Console Guide

Comprehensive operational guide for Fastlane Android deployment, Google Play API service account configuration, track orchestration, and localized metadata management.

---

## 1. Fastlane Architecture Overview

Fastlane automates Play Store releases through its `supply` tool and Google Play Developer API v3.

### Directory Structure (`android/fastlane/`)
```text
android/fastlane/
├── Appfile                          # Package ID & JSON key credentials
├── Fastfile                         # Lanes definition (internal, beta, production, promote, metadata)
├── README.md                        # Documentation
└── metadata/android/                # Localized store assets
    ├── en-US/
    │   ├── title.txt                # Max 30 chars
    │   ├── short_description.txt    # Max 80 chars
    │   ├── full_description.txt     # Max 4000 chars
    │   ├── changelogs/
    │   │   └── <versionCode>.txt    # Max 500 chars
    │   └── images/
    │       ├── icon.png             # 512x512 PNG
    │       ├── featureGraphic.png   # 1024x500 PNG/JPEG
    │       ├── phoneScreenshots/    # 1_home.png, 2_directory.png, ...
    │       ├── sevenInchScreenshots/
    │       └── tenInchScreenshots/
    └── bn-BD/
        ├── title.txt
        ├── short_description.txt
        ├── full_description.txt
        ├── changelogs/
        │   └── <versionCode>.txt
        └── images/
            ├── icon.png
            ├── featureGraphic.png
            └── phoneScreenshots/
```

---

## 2. Fastlane `Appfile` Configuration (`android/fastlane/Appfile`)

```ruby
json_key_file(ENV["PLAYSTORE_JSON_KEY_FILE"] || "pc-api-key.json")
package_name("com.impulseagriscience.impulsedex")
```

---

## 3. Fastlane Lanes & Execution Commands

### A. Internal Testing Lane (`lane :internal`)
- **Target Track**: `internal` (Instant distribution for internal testers).
- **Execution Command**:
  ```bash
  cd android && bundle exec fastlane internal
  ```
- **Action**: Uploads `app-release.aab`, native ProGuard `mapping.txt`, and release notes (`changelogs/<versionCode>.txt`).

### B. Closed Testing / Beta Lane (`lane :beta`)
- **Target Track**: `beta` (Closed test track with 20+ opted-in testers for 14 days).
- **Execution Command**:
  ```bash
  cd android && bundle exec fastlane beta
  ```

### C. Production Staged Rollout Lane (`lane :production`)
- **Target Track**: `production` with default `user_fraction: 0.10` (10% staged rollout).
- **Execution Command**:
  ```bash
  cd android && bundle exec fastlane production
  ```

### D. Promotion Lane (`lane :promote`)
- **Purpose**: Promotes existing release across tracks without re-uploading the AAB.
- **Parameters**: `from_track`, `to_track`, `rollout`.
- **Execution Commands**:
  ```bash
  # Promote Beta to Production with 25% rollout
  cd android && bundle exec fastlane promote from_track:beta to_track:production rollout:0.25

  # Promote Staged Rollout to 100% Full Production
  cd android && bundle exec fastlane promote from_track:production to_track:production rollout:1.0
  ```

### E. Metadata Update Lane (`lane :metadata`)
- **Purpose**: Synchronizes store listings (titles, descriptions, changelogs) without modifying app binaries.
- **Execution Command**:
  ```bash
  cd android && bundle exec fastlane metadata
  ```

---

## 4. Google Play Developer API Service Account Setup

To authorize Fastlane to publish on your behalf:

1. **Open Google Play Console**: Go to **Developer Account > API Access**.
2. **Link Google Cloud Project**: Link or create a GCP project.
3. **Create Service Account**:
   - In GCP Console, create a Service Account: `play-store-deployer@project.iam.gserviceaccount.com`.
   - Role: `Service Account User`.
   - Keys: Generate a **JSON key** and download it (`pc-api-key.json`).
4. **Grant Permissions in Play Console**:
   - In Play Console **Users and Permissions**, invite the service account email.
   - Permissions:
     - *Releases*: View app information (read-only), Create, edit, and delete draft apps, Release apps to testing tracks, Release apps to production.
     - *Store presence*: Manage store presence.
5. **Add Key to GitHub Secrets**:
   - Copy the entire JSON content into GitHub Actions Secret: `PLAYSTORE_SERVICE_ACCOUNT_JSON`.
