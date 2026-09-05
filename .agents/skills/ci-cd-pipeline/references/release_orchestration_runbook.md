# Enterprise Release Orchestration Runbook

Step-by-step operational playbook for publishing production releases, managing version lifecycles, and executing rollbacks.

---

## 1. Release Trigger Protocols

A release can be initiated via either:
1. **Automated Release CLI**: Running `dart run bin/release.dart` in terminal.
2. **AI Agent Release Request**: Asking the agent to "release the app", "publish release", or "deploy to store".

Both methods strictly execute the **8-Stage Release Publishing Pipeline**:

```
[Stage 0: Branch & Secrets Pre-Flight]
                  │
[Stage 1: Code & Asset Regeneration]
                  │
[Stage 2: Comprehensive Quality Gate (Static Analysis + Tests + Audits)]
                  │
[Stage 3: Privacy Policy & Data Safety Check]
                  │
[Stage 4: Version Bumping & Localized Changelogs]
                  │
[Stage 5: Staging & Git Tagging]
                  │
[Stage 6: Branch & Tag Push]
                  │
[Stage 7: Live CI/CD Monitoring & Zero-Guess Recovery]
```

---

## 2. Step-by-Step Execution Guide

### Stage 0: Pre-Flight Verification
```bash
# Verify clean working tree and sync with remote
git checkout main
git pull --rebase origin main

# Verify GitHub secrets are configured
gh secret list
```

### Stage 1: Regeneration Phase
```bash
# Code models
dart run build_runner build --delete-conflicting-outputs

# Native splash screen
dart run flutter_native_splash:create

# Launcher icons
dart run flutter_launcher_icons

# Database & Asset integrity
dart run bin/validate_db.dart
dart run bin/audit_assets.dart
dart run bin/audit_app_links.dart
```

### Stage 2: Quality Gate Execution
```bash
# Strict static analysis (Zero infos, zero warnings)
flutter analyze --fatal-infos --fatal-warnings

# Google Play 36-point compliance audit
dart run bin/audit_playstore_compliance.dart

# Full test suite
flutter test
```

### Stage 3: Privacy & Data Safety
- Verify privacy policy URL is reachable over HTTPS.
- Audit permission declarations in `AndroidManifest.xml`.

### Stage 4: Version Bumping & Changelogs
```bash
# Bump version (e.g. Patch bump 1.0.4+5 -> 1.0.5+6)
dart run bin/bump_version.dart --patch

# Update Fastlane screenshots/icons if changed
dart run bin/sync_fastlane_assets.dart
```

### Stage 5 & 6: Git Staging, Tagging & Push
```bash
# Stage and commit
git add -A
git commit -m "chore(release): bump version to v1.0.5"

# Create annotated tag
git tag -a v1.0.5 -m "Release v1.0.5"

# Push branch and tag simultaneously
git push origin main
git push origin v1.0.5
```

### Stage 7: Real-Time CI/CD Monitoring
```bash
# Watch the workflow execution live
gh run watch

# If any step fails, inspect exact log
gh run view --log-failed
```

---

## 3. Emergency Rollback & Abort Protocol

If a release tag was pushed prematurely or a blocking issue is identified:

### Option A: Automated Release Tool Abort
```bash
dart run bin/release.dart --abort-tag=v1.0.5
```

### Option B: Manual Tag Rollback
```bash
# Delete local tag
git tag -d v1.0.5

# Delete remote tag
git push origin :refs/tags/v1.0.5
```

### Option C: Play Store Staged Rollout Halt
1. Navigate to **Google Play Console > Releases > Production**.
2. Click **Halt Rollout** on the active staged release.
