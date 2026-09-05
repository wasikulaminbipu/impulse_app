#!/usr/bin/env bash
# ==============================================================================
# Impulse DEX - Pre-Flight CI/CD Verification Script
# Validates local environment, toolchains, database assets, compliance,
# and secret readiness before pushing code or creating release tags.
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================================${NC}"
echo -e "${BLUE}  🚀 [CI/CD Pre-Flight] Validating Repository & Build Readiness  ${NC}"
echo -e "${BLUE}================================================================${NC}"

# Step 1: Check Flutter and Dart Toolchains
echo -e "\n${YELLOW}[1/8] Checking Flutter & Dart Toolchains...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter SDK is not installed or not in PATH.${NC}"
    exit 1
fi
if ! command -v dart &> /dev/null; then
    echo -e "${RED}❌ Dart SDK is not installed or not in PATH.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Flutter ($(flutter --version | head -n 1)) is ready.${NC}"

# Step 2: Verify Code Formatting
echo -e "\n${YELLOW}[2/8] Checking Dart Code Formatting...${NC}"
dart format --output=none --set-exit-if-changed . || {
    echo -e "${RED}❌ Dart code formatting failed. Run 'dart format .' and commit.${NC}"
    exit 1
}
echo -e "${GREEN}✅ Dart code formatting is 100% compliant.${NC}"

# Step 3: Verify Code Generation Synchronization
echo -e "\n${YELLOW}[3/8] Verifying Freezed & Drift Code Generation Sync...${NC}"
dart run build_runner build --delete-conflicting-outputs
if [ -n "$(git status --porcelain lib/)" ]; then
    echo -e "${RED}❌ Generated files are out of sync with models! Please commit changes in lib/.${NC}"
    git status --porcelain lib/
    exit 1
fi
echo -e "${GREEN}✅ All generated models are in sync.${NC}"

# Step 4: Strict Static Analysis Gate
echo -e "\n${YELLOW}[4/8] Running Strict Static Analysis (Zero Warnings/Fatal Infos)...${NC}"
flutter analyze --fatal-infos --fatal-warnings || {
    echo -e "${RED}❌ Static analysis reported warnings or errors.${NC}"
    exit 1
}
echo -e "${GREEN}✅ Static analysis passed with zero issues.${NC}"

# Step 5: SQLite Database Integrity & Foreign Key PRAGMA
echo -e "\n${YELLOW}[5/8] Verifying SQLite Database Assets Integrity...${NC}"
dart run bin/validate_db.dart || {
    echo -e "${RED}❌ Database asset validation failed!${NC}"
    exit 1
}
echo -e "${GREEN}✅ SQLite database assets are verified.${NC}"

# Step 6: Asset Inventory & Database Image Cross-References
echo -e "\n${YELLOW}[6/8] Auditing Image Assets Cross-References...${NC}"
dart run bin/audit_assets.dart || {
    echo -e "${RED}❌ Missing image assets detected!${NC}"
    exit 1
}
echo -e "${GREEN}✅ All database images exist on disk.${NC}"

# Step 7: Android App Links & Digital Asset Links Verification
echo -e "\n${YELLOW}[7/8] Auditing Android App Links Deep Linking...${NC}"
dart run bin/audit_app_links.dart || {
    echo -e "${RED}❌ App Links verification failed!${NC}"
    exit 1
}
echo -e "${GREEN}✅ Android App Links verified.${NC}"

# Step 8: Google Play Store 36-Point Compliance Audit
echo -e "\n${YELLOW}[8/8] Executing Google Play Store Compliance Audit...${NC}"
dart run bin/audit_playstore_compliance.dart || {
    echo -e "${RED}❌ Play Store compliance audit failed!${NC}"
    exit 1
}
echo -e "${GREEN}✅ Google Play Store compliance passed 100%.${NC}"

echo -e "\n${BLUE}================================================================${NC}"
echo -e "${GREEN}  🎉 All 8 CI/CD Pre-Flight Checks PASSED Successfully!          ${NC}"
echo -e "${GREEN}  Ready for Git push, PR creation, or production release tagging. ${NC}"
echo -e "${BLUE}================================================================${NC}"
exit 0
