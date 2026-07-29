# Impulse Dex

A robust, high-performance Flutter mobile application designed as a digital showcase and comprehensive directory for Impulse Agriscience Ltd.

## Overview
**Impulse Dex** serves as an offline-first, dynamic catalog for veterinary vaccines, medicines, feed additives, and a directory of distributors. It is tailored for veterinarians, pharmacists, farmers, chemists, and pharma shop owners, providing rapid access to critical product information without requiring an active internet connection.

**Organization:** [Impulse Agriscience Ltd.](https://www.impulseagrisciencelimited.com)

## Key Features
- **Offline-First Catalog:** Fast, on-device SQLite databases containing thousands of products and distributor details.
- **Bilingual Support:** Full English and Bengali (Bangla) localization, driven by local SQLite tables.
- **Favorites & Personalization:** Bookmark frequently accessed products and preferred sales personnel.
- **Advanced Search & Filtering:** Instant search filtering by name, category, target group, region, and generic compositions.
- **Direct Communication:** Built-in dialer integration to quickly contact distributors or manufacturers from within the app.
- **Modern UI/UX:** Clean, high-contrast dark and light mode support with intuitive navigation.

## Architecture & Tech Stack
- **Framework:** [Flutter](https://flutter.dev) (Supports Android & iOS)
- **State Management:** Riverpod (`flutter_riverpod`, `riverpod_generator`)
- **Local Database:** Drift ORM (`drift`, `drift_flutter`, `sqlite3`) utilizing 3 distinct databases:
  1. `products.db`: Read-only catalog of products, categories, manufacturers, etc.
  2. `distributors.db`: Read-only directory of regional sales representatives.
  3. `app_maintenance.db`: Read/Write user database handling favorites and settings.
- **UI Components:** Custom dynamic section cards, `SliverAppBar`, and `FlexColorScheme` integration.

## Getting Started

### Prerequisites
- Flutter SDK (v3.12.2 or higher recommended)
- Dart SDK
- Android Studio / Xcode for platform-specific builds

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd impulse_products
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Code Generation (Drift & Riverpod)**
   This project relies on code generation for State Management and Database DAOs. Run the build runner to generate the necessary `.g.dart` files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## Project Structure
- `lib/data/` - Database configurations, Drift schemas, and DAOs.
- `lib/screens/` - UI Screens (Products, Distributors, Details, Settings).
- `lib/widgets/` - Reusable UI components and widgets.
- `lib/providers/` - Riverpod providers and state controllers.
- `assets/` - Static assets including images, icons, and pre-populated SQLite database files.

## Development Guidelines
- **State Management:** Strict usage of `riverpod_generator` with `@riverpod` annotations.
- **UI Resilience:** Dynamically hide section cards when backing data is missing/empty.
- **Data Safety:** User data (Favorites/Settings) MUST ONLY live in `app_maintenance.db`. Do not attempt to write user state into the bundled read-only databases.
- **Localization:** Toggled via language settings, querying `_en` or `_bn` columns from SQLite dynamically.

## License
Proprietary software belonging to Impulse Agriscience Ltd. All rights reserved.
