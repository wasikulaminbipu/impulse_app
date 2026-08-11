import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  static const String privacyPolicyUrl = 'https://www.impulseagrisciencelimited.com/privacy';
  static const String dataDeletionUrl = 'https://www.impulseagrisciencelimited.com/delete-account';

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(Icons.privacy_tip_outlined, color: colorScheme.primary),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Privacy Policy & Data',
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impulse DEX respects your privacy.',
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• All product catalogs and favorites are processed locally on your device.\n'
              '• Contact permissions are used strictly to save sales personnel details directly to your phone.\n'
              '• We do not sell or upload your personal contact data to external servers.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.description_outlined, color: colorScheme.primary, size: 20),
              title: const Text('Read Full Privacy Policy', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.open_in_new_rounded, size: 16),
              onTap: () => _launchUrl(privacyPolicyUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Note: Impulse DEX does not require user accounts. Clearing app data or uninstalling removes all local preferences.',
                style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
