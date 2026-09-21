# Contributing to Impulse DEX

Thank you for contributing to Impulse DEX! We welcome contributions that maintain the high standards of performance, security, and architectural cleanliness of this application.

---

## 🛠️ Prerequisites & Environment Setup

Before starting development, ensure you have the following installed:
- **Flutter SDK**: Latest stable release (`flutter --version`)
- **Dart SDK**: `^3.13.2` (included with Flutter)
- **Java Development Kit (JDK)**: OpenJDK 17 (Eclipse Temurin recommended)
- **Android SDK**: Platform 36, Target SDK 36, Min SDK 21

### Initial Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wasikulaminbipu/impulse_app.git
   cd impulse_app
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Install Pre-commit Git Hooks**:
   ```bash
   dart run bin/setup_hooks.dart
   ```

4. **Generate Code Models (Drift, Riverpod, Freezed)**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## 📐 Development Guidelines

### Clean Architecture Boundaries
- **Core (`lib/core/`)**: Cross-cutting concerns (database connection, error handling, telemetry).
- **Data (`lib/data/`)**: SQLite tables, DAOs, FTS utilities, repository implementations.
- **Domain (`lib/domain/`)**: Pure entities, filter models, business rules.
- **Presentation (`lib/screens/`, `lib/widgets/`, `lib/theme/`)**: UI components and Riverpod providers.

### Code Formatting & Static Analysis
All code must conform to the strict static analysis rules specified in `analysis_options.yaml`.
```bash
# Format code
dart format .

# Check formatting
dart format --output=none --set-exit-if-changed .

# Run strict static analysis
flutter analyze --fatal-infos --fatal-warnings
```

### Automated Audits
Before creating a pull request, run the local audit scripts:
```bash
# Verify SQLite databases
dart run bin/validate_db.dart

# Audit asset inventory
dart run bin/audit_assets.dart

# Audit Play Store compliance
dart run bin/audit_playstore_compliance.dart

# Audit Fastlane metadata & graphics
dart run bin/audit_fastlane.dart
```

---

## 🧪 Testing Standard

All PRs must include relevant tests and maintain our test coverage threshold:
- **Minimum Test Coverage**: >= 70%
- **Target Test Coverage**: > 90%

```bash
# Run all tests with coverage
flutter test --coverage

# Generate coverage metrics badge
dart run bin/generate_coverage_badge.dart
```

---

## 📝 Commit Conventions & Pull Request Flow

We enforce the **Conventional Commits** specification:
- `feat:` A new user-facing feature
- `fix:` A bug fix
- `perf:` A code change that improves performance
- `refactor:` A code change that neither fixes a bug nor adds a feature
- `test:` Adding missing tests or correcting existing tests
- `chore:` Maintenance tasks, dependency bumps, or tool configuration
- `ci:` Changes to CI/CD workflows and deployment scripts

### Pull Request Checklist
- [ ] Code is formatted with `dart format .`
- [ ] `flutter analyze --fatal-infos --fatal-warnings` passes with zero issues
- [ ] All tests pass (`flutter test`)
- [ ] Generated files (`*.g.dart`, `*.freezed.dart`) are NOT committed to git
- [ ] PR title adheres to Conventional Commits (e.g., `fix(search): resolve BM25 ranking tie-breaker`)
