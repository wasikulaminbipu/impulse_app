# Deep Gradle & Fastlane Integration Guide for Flutter Android

This guide details configuring native Gradle compilation, signing configs, ProGuard/R8 mapping verification, and NDK symbols using Fastlane's built-in `gradle` action and Flutter build pipelines.

---

## 1. Direct Gradle Execution in Fastlane

While `flutter build appbundle` is standard for Flutter apps, Fastlane can also invoke Gradle tasks directly using the `gradle` action:

```ruby
# android/fastlane/Fastfile

desc "Assemble release bundle directly with Gradle"
lane :build_gradle_bundle do
  gradle(
    task: "bundle",
    flavor: "prod",
    build_type: "Release",
    flags: "--no-daemon --stacktrace",
    properties: {
      "android.injected.signing.store.file" => "upload-keystore.jks",
      "android.injected.signing.store.password" => ENV["STORE_PASSWORD"],
      "android.injected.signing.key.alias" => ENV["KEY_ALIAS"],
      "android.injected.signing.key.password" => ENV["KEY_PASSWORD"]
    }
  )
end
```

---

## 2. Dynamic Signing Configuration in `build.gradle.kts`

To prevent hardcoding passwords or file paths, configure signing in `android/app/build.gradle.kts` to read from `key.properties` or environment variables:

```kotlin
import java.io.FileInputStream
import java.util.Properties

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        create("release") {
            val storeFilePath = keystoreProperties.getProperty("storeFile") 
                ?: System.getenv("STORE_FILE") ?: "upload-keystore.jks"
            val resolvedStoreFile = file(storeFilePath)
            if (resolvedStoreFile.exists()) {
                storeFile = resolvedStoreFile
                storePassword = keystoreProperties.getProperty("storePassword") 
                    ?: System.getenv("STORE_PASSWORD")
                keyAlias = keystoreProperties.getProperty("keyAlias") 
                    ?: System.getenv("KEY_ALIAS")
                keyPassword = keystoreProperties.getProperty("keyPassword") 
                    ?: System.getenv("KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

---

## 3. Extracting and Verifying R8 De-obfuscation Mappings

When R8 shrinking is enabled, Android compiles an obfuscated binary and outputs a symbol translation table:

```
build/app/outputs/mapping/release/mapping.txt
```

### Fastlane Pre-Upload Mapping Verification
In `Fastfile`, verify that `mapping.txt` was generated before uploading to Google Play:

```ruby
mapping_file = "../build/app/outputs/mapping/release/mapping.txt"
unless File.exist?(mapping_file) && File.size(mapping_file) > 0
  UI.user_error!("❌ ProGuard/R8 mapping.txt is missing or empty! De-obfuscation mapping is strictly required for crash reporting.")
end
```
Passing it to supply:
```ruby
upload_to_play_store(
  track: "production",
  aab: "../build/app/outputs/bundle/release/app-release.aab",
  mapping_paths: [mapping_file]
)
```
