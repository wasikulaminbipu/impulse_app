# Project Agent Rules

This file contains project-scoped rules, architecture guidelines, and workflow constraints for AI agents working in the **impulse_dex** workspace.

## General Guidelines
- **Flutter & Dart Conventions**: Follow standard Flutter and Dart best practices. Enforce strong typing, immutability, and null safety throughout the codebase.
- **Static Analysis Gate**: Always run `flutter analyze` after completing tasks to ensure code quality and zero linting/analysis issues.
- **Clean Architecture Boundaries**: Maintain strict separation between Presentation, Domain, and Data layers (`lib/core`, `lib/features`). Avoid leaking database models directly into UI widgets.

## Always-On Skills & Behavior Rules
- **Token-Efficient Engineering**: You MUST ALWAYS apply the `token-efficient-engineering` skill on every single task, regardless of whether it was explicitly mentioned or if the task seems token-sensitive. Read its full instructions and adhere strictly.
- **Auto-Approval for Internal State Files**: Creating, updating, or modifying `.agents/project_map.json` MUST ALWAYS be executed automatically in the background. Never prompt for user permission or approval for this internal tracking file.
- **Local Database (Drift)**: Follow `drift-database` skill guidelines when modifying database schemas, DAOs, or queries. Run code generation when models/tables change.
- **Offline Database Pipeline**: Follow `offline-database-pipeline` for managing pre-populated SQLite assets (`assets/db/impulse.db`), startup copy routines, FTS5 sync, and recovery.
- **State Management (Riverpod)**: Use `riverpod-state-management` skill guidelines (Riverpod 3.x / Annotation 4.x). Prefer code generation with `@riverpod` annotations, keep state immutable, and ensure async handling uses `AsyncValue`.
- **Data Models (Freezed)**: Use `freezed-models` skill for immutable domain entities and data classes with JSON serialization (Freezed 3.x).
- **Search Engine & FTS5**: Follow `searchengine-expert` for SQLite FTS5 queries, BM25 ranking, Bengali transliteration, and indexing pipelines.
- **Native Device Integrations**: Follow `native-device-integrations` for contact management (`flutter_contacts`), vCard generation, URL schemes (`tel:`, WhatsApp `https://wa.me/`), and sharing (`share_plus`).
- **Code Generation Pipeline**: Follow `code-generation-pipeline` for running `build_runner`, configuring `build.yaml`, and managing multi-generator builds.
- **UI & Mobile Design System**: Follow `mobile-design-system` for consistent Material 3 styling, cohesive dark/light palettes, high-craft typography, and smooth micro-animations.
- **Testing Standard**: Follow `flutter-testing` guidelines to write unit, provider, and widget tests for key features.
- **Mandatory Hot Reload / Hot Restart & DTD Connection**: You MUST check and connect to the Dart Tooling Daemon (`dtd` tool: `listDtdUris` then `connect`) prior to performing hot reload or hot restart. You MUST execute at least a hot reload (or hot restart when required) after making any change in the codebase, or after completing each prompt/turn.
- **Asset Management**: Follow `asset-management` when referencing icons, images, or custom fonts.
- **Bundle Size Optimization**: Follow `flutter-size-reduction` when analyzing app bloat, R8 shrinking, and Dart AOT profiling.

## Release & CI/CD Workflow Rules
- **Release Trigger Standard**: Whenever a release is initiated (by the user asking AI to "release", "publish", "deploy", "release the app" or running `dart run bin/release.dart` in terminal), the following criteria MUST be executed sequentially and without shortcuts:
  0. **Branch & Secrets Pre-Flight**:
     - Ensure current branch is `main` and execute `git pull --rebase origin main`.
     - Verify GitHub Actions secrets (`PLAYSTORE_UPLOAD_KEYSTORE_BASE64`, `PLAYSTORE_KEY_PROPERTIES`, `PLAYSTORE_SERVICE_ACCOUNT_JSON`).
  1. **Regeneration Phase**:
     - Regenerate all code models: `dart run build_runner build --delete-conflicting-outputs`
     - Regenerate native splash screen: `dart run flutter_native_splash:create`
     - Regenerate launcher icons: `dart run flutter_launcher_icons`
     - Validate SQLite database assets: `dart run bin/validate_db.dart`
     - Audit assets inventory and cross-references: `dart run bin/audit_assets.dart`
     - Audit Android App Links deep linking: `dart run bin/audit_app_links.dart`
  2. **Comprehensive Quality & Compliance Gate**:
     - Run strict static analysis: `flutter analyze --fatal-infos --fatal-warnings`
     - Run Google Play Store publishing & policy compliance audit: `dart run bin/audit_playstore_compliance.dart` (all checks must pass)
     - Run full automated unit, widget, and golden test suite: `flutter test`
  3. **Privacy Policy & Data Safety Compatibility Check**:
     - Verify privacy policy URL accessibility and check if new permissions or SDK dependencies alter Google Play Data Safety declarations. If any incompatibility, new permission, or ambiguity exists, pause and ask the user explicitly before proceeding.
  4. **Versioning & Localized Fastlane Changelogs**:
     - Increment the version number (e.g. `version: X.Y.Z+N`) in `pubspec.yaml`.
     - Update `CHANGELOG.md` with release notes.
     - Generate localized Fastlane release notes enforcing Google Play's 500-character limit.
  5. **Staging & Git Tagging**:
     - Stage all modified and regenerated files and commit (`chore(release): bump version to vX.Y.Z`).
     - Create an annotated git tag matching the version (`git tag -a vX.Y.Z -m "Release vX.Y.Z"`).
  6. **Push & Release Trigger**:
     - Push commits to main branch (`git push origin main`).
     - Push release tag (`git push origin vX.Y.Z`).
  7. **Real-Time GitHub Actions CI/CD Monitoring & Zero-Guess Error Recovery**:
     - Automatically monitor the 5-job GitHub Actions release workflow (`quality-gate`, `test-suite`, `build-release-artifacts`, `deploy-google-play`, `publish-github-release`) using `gh run watch` or `gh run list` / `gh run view`.
     - If any CI/CD job or step fails: Inspect exact runner logs (`gh run view --log-failed`). DO NOT guess solutions or make arbitrary edits. If the issue is due to missing external credentials/secrets or policy decisions, ask the user explicitly with clear details.
     - Apply verified fixes, re-run all regenerations and tests locally, commit, push, and continue monitoring until the app is published to Google Play Store and GitHub Releases successfully.
  8. **Rollback & Abort Protocol**:
     - If an abort is needed: `dart run bin/release.dart --abort-tag=vX.Y.Z` or `git tag -d vX.Y.Z && git push origin :refs/tags/vX.Y.Z`.

## Persistent Workspace Tracking
- Keep `.agents/project_map.json` updated with module maps, file indexes, and routing references.


