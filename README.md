# Impulse DEX

[![Build & Deploy to Google Play](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/deploy_playstore.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/deploy_playstore.yml)
[![PR Quality Gate](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/pr_ci.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/pr_ci.yml)
[![Weekly Maintenance](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/weekly_maintenance.yml/badge.svg)](https://github.com/wasikulaminbipu/impulse_app/actions/workflows/weekly_maintenance.yml)
[![Coverage](badges/coverage.svg)](#)
[![Flutter](https://img.shields.io/badge/Flutter-v3.12%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-v3.0%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android%20Target%20SDK-35%20(Android%2015)-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![State Management](https://img.shields.io/badge/Riverpod-State%20Management-42A5F5)](https://riverpod.dev)
[![Database](https://img.shields.io/badge/SQLite-Drift%20ORM-003B57?logo=sqlite&logoColor=white)](https://drift.simonbinder.eu/)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#license)

**Impulse DEX** is a high-performance, offline-first Flutter mobile application designed as a digital product showcase, veterinary pharmaceutical reference, and sales directory for [Impulse Agriscience Ltd.](https://www.impulseagrisciencelimited.com).

It provides veterinarians, pharmacists, farmers, chemists, and pharma shop owners with rapid, offline access to detailed product catalogs (veterinary vaccines, medicines, feed additives) and a complete directory of regional sales representatives and distributors across Bangladesh.

---

## 🌟 Key Features

- 📱 **Offline-First Engine:** Powered by pre-populated, on-device SQLite databases for lightning-fast querying with zero network dependency.
- 🌐 **Bilingual Support (English & Bangla):** Seamless dynamic multi-language switching utilizing localized database columns (`_en` vs `_bn`).
- 💊 **Comprehensive Product Catalog:** Displays active ingredients, generic compositions, detailed indications, dosages, precautions, withdrawal periods, storage instructions, and presentations (pack sizes & MRP).
- 🤝 **Distributor Directory & Direct Dialer:** Easily find sales representatives by region, area, or designation with one-tap native phone dialer (`url_launcher`), WhatsApp messaging, and contact saving (`flutter_contacts`).
- ❤️ **Favorites & Personalization:** Bookmark frequently referenced products and key distributor contacts for instant access.
- 🔍 **Advanced Search & Multi-Filter:** Instant full-text search (FTS5 BM25) and filter across product names, categories, target species/groups, manufacturers, and generic compositions.
- 🏢 **Manufacturer Profiles:** View detailed manufacturer information, company history, and filtered lists of products manufactured by each partner.
- 🛠️ **Data Entry & Validation Utilities:** Includes standalone validation tools (`bin/validate_db.dart`) and web editors (`tools/impulse-data-entry.html`) for managing SQLite catalog databases.

---

## 🛠️ Architecture & Tech Stack

### Framework & State Management
- **Flutter SDK:** Cross-platform framework targeting Android (API 21 to 35) & iOS.
- **Riverpod (`flutter_riverpod`, `riverpod_annotation`):** Compile-safe, reactive state management using code generation.
- **Freezed (`freezed`, `freezed_annotation`):** Immutable data models with JSON serialization.

### Multi-Database Strategy (`drift`)
The application utilizes three separate, decoupled SQLite databases powered by the [Drift ORM](https://drift.simonbinder.eu/) (`drift`, `drift_flutter`, `sqlite3_flutter_libs`):

1. **`products.db` (Read-Only Catalog)**
   - Immutable product catalog: `products`, `categories`, `target_groups`, `species`, `dosage_units`, `compositions`, `indications`, `directions`, `precautions`, `presentations`, and `manufacturers`.
2. **`distributors.db` (Read-Only Directory)**
   - Regional hierarchy and directory: `sales_personnel`, `distributors`, `divisions`, `districts`, `upazilas`, `regions`, `areas`, and `bases`.
3. **`app_maintenance.db` (Read/Write User Database)**
   - User state: `favorite_products`, `favorite_distributors`, and `app_settings` (language preference, dark mode state).
   - Preserved across app updates and re-installations.

---

## 📂 Project Structure

```
lib/
├── core/                  # Global errors, error boundaries, and telemetry
├── data/                  # Database layers, Drift schemas, & DAOs
│   ├── app_maintenance_dao.dart
│   ├── distributor_dao.dart
│   ├── product_dao.dart
│   └── lookup_dao.dart
├── models/                # Freezed immutable data entities & models
├── providers/             # Riverpod providers & state controllers
├── screens/               # App screens & UI view controllers
│   ├── products_screen.dart
│   ├── product_details_screen.dart
│   ├── distributors_screen.dart
│   ├── sales_personnels_screen.dart
│   ├── manufacturers_screen.dart
│   └── about_us_screen.dart
├── theme/                 # App design system tokens & themes
├── utils/                 # Native sharing, URL schemes, and analytics
├── widgets/               # Reusable dynamic UI components & cards
└── main.dart              # App entrypoint & Navigation Shell

assets/
└── db/                    # Pre-populated SQLite database assets (.db)

bin/
├── release.dart                   # Enterprise 8-stage interactive/automated release engine
├── bump_version.dart              # SemVer version bump and changelog synchronization
├── validate_db.dart               # Automated SQLite integrity & schema validator
├── audit_assets.dart              # Asset inventory, bloat & DB image cross-reference auditor
├── audit_app_links.dart           # Android App Links & Digital Asset Links validator
├── audit_playstore_compliance.dart # Google Play Store 42-check compliance & SDK auditor
├── audit_unused_code.dart         # Codebase hygiene & dead code auditor
├── sync_fastlane_assets.dart      # Fastlane icon, feature graphic & screenshot validator
├── generate_coverage_badge.dart   # High-signal coverage calculator & SVG badge generator
├── setup_hooks.dart               # Cross-platform Git hooks configuration utility
└── seed_employee_list.dart        # Directory database seeding script

scripts/
├── verify_ci_prerequisites.ps1    # One-command pre-flight verification (PowerShell)
└── verify_ci_prerequisites.sh     # One-command pre-flight verification (Bash)

tools/
└── impulse-data-entry.html        # Offline Web Data Entry Tool for sqlite database generation
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.12 or higher recommended)
- [Dart SDK](https://dart.dev/get-dart) (v3.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/wasikulaminbipu/impulse_app.git
   cd impulse_app
   ```

2. **Configure Git Hooks**
   ```bash
   dart run bin/setup_hooks.dart
   ```

3. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

4. **Validate Database Assets**
   ```bash
   dart run bin/validate_db.dart
   ```

5. **Run Code Generation**
   Generate Drift DAOs and Riverpod provider code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

6. **Run Local Pre-Flight CI Verification**
   Run all 8 quality gates locally with one command:
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

## 🔄 CI/CD & Release Workflows

The repository includes a complete GitHub Actions automation suite:

- **🚀 Google Play Release Pipeline (`deploy_playstore.yml`)**: Triggered by pushing a version tag (e.g. `v1.0.0`). Runs 5 gated jobs: Quality Gate -> Test Suite -> Release Artifacts Compilation (AAB + Split APKs) -> Fastlane Play Store Deployment -> GitHub Release Publishing.
- **🛡️ PR Quality Gate (`pr_ci.yml`)**: Triggered on pull requests. Runs formatting, static analysis, test suite, release compilation check, and posts a sticky status comment directly to the PR.
- **⚡ Release Promotion (`promote_release.yml`)**: Promotes existing builds between tracks (e.g. Beta to Production) with staged rollout fractions in seconds.
- **🏥 Weekly Maintenance (`weekly_maintenance.yml`)**: Scheduled weekly health check auditing dependencies, deprecations, and build health.

---

## 📄 License

Proprietary software belonging to **Impulse Agriscience Ltd.** All rights reserved.
