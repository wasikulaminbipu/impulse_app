# Monorepo & Multi-App Fastlane Architecture Guide

This guide details managing multiple Flutter applications, packages, and white-label distributions from a single Git monorepo using shared Fastlane configurations.

---

## 1. Sharing Common Lanes Across Apps (`import` / `import_from_git`)

In multi-app repositories, duplicating `Fastfile` logic leads to version drift. Fastlane supports importing shared lane definitions:

```
workspace_root/
├── shared_fastlane/
│   └── Fastfile.shared            # Common quality gates, notifications, slack hooks
├── apps/
│   ├── buyer_app/
│   │   └── android/fastlane/
│   │       └── Fastfile           # Imports shared + adds app-specific package ID
│   └── distributor_app/
│       └── android/fastlane/
│           └── Fastfile
```

### In Local `Fastfile`:
```ruby
# apps/buyer_app/android/fastlane/Fastfile

# Import shared lanes from relative local directory
import("../../../shared_fastlane/Fastfile.shared")

platform :android do
  lane :deploy do
    # Call shared pre-flight gate defined in Fastfile.shared
    check_quality

    upload_to_play_store(
      package_name: "com.impulse.buyer_app",
      track: "production"
    )
  end
end
```

### Importing from Remote Git Repository:
```ruby
# Import directly from a private shared infrastructure repository
import_from_git(
  url: "git@github.com:impulse/mobile-fastlane-common.git",
  branch: "main",
  path: "Fastfile.shared"
)
```

---

## 2. Shared `Matchfile` for Multi-App Teams

Multiple apps under the same Apple Developer Team can share an encrypted certificate repository:

```ruby
# ios/fastlane/Matchfile

git_url("git@github.com:impulse/ios-certificates.git")
storage_mode("git")

# Specify all app IDs managed by the repository
app_identifier([
  "com.impulseagriscienceltd.impulse_app",
  "com.impulseagriscienceltd.buyer_app"
])

username("apple-developer@company.com")
```

---

## 3. White-Label App Generation Matrix

For white-label distributions where the same core Flutter codebase is packaged for different regional brands:

```ruby
lane :deploy_all_brands do
  brands = ["impulse", "partner_alpha", "partner_beta"]
  
  brands.each do |brand|
    UI.message("🚀 Deploying brand: #{brand}")
    deploy_flavor(flavor: brand)
  end
end
```
