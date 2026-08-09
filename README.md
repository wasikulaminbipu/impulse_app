# Impulse Dex

[![Flutter](https://img.shields.io/badge/Flutter-v3.12.2%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-v3.0%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![State Management](https://img.shields.io/badge/Riverpod-State%20Management-42A5F5)](https://riverpod.dev)
[![Database](https://img.shields.io/badge/SQLite-Drift%20ORM-003B57?logo=sqlite&logoColor=white)](https://drift.simonbinder.eu/)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#license)

**Impulse Dex** is a high-performance, offline-first Flutter mobile application designed as a digital product showcase and directory for [Impulse Agriscience Ltd.](https://www.impulseagrisciencelimited.com).

It provides veterinarians, pharmacists, farmers, chemists, and pharma shop owners with rapid, offline access to detailed product catalogs (veterinary vaccines, medicines, feed additives) and a complete directory of regional sales representatives and distributors.

---

## 🌟 Key Features

- 📱 **Offline-First Engine:** Powered by on-device SQLite databases for lightning-fast querying without requiring an active internet connection.
- 🌐 **Bilingual Support (English & Bangla):** Seamless dynamic multi-language switching utilizing localized database columns (`_en` vs `_bn`).
- 💊 **Comprehensive Product Catalog:** Displays active ingredients, generic compositions, detailed indications, dosages, precautions, withdrawal periods, storage instructions, and presentations (pack sizes & MRP).
- 🤝 **Distributor Directory & Direct Dialer:** Easily find sales representatives by region, area, or designation with one-tap native phone dialer (`url_launcher`) and email actions.
- ❤️ **Favorites & Personalization:** Bookmark frequently referenced products and key distributor contacts for quick access.
- 🔍 **Advanced Search & Multi-Filter:** Instant search filtering across product names, categories, target species/groups, manufacturers, and generic compositions.
- 🏢 **Manufacturer Profiles:** View detailed manufacturer information, contact details, and filtered lists of products manufactured by each company.
- 🛠️ **Data Entry Utility:** Includes a standalone web tool (`tools/impulse-data-entry.html`) for managing SQLite database seeds and product entries.

---

## 🛠️ Architecture & Tech Stack

### Framework & State Management
- **Flutter SDK:** Cross-platform framework targeting Android & iOS.
- **Riverpod (`flutter_riverpod`, `riverpod_generator`):** Reactive, compile-safe state management architecture using code generation.
- **FlexColorScheme:** Custom high-contrast light and dark mode theming.

### Multi-Database Strategy (`drift`)
The application utilizes three separate, decoupled SQLite databases powered by the [Drift ORM](https://drift.simonbinder.eu/) (`drift`, `drift_flutter`, `sqlite3_flutter_libs`):

1. **`products.db` (Read-Only Catalog)**
   - Contains immutable catalog data: `products`, `categories`, `target_groups`, `product_target_groups`, `product_presentations`, and `manufacturers`.
   - Bundled with app releases and updated via database replacements on app updates.
2. **`distributors.db` (Read-Only Directory)**
   - Contains regional directory listings: `distributors`, designations, areas, and contact details.
   - Bundled with app releases and updated on app updates.
3. **`app_maintenance.db` (Read/Write User Database)**
   - Stores user state: `favorite_products`, `favorite_distributors`, and `app_settings` (language preference, dark mode state).
   - Preserved across app updates and re-installations.

---

## 📂 Project Structure

```
lib/
├── data/                  # Database layers, Drift schemas, & DAOs
│   ├── app_maintenance_dao.dart
│   ├── distributor_dao.dart
│   └── product_dao.dart
├── providers/             # Riverpod providers & state controllers
├── screens/               # App screens & UI view controllers
│   ├── products_screen/   # Product catalog & filter views
│   ├── product_details_screen.dart
│   ├── distributors_screen.dart
│   ├── manufacturer_details_screen.dart
│   └── settings_screen.dart
├── widgets/               # Reusable dynamic UI components & cards
└── main.dart              # App entrypoint & Navigation Shell

assets/
└── databases/             # Pre-populated SQLite database assets (.db)

tools/
└── impulse-data-entry.html # Offline Web Data Entry Tool for sqlite database generation
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.12.2 or higher recommended)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode for device deployment

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/wasikulaminbipu/impulse_dex.git
   cd impulse_dex
   ```

2. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation**
   Generate Drift DAOs and Riverpod provider code:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Launch the Application**
   ```bash
   flutter run
   ```

---

## 💻 Internal Tools & Data Management

The workspace includes a built-in interactive web utility for viewing and preparing catalog content:
- **Location:** [impulse-data-entry.html](file:///d:/App%20Development/impulse_products/impulse_dex/tools/impulse-data-entry.html)
- **Features:** Single-file HTML/JS web tool for managing product records, compositions, indications, and distributor data to generate SQLite seed files.

---

## 📋 Development Rules & Code Guidelines

- **Strict State Management:** Always use `riverpod_generator` with `@riverpod` annotations for provider definitions.
- **Database Scope Boundaries:** User settings and favorites **must strictly live in `app_maintenance.db`**. Never attempt to mutate `products.db` or `distributors.db` at runtime.
- **Dynamic UI Resilience:** Detail views must gracefully collapse or hide cards when database values are missing or null.
- **Static Analysis Compliance:** Run `flutter analyze` prior to committing changes to enforce zero lint warnings.

---

## 📄 License

Proprietary software belonging to **Impulse Agriscience Ltd.** All rights reserved.
