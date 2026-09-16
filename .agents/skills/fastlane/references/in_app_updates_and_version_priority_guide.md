# In-App Updates & Release Priority Guide for Flutter

This guide explains how to control update urgency in Google Play using Fastlane's `update_priority` parameter and how to consume it in Flutter applications using the `in_app_update` package.

---

## 1. Google Play In-App Update Priority Scale

Google Play Developer API v3 allows setting an integer priority level (`update_priority`) from **0** (default / lowest) to **5** (highest / emergency):

| Priority Level | Classification | Client UI Behavior | Typical Use Case |
| :---: | :--- | :--- | :--- |
| **0 – 1** | Trivial / Optional | No notification or passive banner. | Minor copy tweaks, cosmetic fixes. |
| **2 – 3** | Recommended | **Flexible Update**: Downloads in background while user interacts; prompts restart on completion. | Non-breaking feature additions, minor bug fixes. |
| **4 – 5** | Mandatory / Critical | **Immediate Update**: Full-screen blocking dialog; app cannot be used until update completes. | Critical security vulnerabilities, breaking API changes, severe database corruption fixes. |

---

## 2. Configuring `update_priority` in Fastlane

Set `update_priority` inside the `upload_to_play_store` action:

```ruby
# android/fastlane/Fastfile

desc "Deploy critical emergency hotfix with immediate in-app update priority"
lane :deploy_emergency_hotfix do
  upload_to_play_store(
    track: "production",
    aab: "../build/app/outputs/bundle/release/app-release.aab",
    mapping_paths: ["../build/app/outputs/mapping/release/mapping.txt"],
    update_priority: 5, # Mandatory immediate update prompt on user devices
    rollout: "1.0",     # 100% rollout
    changes_not_sent_for_review: true
  )
  UI.success("🚨 Emergency hotfix published with priority level 5!")
end
```

---

## 3. Flutter Client Handling (`in_app_update`)

In Flutter, check update priority on app startup:

```dart
import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/material.dart';

Future<void> checkForAppUpdate(BuildContext context) async {
  try {
    final info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      if ((info.updatePriority ?? 0) >= 4) {
        // High priority: trigger immediate blocking update
        await InAppUpdate.performImmediateUpdate();
      } else if ((info.updatePriority ?? 0) >= 2) {
        // Medium priority: trigger flexible background update
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    }
  } catch (e) {
    debugPrint('In-app update check failed: $e');
  }
}
```
