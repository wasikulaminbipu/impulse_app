# App Size Budgeting & Delta Analysis in Fastlane

This guide details enforcing app size budgets, measuring install size deltas, and preventing bundle bloat in automated Fastlane CI/CD pipelines.

---

## 1. Why App Size Budgeting Matters

- **Conversion Rate Impact**: Google Play research shows that for every 6 MB increase in download size, install conversion rates drop by ~1%.
- **Download Thresholds**: Cellular networks impose warnings or limits on downloads exceeding 200 MB.
- **Low-End Devices**: High storage footprints lead to immediate uninstalls during phone storage cleanups.

---

## 2. Size Measurement Metrics

| Metric | Tool | Description | Target Budget |
|---|---|---|---|
| **AAB Upload Size** | Filesystem (`ls -lh`) | Total compressed Android App Bundle size uploaded to Google Play | < 35 MB |
| **Download Size** | `bundletool get-size total` | Bytes transferred over network to target device architecture (e.g. arm64-v8a) | < 18 MB |
| **Install Size** | `bundletool get-size total` | Uncompressed footprint on user storage after device installation | < 45 MB |
| **IPA Universal Size** | `fastlane gym` / `xcrun` | Uncompressed or compressed size of iOS IPA package | < 30 MB |

---

## 3. Fastlane Size Budget Verification Lane

Add a dedicated size verification lane to `android/fastlane/Fastfile`:

```ruby
desc "Enforce App Size Budgets on compiled AAB"
lane :check_app_size do |options|
  aab_path = options[:aab] || "../build/app/outputs/bundle/release/app-release.aab"
  max_download_mb = (options[:max_mb] || 25.0).to_f

  raise "Artifact not found at #{aab_path}" unless File.exist?(aab_path)

  # 1. Measure raw AAB size
  raw_bytes = File.size(aab_path)
  raw_mb = (raw_bytes / (1024.0 * 1024.0)).round(2)
  UI.message("Raw AAB Size: #{raw_mb} MB")

  # 2. Extract estimated download size for arm64-v8a using bundletool
  apks_path = "/tmp/app_splits.apks"
  sh("bundletool build-apks --bundle=#{aab_path} --output=#{apks_path} --mode=default")
  
  size_csv = sh("bundletool get-size total --apks=#{apks_path} --dimensions=ABI=ARM64_V8A")
  sh("rm #{apks_path}")

  # Parse min/max download bytes from CSV output
  min_bytes = size_csv.split("\n")[1].split(",")[1].to_f
  download_mb = (min_bytes / (1024.0 * 1024.0)).round(2)
  UI.message("Estimated ARM64 Download Size: #{download_mb} MB (Limit: #{max_download_mb} MB)")

  # 3. Enforce budget threshold
  if download_mb > max_download_mb
    UI.user_error!("❌ App size budget exceeded! #{download_mb} MB > #{max_download_mb} MB limit.")
  else
    UI.success("✅ App size within budget (#{download_mb} MB / #{max_download_mb} MB)")
  end
end
```

---

## 4. Size Delta Reporting to Pull Requests

Integrate size comparisons into GitHub Actions PR workflows:
1. Download baseline artifact size from `main` branch.
2. Compare with PR build artifact size.
3. Post markdown diff table as a PR comment:

```markdown
| Platform | Base (`main`) | PR Change | Delta | Status |
|---|---|---|---|---|
| Android (AAB) | 16.4 MB | 16.9 MB | +0.5 MB (+3.0%) | ⚠️ Review Required |
| iOS (IPA) | 21.2 MB | 21.3 MB | +0.1 MB (+0.4%) | ✅ OK |
```
