# GitHub Actions Workflows Deep Technical Reference

Comprehensive architectural guide and configuration reference for all GitHub Actions workflows in the Impulse DEX repository.

---

## 1. Pull Request Verification Gate (`.github/workflows/pr_ci.yml`)

### Purpose & Trigger Conditions
- **Triggers**: Pull requests targeting `main`, `master`, or `develop`.
- **Concurrency**:
  ```yaml
  concurrency:
    group: pr-ci-${{ github.event.pull_request.number || github.ref }}
    cancel-in-progress: true
  ```
  Automatically terminates older in-progress builds when a contributor pushes new commits to the PR branch, saving runner minutes and preventing race conditions.
- **Permissions**:
  ```yaml
  permissions:
    contents: read
    pull-requests: write
  ```
  `pull-requests: write` is strictly required for the test suite job to post and update sticky summary comments on the PR thread.

### Job 1: `quality-gate` (Linting, Formatting & Audits)
Runs on `ubuntu-latest` with Temurin JDK 17 (Gradle cache enabled) and Flutter stable (Pub cache enabled).

**Step Sequence**:
1. **Repository Checkout**: `actions/checkout@v4`
2. **JDK 17 Setup**: `actions/setup-java@v5` (`distribution: 'temurin'`, `java-version: '17'`, `cache: 'gradle'`)
3. **Flutter SDK Setup**: `subosito/flutter-action@v2` (`channel: 'stable'`, `cache: true`)
4. **Dependency Resolution**: `flutter pub get`
5. **Database Integrity Verification**:
   ```bash
   dart run bin/validate_db.dart
   ```
   Opens `products.db` and `distributors.db` using sqlite3 C-bindings and asserts `PRAGMA integrity_check == 'ok'` and `PRAGMA foreign_key_check` returns zero violations.
6. **Asset Inventory Audit**:
   ```bash
   dart run bin/audit_assets.dart
   ```
   Cross-references every image path stored in the database against the filesystem under `assets/images/`.
7. **App Links Deep Link Validation**:
   ```bash
   dart run bin/audit_app_links.dart
   ```
   Validates HTTPS intent filters in `AndroidManifest.xml` against `.well-known/assetlinks.json`.
8. **Play Store Compliance Audit**:
   ```bash
   dart run bin/audit_playstore_compliance.dart
   ```
   Runs 36 automated compliance checks including Target SDK 35+, 16KB memory page alignment, permission boundaries, and Fastlane text limits.
9. **Dependency Deprecation Scan**:
   ```bash
   flutter pub outdated --no-dev-dependencies || true
   ```
10. **Build Runner Codegen Synchronization Gate**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    if [ -n "$(git status --porcelain)" ]; then
      echo "::error::Generated files are out of sync with code changes! Run build_runner locally."
      git status --porcelain
      exit 1
    fi
    ```
11. **Code Formatting Validation**:
    ```bash
    dart format --output=none --set-exit-if-changed .
    ```
12. **Strict Static Analysis**:
    ```bash
    flutter analyze --fatal-infos --fatal-warnings
    ```
13. **Step Summary Generation**:
    Appends markdown status report to `$GITHUB_STEP_SUMMARY`.

### Job 2: `test-suite` (Testing & Coverage Reporting)
Runs on `ubuntu-latest`, depends on `quality-gate`.

**Step Sequence**:
1. Setup JDK, Flutter SDK, and dependencies.
2. Run Freezed/Drift code generator.
3. Run test suite with coverage:
   ```bash
   flutter test --coverage
   ```
4. Generate Dynamic SVG Coverage Badge:
   ```bash
   dart run bin/generate_coverage_badge.dart
   ```
5. Extract Test Metrics & Post PR Sticky Comment:
   Parses `coverage/lcov.info` and test results, then uses GitHub REST API to post or update a formatted markdown comment on the PR.

---

## 2. Production Release & Deployment (`.github/workflows/deploy_playstore.yml`)

### Purpose & Trigger Conditions
- **Triggers**:
  - Push of tag matching `v*` (e.g. `v1.0.4+5`).
  - Manual `workflow_dispatch` with parameters: `track`, `create_github_release`, `custom_changelog`.
- **Permissions**: `contents: write`.

### 5-Job Modular DAG Topology

```
┌─────────────────┐     ┌──────────────┐     ┌─────────────────────────┐
│  quality-gate   │ ──► │  test-suite  │ ──► │ build-release-artifacts │
└─────────────────┘     └──────────────┘     └───────────┬─────────────┘
                                                         │
                                        ┌────────────────┴────────────────┐
                                        ▼                                 ▼
                             ┌────────────────────┐            ┌─────────────────────────┐
                             │ deploy-google-play │            │ publish-github-release  │
                             └────────────────────┘            └─────────────────────────┘
```

### Step Breakdown by Job:
- **Job 1 (`quality-gate`)**: Identical pre-flight validation gate as PR CI.
- **Job 2 (`test-suite`)**: Full automated unit, provider, and widget test execution.
- **Job 3 (`build-release-artifacts`)**:
  - Decodes base64 PKCS12 keystore (`key.p12`) and `key.properties`.
  - Compiles obfuscated Android App Bundle (AAB):
    ```bash
    flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
    ```
  - Compiles obfuscated Universal Release APK:
    ```bash
    flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
    ```
  - Bundles and uploads artifacts via `actions/upload-artifact@v4` (`name: release-bundle-${{ github.ref_name }}`) retaining `app-release.aab`, `app-release.apk`, `mapping.txt`, and symbols.
- **Job 4 (`deploy-google-play`)**:
  - Downloads release bundle artifact.
  - Sets up Ruby 3.2 with Bundler caching in `android/`.
  - Decodes Google Play API service account key (`android/pc-api-key.json`).
  - Executes Fastlane track (`bundle exec fastlane $TRACK`).
- **Job 5 (`publish-github-release`)**:
  - Attaches `app-release.aab` and `app-release.apk`.
  - Generates release notes from commit history using `softprops/action-gh-release@v2`.

---

## 3. Release Promotion Workflow (`.github/workflows/promote_release.yml`)

### Purpose & Inputs
Promotes existing releases between tracks without re-compiling binaries:
- `from_track` (default: `beta`)
- `to_track` (default: `production`)
- `rollout_fraction` (default: `0.10`, options: `0.10`, `0.25`, `0.50`, `1.0`)

```bash
gh workflow run promote_release.yml \
  -f from_track=beta \
  -f to_track=production \
  -f rollout_fraction=0.10
```

---

## 4. Weekly Maintenance Workflow (`.github/workflows/weekly_maintenance.yml`)

### Purpose & Schedule
- **Schedule**: `0 0 * * 0` (Every Sunday at 00:00 UTC).
- **Checks**:
  - Scans dependencies for vulnerabilities and major updates.
  - Audits database assets for bit rot or integrity degradation.
  - Re-verifies Android 15/SDK 35 policy compliance.
