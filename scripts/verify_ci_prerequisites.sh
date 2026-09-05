#!/usr/bin/env bash
# ==============================================================================
# Impulse DEX - Complete Local Pre-Flight CI Verification Script (Bash)
# ==============================================================================

set -eo pipefail

echo "================================================================================"
echo " 🛡️ Impulse DEX - Complete Local CI Pre-Flight Verification Gate"
echo "================================================================================"
echo ""

echo "⏳ [1/8] Validating Dart Code Formatting..."
dart format --output=none --set-exit-if-changed .

echo "⏳ [2/8] Validating SQLite Database Assets Integrity..."
dart run bin/validate_db.dart

echo "⏳ [3/8] Auditing Asset Health & Image Cross-References..."
dart run bin/audit_assets.dart

echo "⏳ [4/8] Auditing Android App Links Deep Linking..."
dart run bin/audit_app_links.dart

echo "⏳ [5/8] Validating Fastlane Store Graphic Assets & Screenshots..."
dart run bin/sync_fastlane_assets.dart

echo "⏳ [6/8] Executing Google Play Store Policy & Compliance Audit..."
dart run bin/audit_playstore_compliance.dart

echo "⏳ [7/8] Enforcing Strict Static Code Analysis..."
flutter analyze --fatal-infos --fatal-warnings

echo "⏳ [8/8] Running Automated Unit & Widget Test Suite..."
flutter test

echo ""
echo "================================================================================"
echo "🎉 ALL 8 PRE-FLIGHT QUALITY GATES PASSED!"
echo "🚀 Workspace is 100% compliant and ready for PR or release push."
echo "================================================================================"
exit 0
