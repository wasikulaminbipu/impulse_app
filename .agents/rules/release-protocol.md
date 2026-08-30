# Enterprise Release Protocol & Publishing Standard

Whenever a release is requested or initiated (via AI interaction or `dart run bin/release.dart`), all agents and tools MUST follow this exact, non-negotiable 8-stage sequence:

---

## 0. Git Branch & Working Tree Hygiene Pre-Flight
1. **Branch Enforcement**: Releases must only be initiated on the `main` branch.
2. **Up-to-Date Sync**: Execute `git pull --rebase origin main` before bumping versions to avoid tag and push collisions.
3. **CI/CD Secrets Verification**: Verify that the required repository secrets (`PLAYSTORE_UPLOAD_KEYSTORE_BASE64`, `PLAYSTORE_KEY_PROPERTIES`, `PLAYSTORE_SERVICE_ACCOUNT_JSON`) are configured on GitHub.

---

## 1. Mandatory Regeneration Checklist
Before any release build, tagging, or push occurs, all generated files and assets must be completely regenerated:
1. **Code Generation**:
   `dart run build_runner build --delete-conflicting-outputs`
   (Updates Drift database schemas, Freezed models, Riverpod providers, JSON serialization).
2. **Native Splash Screen**:
   `dart run flutter_native_splash:create`
   (Regenerates Android 12+ and legacy splash drawables across all screen densities).
3. **App Launcher Icons**:
   `dart run flutter_launcher_icons`
   (Regenerates Android adaptive icons, iOS app icons, and platform densities).
4. **Database Integrity & Validation**:
   `dart run bin/validate_db.dart`
   (Validates SQLite pragma integrity, schema correctness, and table row consistency).
5. **Asset Inventory Audit**:
   `dart run bin/audit_assets.dart`
   (Cross-references all database image entries with assets on disk; 100% presence required).
6. **App Links Deep Linking**:
   `dart run bin/audit_app_links.dart`
   (Validates intent filters, HTTPS deep link hosts, and digital asset links).

---

## 2. Pre-Release Quality Gate & Policy Audits
All automated checks and tests must pass with zero warnings and zero failures:
1. **Strict Static Analysis**:
   `flutter analyze --fatal-infos --fatal-warnings`
2. **Google Play Store Policy & Compliance Audit**:
   `dart run bin/audit_playstore_compliance.dart` (All 36+ checks must pass).
3. **Flutter Test Suite**:
   `flutter test` (100% unit, widget, and golden tests must pass).

---

## 3. Privacy Policy & Data Safety Verification
- Verify that the privacy policy URL is reachable over HTTPS (`https://www.impulseagrisciencelimited.com/privacy-policy`).
- Audit manifest permissions and packages to ensure compliance with Google Play Data Safety declarations.
- **Strict Policy**: If any new permission (e.g. storage, location, camera, phone, contacts) or SDK dependency with data tracking is added or modified, **DO NOT GUESS OR PROCEED BLINDLY**. The AI must pause and ask the user explicitly for confirmation and privacy details before proceeding with the release.

---

## 4. Semantic Versioning, Localized Changelogs & Limits
1. Increment the version number in `pubspec.yaml` (bump patch, minor, major, or specific build version).
2. Prepend the new release section to `CHANGELOG.md`.
3. Generate localized Fastlane release notes (`metadata/android/en-US/changelogs/<versionCode>.txt` and `bn-BD/`) and ensure character count strictly complies with Google Play's **500-character limit**.

---

## 5. Git Staging, Commit & Tagging
1. Stage all modified and regenerated assets:
   `git add -A`
2. Create a conventional commit:
   `git commit -m "chore(release): bump version to vX.Y.Z (X.Y.Z+N)"`
3. Create an annotated git tag:
   `git tag -a vX.Y.Z -m "Release vX.Y.Z"`

---

## 6. Push & GitHub Actions CI/CD Execution
1. Push branch: `git push origin main`
2. Push tag: `git push origin vX.Y.Z`
3. The GitHub Actions release workflow (`.github/workflows/deploy_playstore.yml`) triggers automatically across all 5 jobs.

---

## 7. Live GitHub Actions Monitoring & Zero-Guess Error Recovery
1. AI must monitor the running workflow using GitHub CLI (`gh run watch` or `gh run list` / `gh run view`).
2. **Zero Guessing Policy**:
   - If any job fails (Quality Gate, Test Suite, Build Artifacts, Google Play Deployment, or GitHub Release), inspect the exact failed step logs using `gh run view --log-failed`.
   - Never guess the fix or apply speculative changes.
   - If the failure is due to missing Play Store credentials, secrets, or policy issues, communicate clearly with the user and provide actionable instructions.
   - Once resolved, apply fixes locally, re-run all regenerations and tests, commit, re-tag/push, and monitor until the deployment to Google Play Store and GitHub Releases succeeds completely.

---

## 8. Rollback & Abort Procedure
If a critical pre-deployment issue is discovered after tagging/pushing:
```bash
dart run bin/release.dart --abort-tag=vX.Y.Z
```
Or manually:
```bash
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```
