# CI/CD Failure Triage & Troubleshooting Matrix

Exhaustive runbook for diagnosing and fixing failures across GitHub Actions, Gradle builds, Fastlane deployments, and local Git hooks.

---

## 1. Code Quality & Static Analysis Failures

### 1.1 Uncommitted Generated Code Drift
- **Error Log**: `::error::Generated code is out of sync with code changes!` or `git status --porcelain` outputs dirty files.
- **Root Cause**: A developer modified an entity, DAO, or model without regenerating Freezed/Drift files.
- **Fix**:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  git add lib/
  git commit -m "chore(codegen): synchronize generated models"
  git push
  ```

### 1.2 Fatal Analysis Warnings / Linting Failures
- **Error Log**: `flutter analyze --fatal-infos --fatal-warnings` exits with code 1.
- **Root Cause**: Unused imports, missing const keywords, deprecated API usages, or styling violations.
- **Fix**:
  ```bash
  flutter analyze
  # Fix all reported issues, re-verify with:
  flutter analyze --fatal-infos --fatal-warnings
  git commit -am "fix(lint): resolve static analysis warnings"
  git push
  ```

### 1.3 Dart Code Formatting Failure
- **Error Log**: `dart format --output=none --set-exit-if-changed .` exits with code 1.
- **Root Cause**: Dart source file does not match official Dart style conventions.
- **Fix**:
  ```bash
  dart format .
  git commit -am "style: format dart code"
  git push
  ```

---

## 2. Database & Asset Audit Failures

### 2.1 SQLite PRAGMA Integrity Check Failure
- **Error Log**: `validate_db.dart: PRAGMA integrity_check failed` or `PRAGMA foreign_key_check` reported errors.
- **Root Cause**: SQLite database file (`products.db` / `distributors.db`) contains malformed B-tree records, orphaned foreign keys, or corruption.
- **Fix**:
  ```bash
  # Test locally:
  dart run bin/validate_db.dart
  # Rebuild/re-export DB from tools/impulse-data-entry.html, verify, commit:
  git add assets/db/
  git commit -m "fix(db): restore verified SQLite database assets"
  git push
  ```

### 2.2 Missing Image Assets Cross-Reference Failure
- **Error Log**: `audit_assets.dart: Missing DB images on disk: [image_123.jpg]`.
- **Root Cause**: Database references an image filename that does not exist in `assets/images/`.
- **Fix**:
  Add missing image file to `assets/images/` or update database record image field. Verify with `dart run bin/audit_assets.dart`.

### 2.3 Android App Links Verification Failure
- **Error Log**: `audit_app_links.dart: Missing auto-verify domain` or SHA256 mismatch.
- **Root Cause**: `AndroidManifest.xml` intent-filter domain does not match `.well-known/assetlinks.json`.
- **Fix**:
  Ensure both files specify matching HTTPS domains and certificate SHA256 fingerprints. Verify with `dart run bin/audit_app_links.dart`.

---

## 3. Google Play Policy & Metadata Failures

### 3.1 Metadata Character Limit Exceeded
- **Error Log**: `audit_playstore_compliance.dart: Title > 30 chars` or `Changelog > 500 chars`.
- **Root Cause**: Fastlane text metadata exceeds Google Play limits.
- **Fix**:
  Edit `android/fastlane/metadata/android/<locale>/` text files:
  - `title.txt`: $\le 30$ chars.
  - `short_description.txt`: $\le 80$ chars.
  - `full_description.txt`: $\le 4000$ chars.
  - `changelogs/<versionCode>.txt`: $\le 500$ chars.

### 3.2 Target SDK Policy Failure
- **Error Log**: `audit_playstore_compliance.dart: Target SDK < 35`.
- **Root Cause**: `android/app/build.gradle.kts` specifies `targetSdk < 35`.
- **Fix**:
  Update `targetSdk = 35` (Android 15) in `build.gradle.kts`.

---

## 4. Build, Signing & Fastlane Deployment Failures

### 4.1 Missing Keystore / Signing Error in CI
- **Error Log**: `Keystore file not found for signing config 'release'` or `base64: invalid input`.
- **Root Cause**: `PLAYSTORE_UPLOAD_KEYSTORE_BASE64` or `PLAYSTORE_KEY_PROPERTIES` secret is missing in GitHub repository settings.
- **Fix**:
  Verify repository secrets under **Settings > Secrets and variables > Actions**. Check that `storeFile` path matches the decoded output filename (`key.p12`).

### 4.2 Version Code Conflict (`apkUpgradeVersionConflict`)
- **Error Log**: `Google Api Error: apkUpgradeVersionConflict: Version code X has already been used`.
- **Root Cause**: An AAB with the same or higher `versionCode` already exists on Google Play Console.
- **Fix**:
  Run `dart run bin/bump_version.dart --patch` (which increments `versionCode`), commit `pubspec.yaml`, re-create the Git tag, and push.

### 4.3 Package Not Found on Play Console
- **Error Log**: `Google Api Error: Invalid request - Package not found: com.impulseagriscience.impulsedex`.
- **Root Cause**: The application has never had its first AAB manually uploaded in Play Console.
- **Fix**:
  Upload the initial signed `.aab` manually once through Google Play Console web interface. All subsequent updates can use Fastlane API.

### 4.4 Review Not Sent (`changesNotSentForReview`)
- **Error Log**: `Google Api Error: changesNotSentForReview: Changes cannot be sent for review`.
- **Root Cause**: Fastlane attempting to publish without explicit draft review flag.
- **Fix**:
  Add `changes_not_sent_for_review: true` to the Fastlane lane configuration.

### 4.5 PR Comment Permission Denied (HTTP 403)
- **Error Log**: `Resource not accessible by integration` on PR step.
- **Root Cause**: GitHub Actions token lacks `pull-requests: write` permission.
- **Fix**:
  Add `permissions: pull-requests: write` to the workflow or job in `.github/workflows/pr_ci.yml`.
