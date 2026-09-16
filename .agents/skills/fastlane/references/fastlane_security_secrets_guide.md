# Fastlane Security & Secrets Management Playbook

This reference provides production-grade security standards for managing Fastlane credentials, API keys, certificates, and provisioning profiles across local developer workstations and headless CI/CD runner environments.

---

## 1. Secrets Classification & Storage

| Secret | Sensitive Data | Recommended Storage | Access Scope |
| :--- | :--- | :--- | :--- |
| **Google Play Service Account JSON** | Private RSA Key (`"private_key"`) | GitHub Actions Secret (`PLAYSTORE_SERVICE_ACCOUNT_JSON`) | Deployment runners only. Never commit to repo. |
| **Play Store Upload Keystore (`.jks`)** | Upload Signing Key & Passwords | Base64 Secret (`PLAYSTORE_UPLOAD_KEYSTORE_BASE64`) | Build runners only. Never commit binary `.jks` to git. |
| **`key.properties`** | Keystore & Key Passwords | Base64 Secret (`PLAYSTORE_KEY_PROPERTIES`) | Generated dynamically on runner; wiped after build. |
| **App Store Connect API Key (`.p8`)** | Apple Developer Private Key | GitHub Actions Secret (`APP_STORE_CONNECT_KEY_CONTENT`) | Deployment runners only. |
| **`match` Passphrase** | Certificate Decryption Key | Secret (`MATCH_PASSWORD`) | Kept in password manager / CI secrets. |

---

## 2. Eliminating Disk Artifacts: In-Memory Credentials

Modern Fastlane actions eliminate the need to write private keys to runner disk files:

### Google Play: `json_key_data` vs `json_key`
Instead of writing `android/pc-api-key.json`, pass the raw JSON string directly:

```ruby
upload_to_play_store(
  package_name: "com.impulseagriscienceltd.impulse_app",
  json_key_data: ENV["PLAYSTORE_SERVICE_ACCOUNT_JSON"],
  track: "internal",
  aab: "../build/app/outputs/bundle/release/app-release.aab"
)
```

### Apple App Store Connect: `key_content` vs `key_filepath`
Instead of saving an `AuthKey_XXXXXXXXXX.p8` file to disk:

```ruby
app_store_connect_api_key(
  key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
  issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
  key_content: ENV["APP_STORE_CONNECT_KEY_CONTENT"],
  is_key_content_base64: false
)
```

---

## 3. Runner Disk Wiping & Post-Execution Cleanup

When temporary files (such as upload keystores or key property files) must be written for Flutter or Gradle compilation, always register an `always()` post-step cleanup in CI:

```yaml
      - name: "Securely wipe release credentials from runner disk"
        if: always()
        run: |
          # Overwrite with random data or zeroes before removing
          if [ -f android/app/upload-keystore.jks ]; then
            dd if=/dev/urandom of=android/app/upload-keystore.jks bs=1k count=10 2>/dev/null || true
            rm -f android/app/upload-keystore.jks
          fi
          rm -f android/pc-api-key.json
          rm -f android/key.properties
          rm -f android/app/key.properties
```

---

## 4. Secret Encoding & Decoding Helpers

### Encoding on Developer Machine
```bash
# Encode keystore to single-line base64 string
base64 -w 0 android/app/release-upload-key.jks > keystore_base64.txt

# Encode key.properties
base64 -w 0 android/key.properties > key_props_base64.txt
```

### Decoding in CI/CD Runner
```bash
echo "$PLAYSTORE_UPLOAD_KEYSTORE_BASE64" | base64 -d > android/app/upload-keystore.jks
echo "$PLAYSTORE_KEY_PROPERTIES" | base64 -d > android/key.properties
```

---

## 5. Preventing Accidental Git Commits

Add the following ignore patterns to `.gitignore` across project and platform directories:

```gitignore
# Fastlane & Release Credentials
android/pc-api-key.json
android/fastlane/*.json
ios/fastlane/AuthKey_*.p8
ios/fastlane/*.p8
*.jks
*.keystore
*.p12
key.properties
android/key.properties
android/app/key.properties
```
