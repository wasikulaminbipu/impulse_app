module Fastlane
  module Actions
    class AuditFastlaneHealthAction < Action
      def self.run(params)
        UI.message("Executing Dart-based Fastlane and Metadata Health Audit...")
        sh("cd ../.. && dart run bin/audit_fastlane.dart")
      end

      def self.description
        "Audits Fastlane tracks, metadata lengths, and assetlinks integrity"
      end

      def self.details
        "Runs the project's comprehensive bin/audit_fastlane.dart audit to verify Google Play and App Store readiness."
      end

      def self.authors
        ["Impulse Team"]
      end

      def self.is_supported?(platform)
        [:android, :ios].include?(platform)
      end
    end
  end
end
