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
```

---

## 3. Pull Request (PR) Standard Operating Procedure

### Pre-PR Checklist
1. **Lint & Static Analysis**: Run `flutter analyze` and `flutter test` before creating or updating a PR.
2. **Review Diff**: Run `git status` and `git diff main...HEAD` to verify no leftover logs, debug prints, or unwanted scratch files.
3. **Sync with Base Branch**: Rebase or merge latest updates from `main` to ensure clean resolution:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

### Creating & Managing PRs with GitHub CLI (`gh`)
- **Create standard PR**:
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
- **View PR & CI Checks**:
  ```bash
  gh pr status
  gh pr checks
  ```

---

## 4. Release & CI/CD Deployment Trigger Workflow

Whenever a release is triggered (e.g. "push and release", "publish release", "release the app"):

1. **Increment Version**: Bump version in `pubspec.yaml` (e.g. `version: 1.0.1+2`).
2. **Commit Changes**:
   ```bash
   git add pubspec.yaml
   git commit -m "chore(release): bump version to 1.0.1+2"
   ```
3. **Create & Push Git Tag**:
   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```
4. **Push Code to Main Branch**:
   ```bash
   git push origin main
   ```
5. **Automated CI/CD Execution**:
   - The GitHub Actions workflow (`.github/workflows/deploy_playstore.yml`) triggers automatically on `v*` tag push.
   - It runs static analysis, tests, builds signed release AAB/APKs, and creates a GitHub Release.
   - If Play Store service account keys are configured, it deploys automatically to Play Store via Fastlane.

---

## 5. Git Security & Hygiene

1. **`.gitignore` Audit**: Ensure build artifacts, environment variables (`.env`), private key files (`*.pem`, `*.jks`, `*.keystore`), and user-specific IDE files are untracked.
2. **Clean Stashing**: Use `git stash push -m "descriptive message"` when switching contexts quickly.
3. **No Force Pushing to Shared Branches**: Never use `git push --force` on `main`. Use `--force-with-lease` only on feature branches when necessary.
