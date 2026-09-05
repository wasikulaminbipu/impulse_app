# Local CLI Tools & Local-to-CI Parity Guide

Comprehensive architectural reference for the repository's standalone Dart CLI tools in `bin/`.

---

## 1. Tool Directory & Execution Summary

All tools are standalone Dart programs executed via `dart run bin/<script_name>.dart`.

| Tool | Source File | Flags / Options | Key Exit Codes |
| :--- | :--- | :--- | :--- |
| **Release Orchestrator** | `bin/release.dart` | `--dry-run`<br/>`--abort-tag=vX.Y.Z`<br/>`--skip-tests` | `0`: Success<br/>`1`: Gate failure / abort |
| **Version Bumper** | `bin/bump_version.dart` | `--patch`<br/>`--minor`<br/>`--major`<br/>`--dry-run` | `0`: Updated<br/>`1`: Invalid version |
| **Database Validator** | `bin/validate_db.dart` | None | `0`: PRAGMA OK<br/>`1`: Corrupted DB |
| **Asset Auditor** | `bin/audit_assets.dart` | None | `0`: All assets exist<br/>`1`: Missing DB image |
| **App Links Auditor** | `bin/audit_app_links.dart` | None | `0`: Domain matches<br/>`1`: Mismatch |
| **Play Store Auditor** | `bin/audit_playstore_compliance.dart` | None | `0`: 36/36 Passed<br/>`1`: Policy violation |
| **Coverage Badge Generator** | `bin/generate_coverage_badge.dart` | None | `0`: Badge created<br/>`1`: lcov missing |
| **Fastlane Asset Syncer** | `bin/sync_fastlane_assets.dart` | `--sync` | `0`: Compliant<br/>`1`: Missing icon/banner |
| **Unused Code Auditor** | `bin/audit_unused_code.dart` | None | `0`: Audit complete |

---

## 2. Detailed Tool Specifications

### `bin/release.dart` (Enterprise 8-Stage Release Orchestrator)
Orchestrates the entire release process locally or in automated agent pipelines:
- **Interactive Mode**: Prompts for version increment type, runs validations, stages git, pushes tag, and watches CI.
- **Automated Mode**: Can be invoked non-interactively.
- **Rollback / Abort Mode**:
  ```bash
  dart run bin/release.dart --abort-tag=v1.0.5
  ```
  Deletes local and remote tags and purges uncommitted release state cleanly.

### `bin/bump_version.dart` (Semantic Versioning & Changelogs)
- Parses current version from `pubspec.yaml` (e.g. `1.0.4+5`).
- Increments version:
  - `--patch`: `1.0.4+5` $\rightarrow$ `1.0.5+6`
  - `--minor`: `1.0.4+5` $\rightarrow$ `1.1.0+6`
  - `--major`: `1.0.4+5` $\rightarrow$ `2.0.0+6`
- Automatically generates new changelog file: `android/fastlane/metadata/android/en-US/changelogs/6.txt` and `bn-BD/changelogs/6.txt`.

### `bin/validate_db.dart` (SQLite Database PRAGMA Checker)
- Loads `assets/db/products.db` and `assets/db/distributors.db` via `package:sqlite3`.
- Asserts:
  - `PRAGMA integrity_check == 'ok'`
  - `PRAGMA foreign_key_check` returns 0 rows.
  - Required tables exist: `products`, `distributors`, `manufacturers`, `symptoms`, `ingredients`.

### `bin/audit_assets.dart` (Database Asset Cross-Reference)
- Queries all image columns from SQLite databases.
- Verifies every referenced filename exists in `assets/images/`.
- Fails CI if any record points to a non-existent image.

### `bin/audit_app_links.dart` (Android App Links Deep Linking)
- Parses `android/app/src/main/AndroidManifest.xml` intent-filters.
- Verifies `android:autoVerify="true"` and HTTPS host configuration.
- Verifies `.well-known/assetlinks.json` SHA256 certificate fingerprints match signing keystore.

### `bin/audit_playstore_compliance.dart` (36-Point Google Play Compliance Audit)
Audits:
1. Target SDK 35+ (Android 15 requirement).
2. 16KB memory page alignment in native binaries.
3. Fastlane metadata length limits (title $\le 30$, short desc $\le 80$, full desc $\le 4000$, changelogs $\le 500$).
4. Forbidden permissions check (no unauthorized SMS/call logs).
5. Privacy policy HTTPS link verification.
