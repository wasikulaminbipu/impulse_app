# CI/CD Caching & Build Optimization Guide

Strategies and recipes for minimizing GitHub Actions build minutes, optimizing Gradle daemons, speeding up Flutter builds, and reducing artifact transfer overhead.

> **Workspace Policy Note**: This repository enforces a strict **Zero-Cache Policy** in its active GitHub Actions workflows to eliminate cache poisoning, stale artifact conflicts, and build discrepancies. The caching patterns documented below are preserved intact for technical reference and knowledge.

---

## 1. Multi-Tier Caching Architecture

| Cache Scope | Action Used | Cache Key Strategy | Cache Content |
| :--- | :--- | :--- | :--- |
| **Java JDK / Gradle** | `actions/setup-java@v5` | `cache: 'gradle'` | Gradle wrapper, downloaded dependencies (`~/.gradle/caches`) |
| **Flutter SDK & Pub** | `subosito/flutter-action@v2` | `cache: true` | Downloaded Flutter SDK binaries, pub package cache (`~/.pub-cache`) |
| **Ruby / Bundler** | `ruby/setup-ruby@v1` | `bundler-cache: true`<br/>`working-directory: 'android'` | Fastlane gem dependencies (`android/vendor/bundle`) |

---

## 2. Optimizing Flutter Compilation in CI

### A. Obfuscation with Split Debug Symbols
Using `--obfuscate --split-debug-info` extracts debugging symbol tables into separate files, dramatically reducing the size of compiled `.so` native libraries inside the AAB/APK:
```bash
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols
```
- **Result**: 25–40% smaller AAB file download size for end users.
- **Fastlane integration**: Fastlane automatically uploads `mapping.txt` and native symbols to Google Play Console for accurate stack trace de-obfuscation.

### B. ProGuard & R8 Optimization
In `android/app/build.gradle.kts`:
```kotlin
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
```
- `proguard-android-optimize.txt` enables aggressive dead code elimination and inlining compared to the default non-optimized configuration.

---

## 3. GitHub Actions Runner Performance Best Practices

1. **Enable Concurrency Cancellation**:
   Always declare `cancel-in-progress: true` in PR workflows to immediately cancel stale builds when new commits are pushed.
2. **Artifact Retention Policy**:
   Set explicit retention days for CI artifacts to avoid exceeding storage quotas:
   ```yaml
   - uses: actions/upload-artifact@v4
     with:
       name: release-bundle-${{ github.ref_name }}
       path: build/app/outputs/bundle/release/app-release.aab
       retention-days: 30
   ```
3. **Disable Interactive Prompts**:
   Set `CI=true` and use `--no-pub` or `--non-interactive` flags where applicable to prevent commands from hanging awaiting input.
