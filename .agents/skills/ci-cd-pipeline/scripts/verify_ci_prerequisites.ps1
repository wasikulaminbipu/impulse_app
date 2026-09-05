# ==============================================================================
# Impulse DEX - Pre-Flight CI/CD Verification Script (PowerShell)
# Validates local environment, toolchains, database assets, compliance,
# and secret readiness before pushing code or creating release tags.
# ==============================================================================

$ErrorActionPreference = "Stop"

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "  🚀 [CI/CD Pre-Flight] Validating Repository & Build Readiness  " -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

# Step 1: Check Flutter and Dart Toolchains
Write-Host "`n[1/8] Checking Flutter & Dart Toolchains..." -ForegroundColor Yellow
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Flutter SDK is not installed or not in PATH." -ForegroundColor Red
    exit 1
}
if (-not (Get-Command dart -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Dart SDK is not installed or not in PATH." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Flutter & Dart toolchains are ready." -ForegroundColor Green

# Step 2: Verify Code Formatting
Write-Host "`n[2/8] Checking Dart Code Formatting..." -ForegroundColor Yellow
dart format --output=none --set-exit-if-changed .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Dart code formatting failed. Run 'dart format .' and commit." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dart code formatting is 100% compliant." -ForegroundColor Green

# Step 3: Verify Code Generation Synchronization
Write-Host "`n[3/8] Verifying Freezed & Drift Code Generation Sync..." -ForegroundColor Yellow
dart run build_runner build --delete-conflicting-outputs
$gitStatus = git status --porcelain lib/
if ($gitStatus) {
    Write-Host "❌ Generated files are out of sync with models! Please commit changes in lib/." -ForegroundColor Red
    exit 1
}
Write-Host "✅ All generated models are in sync." -ForegroundColor Green

# Step 4: Strict Static Analysis Gate
Write-Host "`n[4/8] Running Strict Static Analysis (Zero Warnings/Fatal Infos)..." -ForegroundColor Yellow
flutter analyze --fatal-infos --fatal-warnings
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Static analysis reported warnings or errors." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Static analysis passed with zero issues." -ForegroundColor Green

# Step 5: SQLite Database Integrity & Foreign Key PRAGMA
Write-Host "`n[5/8] Verifying SQLite Database Assets Integrity..." -ForegroundColor Yellow
dart run bin/validate_db.dart
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Database asset validation failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ SQLite database assets are verified." -ForegroundColor Green

# Step 6: Asset Inventory & Database Image Cross-References
Write-Host "`n[6/8] Auditing Image Assets Cross-References..." -ForegroundColor Yellow
dart run bin/audit_assets.dart
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Missing image assets detected!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ All database images exist on disk." -ForegroundColor Green

# Step 7: Android App Links & Digital Asset Links Verification
Write-Host "`n[7/8] Auditing Android App Links Deep Linking..." -ForegroundColor Yellow
dart run bin/audit_app_links.dart
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ App Links verification failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Android App Links verified." -ForegroundColor Green

# Step 8: Google Play Store 36-Point Compliance Audit
Write-Host "`n[8/8] Executing Google Play Store Compliance Audit..." -ForegroundColor Yellow
dart run bin/audit_playstore_compliance.dart
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Play Store compliance audit failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Google Play Store compliance passed 100%." -ForegroundColor Green

Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host "  🎉 All 8 CI/CD Pre-Flight Checks PASSED Successfully!          " -ForegroundColor Green
Write-Host "  Ready for Git push, PR creation, or production release tagging. " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
exit 0
