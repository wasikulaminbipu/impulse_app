---
name: github
description: Use when managing GitHub and Git operations including conventional commit formatting, pull request workflows, GitHub CLI (`gh`) usage, release tagging, and CI/CD deployment pipelines.
---

# Professional GitHub & Git Workflow Guide

This skill provides industry-standard guidelines for Git version control, GitHub interaction (including `gh` CLI commands), and automated CI/CD release triggers within this repository.

---

## 1. Branching Strategy & Naming

Always work on dedicated feature/bugfix branches rather than committing directly to `main` or `master`.

### Branch Naming Conventions
- `feature/<short-description>`: New capabilities or enhancements (e.g., `feature/dark-mode-toggle`)
- `fix/<short-description>`: Bug fixes (e.g., `fix/search-filter-debounce`)
- `refactor/<short-description>`: Code structure improvements without behavioral changes (e.g., `refactor/state-providers`)
- `chore/<short-description>`: Build configuration, dependencies, or maintenance (e.g., `chore/upgrade-flutter-deps`)
- `docs/<short-description>`: Documentation changes only (e.g., `docs/update-architecture-guide`)
- `test/<short-description>`: Adding or modifying test suites (e.g., `test/unit-search-fts-engine`)

---

## 2. Conventional Commits

Follow the **Conventional Commits** specification (`<type>(<optional scope>): <description>`).

### Rules
1. **Subject Line**: Use imperative mood ("add", "fix", "change", not "added" or "adds"). Limit to 50–72 characters.
2. **Atomic Commits**: Group logical changes into distinct commits rather than dumping multiple unrelated edits into one commit.
3. **Never Commit Secrets**: Check `git status` and `git diff` before committing to avoid leaking API keys, `.env` files, or local tokens.

### Common Commit Types
- `feat`: A new feature for the user or app
- `fix`: A bug fix for the user
- `docs`: Documentation changes
- `style`: Formatting, missing semi-colons, etc. (no code logic changes)
- `refactor`: Refactoring production code without changing behavior
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Updating build tasks, package manager configs, etc.
- `ci`: Changes to CI/CD configuration files and scripts

### Example Commit Messages
```bash
git commit -m "feat(catalog): implement instant search with FTS5 highlighting"
git commit -m "fix(contacts): sanitize phone numbers before launching WhatsApp intent"
git commit -m "chore(deps): bump riverpod to v3.3.2"
git commit -m "ci(playstore): add automated APK & AAB release deployment job"
```

---

## 3. Pull Request (PR) Standard Operating Procedure

### Pre-PR Quality Checklist
1. **Formatting**: Run `dart format --output=none --set-exit-if-changed .`.
2. **Codegen Sync**: Run `dart run build_runner build --delete-conflicting-outputs` and verify `git status --porcelain` is empty.
3. **Static Analysis & Tests**: Run `flutter analyze --fatal-infos --fatal-warnings` and `flutter test`.
4. **Compliance & Integrity Audits**:
   - `dart run bin/validate_db.dart`
   - `dart run bin/audit_assets.dart`
   - `dart run bin/audit_app_links.dart`
   - `dart run bin/audit_playstore_compliance.dart`
5. **Review Diff**: Run `git status` and `git diff main...HEAD` to verify no leftover scratch files or unwanted logs.
6. **Sync with Base Branch**:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

### Creating & Managing PRs with GitHub CLI (`gh`)
- **Create Standard PR**:
  ```bash
  gh pr create --fill
  ```
- **Create Draft PR**:
  ```bash
  gh pr create --fill --draft
  ```
- **Target Specific Base Branch**:
  ```bash
  gh pr create --base main --head feature/new-screen --title "feat(ui): add new catalog screen" --body "Implements new UI layout."
  ```
- **Inspect PR Status & CI Checks**:
  ```bash
  gh pr status
  gh pr checks
  ```
- **View PR Comments & Review Feedback**:
  ```bash
  gh pr view --comments
  ```
- **Merge Approved PR**:
  ```bash
  gh pr merge --squash --delete-branch
  ```

---

## 4. GitHub Actions CI/CD Operations & `gh` CLI Monitoring

### Real-Time Pipeline Monitoring
```bash
# List recent runs across all workflows
gh run list --limit 10

# Watch active workflow run live in terminal
gh run watch

# Inspect failed run logs immediately with zero guessing
gh run view --log-failed

# View specific run summary and artifacts
gh run view <run-id>
```

### Manual Triggering & Reruns
```bash
# Trigger Release Workflow manually with custom track
gh workflow run deploy_playstore.yml -f track=beta -f create_github_release=true

# Trigger Release Promotion workflow (e.g. Beta -> Production)
gh workflow run promote_release.yml -f from_track=beta -f to_track=production -f rollout_fraction=0.10

# Re-run only failed jobs from a run
gh run rerun <run-id> --failed
```

---

## 5. Automated Enterprise Release Protocol

Whenever initiating a release (via `dart run bin/release.dart` or agent task):

1. **Pre-Flight Branch Check**:
   ```bash
   git checkout main
   git pull --rebase origin main
   ```
2. **Execute Full Local Verification**:
   - `dart run build_runner build --delete-conflicting-outputs`
   - `dart run flutter_native_splash:create`
   - `dart run flutter_launcher_icons`
   - `dart run bin/validate_db.dart`
   - `dart run bin/audit_assets.dart`
   - `dart run bin/audit_app_links.dart`
   - `flutter analyze --fatal-infos --fatal-warnings`
   - `dart run bin/audit_playstore_compliance.dart`
   - `flutter test`
3. **Increment Version & Release Notes**:
   - Bump version in `pubspec.yaml` (e.g., `dart run bin/bump_version.dart --patch` or `--minor`).
   - Update `CHANGELOG.md` and localized Fastlane release notes (`android/fastlane/metadata/android/*/changelogs/<versionCode>.txt`).
4. **Stage, Commit & Tag**:
   ```bash
   git add -A
   git commit -m "chore(release): bump version to vX.Y.Z"
   git tag -a vX.Y.Z -m "Release vX.Y.Z"
   ```
5. **Push Branch & Tag**:
   ```bash
   git push origin main
   git push origin vX.Y.Z
   ```
6. **Live CI/CD Watch**:
   - Monitor via `gh run watch`.
   - If any job fails, inspect logs (`gh run view --log-failed`), apply fix, re-verify locally, commit, and re-push tag.

---

## 6. Git Security, Hygiene & Secret Management

1. **`.gitignore` Enforcement**: Ensure build directories (`build/`, `.dart_tool/`), credentials (`key.properties`, `pc-api-key.json`, `*.jks`, `*.p12`, `*.keystore`), and local `.env` files are never tracked.
2. **GitHub Secrets Verification**:
   - Verify secrets with `gh secret list`.
   - Ensure `PLAYSTORE_UPLOAD_KEYSTORE_BASE64`, `PLAYSTORE_KEY_PROPERTIES`, and `PLAYSTORE_SERVICE_ACCOUNT_JSON` are populated.
3. **No Force Pushes to Protected Branches**: Never force-push (`git push -f`) to `main` or `master`. Use `--force-with-lease` exclusively on personal feature branches when rebasing.
