---
name: native-device-integrations
description: Use when implementing or modifying native device capabilities, including contact access, vCard export, phone/WhatsApp URL launching, intent sharing, and runtime permissions in this Flutter project.
---

# Native Device Integrations & Hardware Services

This skill outlines best practices for integrating native Android (SDK 35 / Android 15) and iOS hardware/platform services in `impulse_dex`, focusing on **Contacts (`flutter_contacts`)**, **URL Launching & Telephony (`url_launcher`)**, and **System Share Sheets (`share_plus`)**.

---

## 1. Contact Management & Permissions (`flutter_contacts`)

### Core Capabilities
- Querying device contacts with optional properties (phones, emails, photo thumbnails).
- Inserting individual sales personnel contacts directly into the user's phone book.
- Generating `.vcf` (vCard 3.0) payloads and exporting contacts in bulk.

### Runtime Permissions Strategy
Always verify and request permissions before invoking contact read/write operations:

```dart
import 'package:flutter_contacts/flutter_contacts.dart';

Future<bool> ensureContactPermissions({bool readonly = false}) async {
  final granted = await FlutterContacts.requestPermission(readonly: readonly);
  return granted;
}
```

### Android & iOS Manifest Requirements
- **Android (`AndroidManifest.xml`)**:
  ```xml
  <uses-permission android:name="android.permission.READ_CONTACTS"/>
  <uses-permission android:name="android.permission.WRITE_CONTACTS"/>
  ```
- **iOS (`Info.plist`)**:
  ```xml
  <key>NSContactsUsageDescription</key>
  <string>Impulse Dex needs access to your contacts to save sales personnel and dealer contact information.</string>
  ```

### Inserting a Contact
When saving sales representatives to the phonebook:
```dart
Future<bool> saveRepresentativeContact({
  required String firstName,
  required String lastName,
  required String phoneNumber,
  String? organization,
  String? designation,
}) async {
  final hasPermission = await FlutterContacts.requestPermission();
  if (!hasPermission) return false;

  final newContact = Contact(
    name: Name(first: firstName, last: lastName),
    phones: [Phone(phoneNumber, label: PhoneLabel.mobile)],
    organizations: [
      if (organization != null || designation != null)
        Organization(company: organization ?? '', title: designation ?? ''),
    ],
  );

  await newContact.insert();
  return true;
}
```

### vCard 3.0 Generation & Bulk Export
For high-performance contact export without stalling the UI thread:
```dart
String generateVCard({
  required String formattedName,
  required String phone,
  String? company,
  String? title,
  String? email,
}) {
  final buffer = StringBuffer()
    ..writeln('BEGIN:VCARD')
    ..writeln('VERSION:3.0')
    ..writeln('FN:$formattedName')
    ..writeln('TEL;TYPE=CELL:$phone');
  
  if (company != null && company.isNotEmpty) {
    buffer.writeln('ORG:$company');
  }
  if (title != null && title.isNotEmpty) {
    buffer.writeln('TITLE:$title');
  }
  if (email != null && email.isNotEmpty) {
    buffer.writeln('EMAIL:$email');
  }
  buffer.writeln('END:VCARD');
  return buffer.toString();
}
```

---

## 2. Telephony & External Launching (`url_launcher`)

### Supported Intent Schemes
1. **Direct Phone Call / Dialer**: `tel:+8801XXXXXXXXX`
2. **SMS / Text Message**: `sms:+8801XXXXXXXXX`
3. **WhatsApp Direct Message**: `https://wa.me/<international_phone>?text=<encoded_text>`
4. **Email Client**: `mailto:<email>?subject=<encoded_subject>`
5. **Web Browser**: `https://...`

### Implementation Standard
Always sanitize phone numbers (remove spaces, hyphens, and ensure international `+880` format where required) and verify `canLaunchUrl`:

```dart
import 'package:url_launcher/url_launcher.dart';

abstract final class NativeIntentLauncher {
  /// Opens device dialer with pre-populated phone number
  static Future<bool> dialNumber(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanNumber);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// Opens WhatsApp chat directly
  static Future<bool> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    // WhatsApp requires pure digits with country code (no '+' or '-' symbols)
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.startsWith('0')) {
      // Convert standard Bangladesh local 01... to 8801...
      digitsOnly = '880${digitsOnly.substring(1)}';
    }

    final encodedMessage = message != null ? Uri.encodeComponent(message) : '';
    final url = 'https://wa.me/$digitsOnly${encodedMessage.isNotEmpty ? '?text=$encodedMessage' : ''}';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// Opens default email client
  static Future<bool> sendEmail({
    required String recipient,
    String subject = '',
    String body = '',
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}
```

---

## 3. Native Share Sheets (`share_plus`)

### Standard Text & Link Sharing
```dart
import 'package:share_plus/share_plus.dart';

Future<void> shareProductDetails({
  required String productName,
  required String description,
  String? webLink,
}) async {
  final text = '$productName\n\n$description${webLink != null ? '\n\nMore info: $webLink' : ''}';
  await Share.share(
    text,
    subject: 'Impulse Dex: $productName',
  );
}
```

### File / vCard Sharing with XFile
```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareVCardFile({
  required String vCardContent,
  required String fileName,
}) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$fileName.vcf');
  await file.writeAsString(vCardContent);

  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'text/vcard')],
    text: 'Sales Representative Contact Card',
  );
}
```

---

## 4. Error Handling & Device Compatibility
- **Permission Denied**: Provide clear user feedback via an in-app Snackbar or Dialog with a direct action to open app settings if permanently denied.
- **WhatsApp Not Installed**: When `https://wa.me/` fails or the user has no WhatsApp client, gracefully fall back to opening the standard phone dialer or SMS intent.
- **Missing Telephony on Tablets**: Always wrap `launchUrl` in `try-catch` and check `canLaunchUrl` to prevent crashes on Wi-Fi-only tablets or emulators.
