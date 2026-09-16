# Authoring Custom Fastlane Actions for Flutter

Fastlane allows teams to create project-specific custom actions located in `android/fastlane/actions/` or `ios/fastlane/actions/`. Custom actions provide clean Ruby DSL methods callable directly from any lane.

---

## 1. Action File Structure

Create custom actions inside the `fastlane/actions/` directory:

```
android/fastlane/actions/
├── flutter_analyze.rb
├── validate_sqlite_db.rb
└── flutter_coverage_gate.rb
```

---

## 2. Example: Custom `flutter_analyze` Action

```ruby
# android/fastlane/actions/flutter_analyze.rb

module Fastlane
  module Actions
    class FlutterAnalyzeAction < Action
      def self.run(params)
        UI.message("🔍 Executing Flutter Static Analysis...")
        fatal_warnings = params[:fatal_warnings] ? "--fatal-warnings" : ""
        fatal_infos    = params[:fatal_infos] ? "--fatal-infos" : ""

        cmd = "cd ../.. && flutter analyze #{fatal_warnings} #{fatal_infos}"
        sh(cmd)
        UI.success("✅ Flutter static analysis passed with zero issues.")
      end

      def self.description
        "Runs strict Flutter static analysis from within Fastlane"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :fatal_warnings,
            description: "Treat warnings as fatal errors",
            is_string: false,
            default_value: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :fatal_infos,
            description: "Treat infos as fatal errors",
            is_string: false,
            default_value: true
          )
        ]
      end

      def self.is_supported?(platform)
        [:android, :ios].include?(platform)
      end

      def self.authors
        ["Antigravity / Impulse AgriScience"]
      end
    end
  end
end
```

### Calling Custom Action in Fastfile
```ruby
lane :check do
  flutter_analyze(fatal_warnings: true, fatal_infos: true)
end
```

---

## 3. Example: Custom `validate_sqlite_db` Action

```ruby
# android/fastlane/actions/validate_sqlite_db.rb

module Fastlane
  module Actions
    class ValidateSqliteDbAction < Action
      def self.run(params)
        UI.message("🗄️ Validating SQLite database assets integrity...")
        sh("cd ../.. && dart run bin/validate_db.dart")
        UI.success("✅ SQLite database integrity verified.")
      end

      def self.description
        "Runs SQLite PRAGMA integrity and foreign key checks on pre-populated database assets"
      end

      def self.is_supported?(platform)
        true
      end

      def self.authors
        ["Antigravity / Impulse AgriScience"]
      end
    end
  end
end
```
