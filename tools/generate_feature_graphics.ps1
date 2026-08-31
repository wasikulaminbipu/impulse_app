Add-Type -AssemblyName System.Drawing

$sourceImages = @{
    "dark" = "C:\Users\User\.gemini\antigravity-ide\brain\90994f87-e6eb-4f8b-81e7-f98ce8c55d86\feature_graphic_dark_1788151980760.jpg"
    "biotech" = "C:\Users\User\.gemini\antigravity-ide\brain\90994f87-e6eb-4f8b-81e7-f98ce8c55d86\feature_graphic_biotech_1788152012250.jpg"
    "clean" = "C:\Users\User\.gemini\antigravity-ide\brain\90994f87-e6eb-4f8b-81e7-f98ce8c55d86\feature_graphic_clean_1788151997633.jpg"
}

function Save-FeatureGraphic($sourcePath, $outputPaths) {
    if (-not (Test-Path $sourcePath)) {
        Write-Error "Source file not found: $sourcePath"
        return
    }
    $src = [System.Drawing.Image]::FromFile($sourcePath)
    $dest = New-Object System.Drawing.Bitmap(1024, 500)
    $gfx = [System.Drawing.Graphics]::FromImage($dest)
    $gfx.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gfx.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $gfx.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    $gfx.DrawImage($src, 0, 0, 1024, 500)
    $gfx.Dispose()
    $src.Dispose()

    foreach ($outPath in $outputPaths) {
        $parent = Split-Path -Parent $outPath
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        $dest.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $lenKb = [math]::Round(((Get-Item $outPath).Length / 1KB), 1)
        Write-Host "Exported: $outPath ($lenKb KB)"
    }
    $dest.Dispose()
}

# 1. Primary Feature Graphic for Fastlane (Dark Theme - Official Play Store standard 1024x500 PNG)
$primaryOutputs = @(
    "d:\App Development\impulse_products\impulse_dex\android\fastlane\metadata\android\en-US\images\featureGraphic.png",
    "d:\App Development\impulse_products\impulse_dex\android\fastlane\metadata\android\bn-BD\images\featureGraphic.png",
    "d:\App Development\impulse_products\impulse_dex\assets\images\feature_graphic.png"
)
Save-FeatureGraphic $sourceImages["dark"] $primaryOutputs

# 2. Also save all high-res variants in assets/images/
Save-FeatureGraphic $sourceImages["biotech"] @("d:\App Development\impulse_products\impulse_dex\assets\images\feature_graphic_biotech.png")
Save-FeatureGraphic $sourceImages["clean"] @("d:\App Development\impulse_products\impulse_dex\assets\images\feature_graphic_clean.png")

Write-Host "All feature graphics processed and saved successfully!"
