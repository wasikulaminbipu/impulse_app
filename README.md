# Impulse DEX

[![Build & Deploy to Google Play](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/deploy_playstore.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/deploy_playstore.yml)
[![PR Quality Gate](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/pr_ci.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/pr_ci.yml)
[![Weekly Maintenance](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/weekly_maintenance.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/weekly_maintenance.yml)
[![Coverage](badges/coverage.svg)](#-automated-testing--quality-gates)
[![Flutter](https://img.shields.io/badge/Flutter-v3.29%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-v3.12%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android%20Target%20SDK-36%20(Android%2016)-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![State Management](https://img.shields.io/badge/Riverpod-v3.3%20%2F%20Codegen%20v4.0-42A5F5?logo=flutter&logoColor=white)](https://riverpod.dev)
[![Database](https://img.shields.io/badge/SQLite-Drift%20ORM%20v2.34-003B57?logo=sqlite&logoColor=white)](https://drift.simonbinder.eu/)
[![Models](https://img.shields.io/badge/Freezed-v3.2%20Immutable-blue)](https://pub.dev/packages/freezed)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#-license)

**Impulse DEX** is an enterprise-grade, offline-first Flutter mobile application engineered as a digital product showcase, veterinary pharmaceutical reference, and nationwide sales directory for [Impulse Agriscience Ltd.](https://www.impulseagrisciencelimited.com).

It delivers instantaneous, zero-latency access to comprehensive veterinary catalogs (vaccines, therapeutics, and nutritional feed additives) and a complete directory of regional sales representatives and distributors across all divisions and districts in Bangladesh.

---

## 🌟 Key Features

- 📱 **Offline-First Multi-DB Engine:** Powered by isolated, pre-populated SQLite databases on-device with zero network latency or connectivity requirement.
- 🌐 **Bilingual Support (English & বাংলা):** Instant runtime language toggle with localized database columns (`_en` vs `_bn`) and typography tailored for Bangla script.
- 💊 **Detailed Pharmaceutical Catalog:** Rapid lookup for active ingredients, generic formulations, indications, dosages, withdrawal periods, storage directives, pack sizes, and MRP.
- 🤝 **Distributor Directory & Native Integrations:**
  - One-tap phone dialer (`tel:` URL scheme).
  - Direct WhatsApp conversation launcher (`https://wa.me/`).
  - Native contact export directly into device address book (`flutter_contacts` / vCard).
  - Branded product card screenshot and intent sharing (`share_plus`).
- ❤️ **Personalization & Bookmarks:** Offline persistence of favorite products and frequently contacted sales personnel.
- 🔍 **Instant Full-Text Search (FTS5 BM25):** Fast prefix matching, tokenized search, and phonetic transliteration across product titles, generic compositions, manufacturers, and animal species.
- 🎨 **Adaptive Material 3 Design System:** Seamless light and OLED-ready dark modes, high-contrast typography, tactile card components, and fluid micro-animations.
- 🛡️ **Enterprise Error Boundaries & Fallbacks:** Global exception handlers and localized fallback cards that prevent crashes and ensure graceful recovery.

---

## 🛠️ Architecture & Tech Stack

The application strictly adheres to Clean Architecture separation of concerns:

```
UI (Widgets & Screens) ──► Riverpod Notifiers ──► DAOs (Drift ORM) ──► SQLite Databases
```

### Core Technologies
- **Flutter SDK:** Targeting Android (API 21 through 36, Android 16 ready) & iOS.
- **Riverpod (`flutter_riverpod` 3.x, `riverpod_annotation` 4.x):** Code-generated reactive state management with strict immutability.
- **Freezed (`freezed` 3.x):** Immutable domain entities, union types, and compile-safe JSON serialization.
- **Drift (`drift` 2.34.x, `sqlite3_flutter_libs`):** Type-safe Dart ORM with SQL schema generation, reactive streams, and custom query builders.

### Decoupled Multi-Database Architecture

| Database | Access Mode | Description |
| :--- | :--- | :--- |
| **`products.db`** | Read-Only | Immutable product catalog: categories, species, compositions, indications, dosages, presentations, precautions, and manufacturers. |
| **`distributors.db`** | Read-Only | Regional hierarchy and personnel directory: sales personnel, distributors, divisions, districts, upazilas, and area bases. |
| **`app_maintenance.db`** | Read/Write | Persistent user data: favorites, search history, language selections, and theme preferences. Preserved across updates. |

---

## 📂 Project Structure

```
impulse_dex/
├── lib/
│   ├── core/                  # Error handling, error boundaries, telemetry & constants
│   ├── data/                  # Drift database schemas, database instances, and DAOs
│   │   ├── app_maintenance_dao.dart
│   │   ├── distributor_dao.dart
│   │   ├── product_dao.dart
│   │   └── lookup_dao.dart
│   ├── models/                # Freezed immutable domain models & entities
│   ├── providers/             # Riverpod providers, controllers, and search filters
│   ├── screens/               # Screen widgets & page view controllers
│   │   ├── products_screen.dart
│   │   ├── product_details_screen.dart
│   │   ├── distributors_screen.dart
│   │   ├── sales_personnels_screen.dart
│   │   ├── manufacturers_screen.dart
│   │   └── about_us_screen.dart
│   ├── theme/                 # Material 3 design system, color palettes, and typography
│   ├── utils/                 # Native sharing, URL launcher, and contact managers
│   ├── widgets/               # Reusable atomic UI components, cards, and skeletons
│   └── main.dart              # Application bootstrap & ProviderScope initialization
│
├── test/                      # Comprehensive test suite (170+ automated tests)
│   ├── data/                  # In-memory DAO unit tests (Drift SQLite)
│   ├── models/                # Domain entity and Freezed serialization tests
│   ├── providers/             # Riverpod state management & controller tests
│   ├── screens/               # Widget interaction & navigation screen tests
│   ├── theme/                 # AppTheme & color scheme validation tests
│   ├── utils/                 # Share service & URL utility tests
│   └── widgets/               # UI component & error boundary widget tests
│
├── assets/
│   ├── db/                    # Pre-populated SQLite database assets (.db)
│   ├── icons/                 # High-resolution vector icons and SVG assets
│   └── images/                # Product packaging and brand imagery
│
├── bin/                       # Enterprise CLI automation & release tooling
│   ├── release.dart                   # 8-stage automated/interactive release pipeline
│   ├── bump_version.dart              # SemVer version manager and changelog syncer
│   ├── validate_db.dart               # Automated SQLite schema & foreign-key validator
│   ├── audit_assets.dart              # Asset inventory, bloat & DB image cross-auditor
│   ├── audit_app_links.dart           # Android App Links & Digital Asset Links validator
│   ├── audit_playstore_compliance.dart # Google Play Store 39-check policy & SDK auditor
│   ├── audit_unused_code.dart         # Codebase hygiene & dead code auditor
│   ├── sync_fastlane_assets.dart      # Fastlane icon, feature graphic & screenshot sync
│   ├── generate_coverage_badge.dart   # High-signal coverage calculator & SVG badge updater
│   └── setup_hooks.dart               # Cross-platform Git pre-commit/pre-push installer
│
├── scripts/
│   ├── verify_ci_prerequisites.ps1    # One-command pre-flight verification (PowerShell)
│   └── verify_ci_prerequisites.sh     # One-command pre-flight verification (Bash)
│
└── tools/
    └── impulse-data-entry.html        # Offline web data entry tool for catalog databases
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.29.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>= 3.12.2`)
- Android Studio / VS Code with Flutter & Dart extensions
- Android SDK Platform 36 & Build-Tools

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/wasikulaminbipu/impulse_app.git
   cd impulse_app
   ```

2. **Configure Git Quality Hooks**
   ```bash
   dart run bin/setup_hooks.dart
   ```

3. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

4. **Validate SQLite Database Assets**
   ```bash
   dart run bin/validate_db.dart
   ```

5. **Run Code Generation**
   Generate Drift DAOs, Riverpod providers, and Freezed models:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

6. **Run Local Quality Pre-Flight**
   Verify all static analysis, tests, compliance checks, and coverage gates:
   ```powershell
   # Windows (PowerShell)
   powershell -ExecutionPolicy Bypass -File scripts/verify_ci_prerequisites.ps1

   # macOS / Linux (Bash)
   ./scripts/verify_ci_prerequisites.sh
   ```

7. **Launch the Application**
   ```bash
   flutter run
   ```

---

## 🧪 Automated Testing & Quality Gates

The codebase enforces strict quality gates backed by an automated test suite across all layers:

- **170+ Automated Tests:** Unit tests for Drift DAOs with in-memory SQLite, Riverpod provider state machines, Freezed models, error boundaries, and full widget interaction tests.
- **Coverage Quality Gate (>= 70%):** Enforces high-signal test coverage (excluding generated `*.g.dart` and `*.freezed.dart` files) tracked dynamically in `badges/coverage.svg`:
  ```bash
  flutter test --coverage
  dart run bin/generate_coverage_badge.dart --min-coverage=70.0
  ```
- **Strict Static Analysis:** Zero warnings and zero infos required:
  ```bash
  flutter analyze --fatal-infos --fatal-warnings
  ```
- **Play Store Compliance Auditor:** Automated 39-check audit validating Target SDK 36, 16KB page alignment, Android 12+ splash screen, ProGuard/R8 de-obfuscation rules, and store metadata character limits:
  ```bash
  dart run bin/audit_playstore_compliance.dart
  ```

---

## 🔄 CI/CD & Enterprise Release Workflows

The repository uses GitHub Actions for continuous delivery to the Google Play Console:

- **🚀 Google Play Release Pipeline (`deploy_playstore.yml`)**: Triggered by pushing an annotated release tag (e.g., `v1.0.4`). Executes a 5-stage pipeline:
  1. `quality-gate`: Code formatting, strict static analysis, and compliance audit.
  2. `test-suite`: Complete test execution with coverage enforcement.
  3. `build-release-artifacts`: Clean Gradle compilation of release Android App Bundle (AAB) and Universal/Split APKs signed with Play Store keystore.
  4. `deploy-google-play`: Automated distribution to Google Play internal/closed testing tracks via Fastlane Supply.
  5. `publish-github-release`: Publishes GitHub Release with checksums and downloadable APK artifacts.
- **🛡️ PR Quality Gate (`pr_ci.yml`)**: Runs on pull requests to ensure formatting, zero analysis warnings, passing test suite, and clean compilation.
- **⚡ Release Promotion (`promote_release.yml`)**: Seamlessly promotes existing builds between Play Store tracks (e.g. Internal ➔ Alpha ➔ Beta ➔ Production) with staged rollout percentages.
- **🏥 Weekly Maintenance (`weekly_maintenance.yml`)**: Scheduled weekly maintenance auditing dependencies, security advisories, and toolchain compatibility.
- **🔒 Zero-Cache CI Policy:** CI/CD runners enforce fresh, clean dependency resolution and compilation to eliminate cache poisoning and build discrepancies.

---

## 📄 License

Proprietary software belonging to **Impulse Agriscience Ltd.** All rights reserved.

