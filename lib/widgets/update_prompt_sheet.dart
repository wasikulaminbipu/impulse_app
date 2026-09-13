import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';

/// A bilingual, highly encouraging Material 3 bottom sheet prompting
/// the user to download and install the latest version of Impulse Dex.
class UpdatePromptSheet extends ConsumerWidget {
  final int availableVersionCode;
  final int? stalenessDays;
  final VoidCallback onUpdateNow;
  final VoidCallback onRemindLater;

  const UpdatePromptSheet({
    super.key,
    required this.availableVersionCode,
    this.stalenessDays,
    required this.onUpdateNow,
    required this.onRemindLater,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final lang = ref.watch(languageSettingProvider);
    final isBn = lang == 'bn';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Animated Rocket / Update Icon
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primaryContainer,
                        colorScheme.primary.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.rocket_launch_rounded,
                    size: 38,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Heading Title
              Text(
                isBn ? 'নতুন সংস্করণ উপলব্ধ!' : 'New Version Available!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle / Encouragement description
              Text(
                isBn
                    ? 'সর্বশেষ ভেটেরিনারি ওষুধ, পরিবেশক তালিকা এবং উন্নত সুবিধার জন্য এখনই অ্যাপটি আপডেট করুন।'
                    : 'Update to the latest version of Impulse Dex to get new medicines, verified distributors, and improved performance.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Highlights Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.45,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  children: [
                    _buildHighlightRow(
                      context,
                      icon: Icons.medication_rounded,
                      text: isBn
                          ? 'সর্বশেষ ওষুধ ও ডোজ নির্দেশনা'
                          : 'Latest medicine formulations & dosages',
                    ),
                    const SizedBox(height: 10),
                    _buildHighlightRow(
                      context,
                      icon: Icons.storefront_rounded,
                      text: isBn
                          ? 'হালনাগাদ পরিবেশক ও ফিল্ড রিপ্রেজেন্টেটিভ'
                          : 'Updated distributor & field rep contacts',
                    ),
                    const SizedBox(height: 10),
                    _buildHighlightRow(
                      context,
                      icon: Icons.bolt_rounded,
                      text: isBn
                          ? 'উন্নত সার্চ ও দ্রুত পারফরম্যান্স'
                          : 'Faster search & offline performance',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Primary Action: Update Now
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onUpdateNow();
                },
                icon: const Icon(Icons.download_rounded, size: 22),
                label: Text(
                  isBn ? 'এখনই আপডেট করুন' : 'Update Now',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Secondary Action: Remind Me Later
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onRemindLater();
                },
                child: Text(
                  isBn ? 'পরে মনে করিয়ে দিন' : 'Remind Me Later',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightRow(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
