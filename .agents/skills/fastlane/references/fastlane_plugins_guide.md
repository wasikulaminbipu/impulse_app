# Fastlane Plugin Ecosystem & Custom Plugin Guide

This guide covers managing, installing, and authoring Fastlane plugins for Flutter mobile workflows.

---

## 1. Fastlane Plugin Architecture

A Fastlane plugin is a Ruby gem that adheres to Fastlane's naming and structure conventions (`fastlane-plugin-[name]`). Plugins are managed via `Pluginfile` alongside the `Gemfile` in `android/` and `ios/`.

### Directory Hierarchy
```
android/
├── Gemfile
├── Gemfile.lock
└── fastlane/
    ├── Appfile
    ├── Fastfile
    └── Pluginfile
```

---

## 2. Essential Fastlane Plugins for Flutter

| Plugin | Purpose | Install Command |
|---|---|---|
| `fastlane-plugin-versioning_android` | Automate Android version code and version name manipulation | `bundle exec fastlane add_plugin versioning_android` |
| `fastlane-plugin-badge` | Add beta/staging badges, ribbons, and build numbers to app launcher icons | `bundle exec fastlane add_plugin badge` |
| `fastlane-plugin-sentry` | Upload ProGuard / Dart debug symbols and commit release info to Sentry | `bundle exec fastlane add_plugin sentry` |
| `fastlane-plugin-firebase_app_distribution` | Direct upload of APK/AAB/IPA to Firebase App Distribution | `bundle exec fastlane add_plugin firebase_app_distribution` |
| `fastlane-plugin-changelog` | Read, parse, and update keep-a-changelog markdown files | `bundle exec fastlane add_plugin changelog` |

---

## 3. Managing Plugins in CI/CD

To ensure fast, deterministic, reproducible builds without interactive prompts:

1. **Avoid `fastlane add_plugin` in CI**: Always commit `Pluginfile` and `Gemfile.lock` to git.
2. **Install plugins via Bundler**:
   ```bash
   bundle install --deployment --jobs 4 --retry 3
   ```
3. **Run Fastlane without interactive plugin queries**:
   ```bash
   FASTLANE_SKIP_UPDATE_CHECK=true CI=true bundle exec fastlane <lane>
   ```

---

## 4. Creating a Custom Fastlane Plugin for Flutter

If you have shared internal distribution or auditing logic across multiple apps:

### A. Generate Plugin Skeleton
```bash
fastlane new_plugin flutter_quality_gate
```

This creates:
```
fastlane-plugin-flutter_quality_gate/
├── lib/
│   └── fastlane/
│       └── plugin/
│           └── flutter_quality_gate/
│               ├── actions/
│               │   └── flutter_quality_gate_action.rb
│               └── version.rb
├── Rakefile
└── fastlane-plugin-flutter_quality_gate.gemspec
```

### B. Implement Action Logic
In `flutter_quality_gate_action.rb`:
```ruby
module Fastlane
  module Actions
    class FlutterQualityGateAction < Action
      def self.run(params)
        min_coverage = params[:min_coverage] || 70.0

        UI.message("Executing Flutter static analysis gate...")
        sh("flutter analyze --fatal-infos --fatal-warnings")

        UI.message("Running test coverage suite...")
        sh("flutter test --coverage")

        UI.message("Validating minimum coverage threshold (#{min_coverage}%)...")
        sh("dart run bin/generate_coverage_badge.dart --min-coverage=#{min_coverage}")

        UI.success("Flutter Quality Gate passed successfully!")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :min_coverage,
            description: "Minimum test coverage percentage required",
            optional: true,
            type: Float,
            default_value: 70.0
          )
        ]
      end

      def self.is_supported?(platform)
        [:android, :ios].include?(platform)
      end
    end
  end
end
```

### C. Referencing Local Plugin in `Pluginfile`
Before publishing to RubyGems or private gem server:
```ruby
gem "fastlane-plugin-flutter_quality_gate", path: "../../plugins/fastlane-plugin-flutter_quality_gate"
```
