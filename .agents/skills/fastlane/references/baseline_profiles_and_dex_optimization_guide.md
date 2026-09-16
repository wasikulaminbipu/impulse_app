# Android Baseline Profiles & DEX Optimization with Fastlane

This guide details configuring Android Baseline Profiles (`profileinstaller`), R8 Full Mode, and multi-dex layout optimization in Fastlane pipelines to minimize cold startup latency and frame drops in Flutter applications.

---

## 1. What are Baseline Profiles?

Baseline Profiles are pre-compiled AOT specifications bundled within Android App Bundles (`assets/dexopt/baseline.prof`). By identifying critical execution paths (e.g. splash screen, database initialization, catalog rendering):
- **Cold App Startup** improves by **20% to 40%**.
- **Jank / Frame Drops** on initial launch are significantly reduced by eliminating JIT compilation.

---

## 2. Setting Up Baseline Profiles in Flutter/Android

In `android/app/build.gradle.kts`:
```kotlin
plugins {
    id("androidx.baselineprofile") version "1.3.0"
}

dependencies {
    implementation("androidx.profileinstaller:profileinstaller:1.3.1")
}

baselineProfile {
    saveInSrc = true
    automaticGenerationDuringBuild = false
}
```

---

## 3. Fastlane Lane for Generating & Validating Baseline Profiles

Add this lane to `android/fastlane/Fastfile`:

```ruby
desc "Generate Android Baseline Profile on connected device or emulator"
lane :generate_baseline_profile do
  UI.message("Executing Baseline Profile Macrobenchmark...")
  
  # 1. Run Gradle task to generate profile rules
  sh("cd .. && ./gradlew :app:generateBaselineProfile")

  # 2. Verify generated baseline-prof.txt
  profile_file = "../app/src/main/baseline-prof.txt"
  unless File.exist?(profile_file)
    UI.user_error!("❌ baseline-prof.txt was not generated!")
  end

  rules_count = File.readlines(profile_file).count
  UI.success("✅ Baseline Profile generated with #{rules_count} optimized method rules.")
end

desc "Verify compiled AAB contains Baseline Profile assets"
lane :verify_baseline_profile_in_aab do |options|
  aab_path = options[:aab] || "../build/app/outputs/bundle/release/app-release.aab"
  raise "AAB not found at #{aab_path}" unless File.exist?(aab_path)

  # Check inside AAB archive for baseline.prof
  entries = sh("unzip -l #{aab_path}")
  if entries.include?("assets/dexopt/baseline.prof")
    UI.success("✅ Baseline Profile (baseline.prof) verified in release AAB!")
  else
    UI.important("⚠️ No baseline.prof found in AAB. Consider generating baseline profiles for faster startup.")
  end
end
```

---

## 4. R8 Full Mode & DEX Optimization Best Practices

In `android/gradle.properties`:
```properties
# Enable aggressive R8 code shrinking and optimization
android.enableR8.fullMode=true

# Optimize dexing memory allocation
org.gradle.jvmargs=-Xmx4096m -XX:+UseParallelGC
```

Ensure ProGuard / R8 keep rules preserve Flutter engine channels and Drift/SQLite native libraries:
```proguard
# Preserve Flutter JNI bindings
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }

# Preserve SQLite & Drift reflections
-keep class com.tekartik.sqflite.** { *; }
-keep class * extends net.sqlcipher.database.SQLiteOpenHelper { *; }
```
