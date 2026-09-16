# Fastlane Comprehensive Troubleshooting & Recovery Guide

This playbook categorizes real-world errors encountered when running Fastlane for Flutter cross-platform projects across Android, iOS, Google Play Console, Apple App Store, and GitHub Actions CI/CD runners.

---

## 1. Google Play Console & Android Supply Errors

### Error 1: "Package not found" / Initial Upload Block
- **Log Snippet**:
  ```
  [!] Google Api Error: Invalid request - Package not found: com.impulseagriscienceltd.impulse_app
  ```
- **Root Cause**: Google Play Developer API prohibits initial app creation or uploading the very first APK/AAB via automated API calls.
- **Remediation**:
  1. Open Google Play Console in a web browser.
  2. Create the application manually.
  3. Navigate to **Testing** > **Internal testing** (or any track) and manually upload the initial `app-release.aab`.
  4. Save and roll out the release once. Subsequent releases can now be uploaded via Fastlane.

---

### Error 2: "403 Forbidden - The caller does not have permission"
- **Log Snippet**:
  ```
  Google Api Error: 403 Forbidden - The caller does not have permission
  ```
- **Root Cause**: The Google Cloud service account has not been granted release permissions in Google Play Console, or the Google Play Android Developer API is disabled in GCP.
- **Remediation**:
  1. In Google Cloud Console, enable **Google Play Android Developer API**.
  2. In Google Play Console > **API access**, invite/link the service account email.
  3. Under **App permissions**, grant the service account **Admin** or **Release manager** access to the app.
  4. Allow up to 15–30 minutes for IAM propagation across Google infrastructure.

---

### Error 3: "Changelog for language en-US exceeds maximum length of 500"
- **Log Snippet**:
  ```
  Google Api Error: Invalid request - changelog too long for language en-US. Max length is 500.
  ```
- **Root Cause**: Google Play strictly enforces a 500-character ceiling on release notes per locale.
- **Remediation**:
  - Truncate `android/fastlane/metadata/android/en-US/changelogs/<version_code>.txt` and `bn-BD/` to $\le 500$ characters.
  - Run the project's changelog generator:
    ```bash
    dart run bin/release.dart --notes="Summary of release notes under 500 characters"
    ```

---

### Error 4: "Changes cannot be sent for review while an existing review is pending"
- **Log Snippet**:
  ```
  Google Api Error: 400 Bad Request - Changes cannot be sent for review while an existing review is pending.
  ```
- **Root Cause**: Managed Publishing is enabled and an earlier release or store listing change is currently in the "In review" state.
- **Remediation**:
  1. Open Google Play Console > **Publishing overview**.
  2. Either wait for Google's policy review team to approve the pending changes, or click **Turn off managed publishing** / cancel the pending item.
  3. Or pass `changes_not_sent_for_review: false` in Fastlane to stage the changes without attempting immediate review submission.

---

### Error 5: "Draft release already exists in track"
- **Log Snippet**:
  ```
  Google Api Error: 400 Bad Request - A release already exists in 'draft' status for this track.
  ```
- **Root Cause**: A manual draft or interrupted Fastlane upload left a draft release blocking the track.
- **Remediation**:
  1. Open Google Play Console > Target Track (e.g. Production or Beta).
  2. Click **Edit release** on the draft release.
  3. Click **Discard release** in the bottom-right corner.
  4. Re-run `bundle exec fastlane [lane]`.

---

## 2. Apple App Store & iOS Errors

### Error 6: "Apple ID 2-Step Verification session expired"
- **Log Snippet**:
  ```
  [!] Two-factor authentication is enabled for your Apple ID!
  [!] Please enter the 6 digit code:
  ```
- **Root Cause**: Interactive 2FA prompts cannot succeed on headless CI/CD runners.
- **Remediation**:
  Migrate to App Store Connect API Key (`.p8`):
  ```ruby
  app_store_connect_api_key(
    key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
    issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
    key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"]
  )
  ```

---

### Error 7: "Missing Export Compliance"
- **Log Snippet**:
  ```
  [!] App Store Connect: Missing Compliance - You must provide export compliance before this build can be tested.
  ```
- **Root Cause**: TestFlight requires encryption declaration before distributing builds to external groups.
- **Remediation**:
  1. In `ios/Runner/Info.plist`, add:
     ```xml
     <key>ITSAppUsesNonExemptEncryption</key>
     <false/>
     ```
  2. Or pass compliance in Fastlane `upload_to_app_store`:
     ```ruby
     submission_information: {
       export_compliance_uses_encryption: false
     }
     ```

---

### Error 8: "Match failed to decrypt repository"
- **Log Snippet**:
  ```
  [!] Could not decrypt repo, please make sure you pass the correct password.
  ```
- **Root Cause**: `MATCH_PASSWORD` environment variable is missing, incorrect, or contains unescaped special characters.
- **Remediation**:
  Verify the passphrase in developer terminal:
  ```bash
  export MATCH_PASSWORD="your-secure-passphrase"
  bundle exec fastlane match appstore --readonly
  ```

---

## 3. Ruby & Bundler Environment Errors

### Error 9: "Could not find fastlane (Bundler::GemNotFound)"
- **Log Snippet**:
  ```
  bundler: failed to load command: fastlane (.../bin/fastlane)
  Bundler::GemNotFound: Could not find gem 'fastlane' in any of the gem sources.
  ```
- **Root Cause**: Gems have not been installed in the local environment, or `bundle exec` was omitted.
- **Remediation**:
  ```bash
  cd android # or cd ios
  bundle install
  bundle exec fastlane [lane]
  ```

---

### Error 10: "Ruby version mismatch between host and Gemfile"
- **Log Snippet**:
  ```
  Your Ruby version is 3.1.2, but your Gemfile specified >= 3.3.0
  ```
- **Remediation**:
  Use `rbenv`, `asdf`, or GitHub Actions `ruby/setup-ruby@v1` with explicit Ruby 3.3:
  ```yaml
  - uses: ruby/setup-ruby@v1
    with:
      ruby-version: '3.3'
      working-directory: 'android'
      bundler-cache: false
  ```
