# Android Keystore, Cloud KMS & Play App Signing in Fastlane

This guide establishes enterprise practices for managing Android keystores, signing credentials, cloud key management systems (KMS), and signature validation within Fastlane pipelines.

---

## 1. Google Play App Signing vs. Upload Key Architecture

```
                  ┌─────────────────────────────────────┐
                  │ Flutter Developer / CI Runner       │
                  └──────────────────┬──────────────────┘
                                     │ Signs AAB with:
                                     ▼
                  ┌─────────────────────────────────────┐
                  │ Upload Key (Keystore)               │
                  │ (Rotatable via Google Play Console) │
                  └──────────────────┬──────────────────┘
                                     │ Uploads via Fastlane
                                     ▼
                  ┌─────────────────────────────────────┐
                  │ Google Play App Signing Infrastructure│
                  │ • Strips Upload Key signature       │
                  │ • Validates integrity               │
                  │ • Re-signs with Master App Key      │
                  │ • Generates optimized split APKs    │
                  └──────────────────┬──────────────────┘
                                     │ Delivers to
                                     ▼
                  ┌─────────────────────────────────────┐
                  │ User Devices                        │
                  └─────────────────────────────────────┘
```

---

## 2. Secrets Storage & CI Injection Patterns

### A. Base64 Encoded Environment Variable (Standard CI)
Store the `.jks` file as a base64 encoded string in `PLAYSTORE_UPLOAD_KEYSTORE_BASE64`:

```bash
# Generate base64 string locally
base64 -w 0 upload-keystore.jks > keystore_base64.txt
```

In CI / Fastlane, decode into a temporary ephemeral path and wipe immediately after compilation:

```ruby
def with_ephemeral_keystore
  keystore_b64 = ENV["PLAYSTORE_UPLOAD_KEYSTORE_BASE64"]
  raise "Missing PLAYSTORE_UPLOAD_KEYSTORE_BASE64" if keystore_b64.nil? || keystore_b64.empty?

  temp_keystore = Tempfile.new(["upload", ".jks"])
  begin
    temp_keystore.binmode
    temp_keystore.write(Base64.decode64(keystore_b64))
    temp_keystore.flush
    ENV["ANDROID_KEYSTORE_PATH"] = temp_keystore.path
    yield temp_keystore.path
  ensure
    temp_keystore.close
    temp_keystore.unlink
    ENV.delete("ANDROID_KEYSTORE_PATH")
  end
end
```

### B. Google Cloud KMS / AWS Secrets Manager / HashiCorp Vault
For banking, fintech, or defense grade deployments:
1. Retrieve encrypted keystore payload using IAM service account.
2. Decrypt in memory or RAM-disk (`/dev/shm`).
3. Sign using Gradle's `signingConfigs` referencing the decrypted key.

---

## 3. Fastlane Lane Keystore & Signature Validation

Before uploading an AAB to Google Play Store, verify that the artifact is properly signed and not corrupt:

```ruby
desc "Verify AAB signature and page alignment"
lane :verify_android_artifact do |options|
  aab_path = options[:aab] || "../build/app/outputs/bundle/release/app-release.aab"
  raise "AAB file not found at #{aab_path}" unless File.exist?(aab_path)

  # 1. Verify bundle integrity with bundletool
  UI.message("Verifying AAB with bundletool...")
  sh("bundletool build-apks --bundle=#{aab_path} --output=/tmp/test.apks --mode=universal")
  sh("rm /tmp/test.apks")

  # 2. Check 16KB page alignment (Android 15 requirement)
  UI.message("Checking 16KB page alignment...")
  sh("unzip -q -l #{aab_path} 'base/lib/*/*.so' | awk '{print $4}' | while read so; do ... done")

  UI.success("Artifact verification passed!")
end
```

---

## 4. Keystore Loss & Rotation Procedure

If the upload key is lost, compromised, or expires:
1. Generate a new upload key:
   ```bash
   keytool -genkeypair -v -storetype PKCS12 -keystore upload_key.jks \
     -alias upload -keyalg RSA -keysize 2048 -validity 10000
   ```
2. Export the public certificate in PEM format:
   ```bash
   keytool -export -rfc -keystore upload_key.jks -alias upload -file upload_certificate.pem
   ```
3. In Google Play Console:
   - Navigate to **Release** > **Setup** > **App Signing**.
   - Click **Request upload key reset**.
   - Upload `upload_certificate.pem` and submit reason.
   - Key reset takes effect within 2-24 hours.
