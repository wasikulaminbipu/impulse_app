# Comprehensive App Quality Improvement Design

**Date**: 2026-09-20  
**Status**: Draft (Approved via Grill-Me Rounds 1 & 2)  
**Target Coverage**: >85% High-Signal Test Coverage  
**Compliance Standard**: Google Play Android 15/16 (Target SDK 36), Material 3 Expressive, Zero-Tolerance Modernity

---

## 1. Overview & Objectives

This design outlines the end-to-end quality enhancement of the **Impulse DEX** Flutter application across four interconnected dimensions:
1. **Baseline Stabilization**: Formalize, test, and commit pending security workflows, repository health assets, database recovery routines, and error-handling utilities.
2. **Dependency Modernization**: Upgrade direct (`pdf`, `freezed`) and transitive dependencies to their latest stable releases, executing fresh code generation and static analysis.
3. **UI/UX, Tactile Polish & Accessibility**: Implement subtle haptic feedback on interactive controls, enhance Material 3 expressive transitions, and enforce comprehensive `Semantics` tags for screen readers across English and Bengali.
4. **Test Hardening & Coverage Elevation**: Elevate high-signal test coverage from 80.6% to >85–90% with targeted unit, provider, and widget tests.

---

## 2. Architecture & Design Decisions

### 2.1 Asset & Font Strategy
- **Offline Integrity**: Retain full offline TTF weights for the Inter font family (Bold, ExtraBold, Medium, Regular, SemiBold) to guarantee 100% offline glyph rendering across all Unicode scripts.

### 2.2 Tactile & Haptic System
- Integrate `HapticFeedback.lightImpact()` and `HapticFeedback.selectionClick()` conditionally on mobile platforms (Android/iOS) via safe platform checks.
- Wire haptics into:
  - `TactileButton` and `FavoriteButton` state changes
  - Search filter chip selections and scope switching
  - Bottom navigation bar tab switching

### 2.3 Accessibility (a11y) & Semantics
- Ensure every interactive element has explicit `Semantics`:
  - `FavoriteButton`: labels state ("Add to favorites" vs "Remove from favorites")
  - `ProductCard`: provides contextual summary for screen readers
  - `SearchBar`: hints on clear action and microphone/search submission
  - Bengali localization support for accessibility labels

### 2.4 Test Suite & Quality Gate
- Maintain zero failing tests across unit, golden, and widget tests.
- Identify untested branches in `lib/data/` DAOs, `lib/providers/`, and `lib/widgets/`.
- Verify coverage exceeds 85% via `bin/generate_coverage_badge.dart`.

---

## 3. Phased Execution Plan

- **Phase 0 (Baseline)**: Verify and stabilize uncommitted files (security workflows, XML backup configs, error handler tests, recovery tests).
- **Phase 1 (Dependencies)**: Bump `pubspec.yaml` versions (`pdf: ^3.13.1`, `freezed: ^4.0.2`), run `flutter pub upgrade`, regenerate models (`build_runner`), verify `flutter analyze`.
- **Phase 2 (UI/UX & Semantics)**: Apply tactile feedback, micro-animation improvements, and screen-reader semantics to widgets and navigation.
- **Phase 3 (Coverage Elevation)**: Write new unit/widget tests for uncovered edge cases, running `flutter test --coverage`.
- **Phase 4 (Audits & Sign-off)**: Run the full compliance suite (`audit_playstore_compliance.dart`, `audit_fastlane.dart`, `validate_db.dart`, `audit_assets.dart`), update `.agents/project_map.json`, and refresh knowledge graph (`graphify update .`).
