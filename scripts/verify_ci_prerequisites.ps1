<#
.SYNOPSIS
    Impulse DEX - Complete Local Pre-Flight CI Verification Script (PowerShell)
.DESCRIPTION
    Executes the comprehensive 8-stage pre-flight quality and compliance gate
    locally before pushing to remote branches or opening pull requests.
#>

$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host " 🛡️ Impulse DEX - Complete Local CI Pre-Flight Verification Gate" -ForegroundColor Cyan
Write-Host "================================================================================`n" -ForegroundColor Cyan

$stages = @(
    @{ Name = "1. Dart Code Formatting"; Cmd = "dart"; Args = @("format", "--output=none", "--set-exit-if-changed", ".") },
    @{ Name = "2. SQLite Database Assets Integrity"; Cmd = "dart"; Args = @("run", "bin/validate_db.dart") },
    @{ Name = "3. Asset Health & Image Cross-References"; Cmd = "dart"; Args = @("run", "bin/audit_assets.dart") },
    @{ Name = "4. Android App Links & Digital Asset Links"; Cmd = "dart"; Args = @("run", "bin/audit_app_links.dart") },
    @{ Name = "5. Fastlane Store Graphic Assets & Screenshots"; Cmd = "dart"; Args = @("run", "bin/sync_fastlane_assets.dart") },
    @{ Name = "6. Google Play Store Policy & Compliance Audit"; Cmd = "dart"; Args = @("run", "bin/audit_playstore_compliance.dart") },
    @{ Name = "7. Strict Static Code Analysis"; Cmd = "flutter"; Args = @("analyze", "--fatal-infos", "--fatal-warnings") },
    @{ Name = "8. Full Unit & Widget Test Suite"; Cmd = "flutter"; Args = @("test") }
)

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$failed = $false

foreach ($stage in $stages) {
    Write-Host "⏳ Running Stage: $($stage.Name)... " -NoNewline -ForegroundColor Yellow
    $stageStopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    try {
        & $stage.Cmd $stage.Args | Out-Null
        $stageStopwatch.Stop()
        Write-Host "✅ PASSED ($($stageStopwatch.Elapsed.TotalSeconds.ToString('F1'))s)" -ForegroundColor Green
    }
    catch {
        $stageStopwatch.Stop()
        Write-Host "❌ FAILED ($($stageStopwatch.Elapsed.TotalSeconds.ToString('F1'))s)" -ForegroundColor Red
        Write-Host "`n💥 Failure in $($stage.Name)! Re-running with output to inspect failure details:`n" -ForegroundColor Red
        & $stage.Cmd $stage.Args
        $failed = $true
        break
    }
}

$stopwatch.Stop()

Write-Host "`n================================================================================" -ForegroundColor Cyan
if ($failed) {
    Write-Host "❌ PRE-FLIGHT QUALITY GATE FAILED after $($stopwatch.Elapsed.TotalSeconds.ToString('F1'))s." -ForegroundColor Red
    Write-Host "   Please resolve the reported issue before committing or pushing." -ForegroundColor Red
    Write-Host "================================================================================`n" -ForegroundColor Cyan
    exit 1
} else {
    Write-Host "🎉 ALL 8 PRE-FLIGHT QUALITY GATES PASSED! ($($stopwatch.Elapsed.TotalSeconds.ToString('F1'))s)" -ForegroundColor Green
    Write-Host "🚀 Workspace is 100% compliant and ready for PR or release push." -ForegroundColor Green
    Write-Host "================================================================================`n" -ForegroundColor Cyan
    exit 0
}
