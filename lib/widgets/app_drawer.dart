import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/constants/app_assets.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_update_provider.dart';
import 'package:impulse_app/providers/app_version_provider.dart';
import 'package:impulse_app/providers/navigation_provider.dart';
import 'package:impulse_app/screens/about_us_screen.dart';
import 'package:impulse_app/widgets/feedback_dialog.dart';
import 'package:impulse_app/widgets/glass_container.dart';
import 'package:impulse_app/widgets/privacy_policy_dialog.dart';

class AppDrawer extends ConsumerWidget {
  final void Function(int index)? onTabSelected;
  final int? currentTabIndex;

  const AppDrawer({super.key, this.onTabSelected, this.currentTabIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final lang = ref.watch(languageSettingProvider);
    final isBn = lang == 'bn';
    final activeTabIndex = currentTabIndex ?? ref.watch(mainNavIndexProvider);
    final appVersion = ref.watch(appVersionDisplayProvider);

    void navigateToTab(int index) {
      Navigator.of(context).pop();
      ref.read(mainNavIndexProvider.notifier).setIndex(index);
      if (onTabSelected != null) onTabSelected!(index);
    }

    return Drawer(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Glass effect & App Logo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.5,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.inventory_2_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Impulse',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isBn ? 'ডিজিটাল প্রোডাক্ট সূচক' : 'Digital Index',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'v$appVersion',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Navigation Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildDrawerTile(
                    context,
                    icon: Icons.inventory_2_outlined,
                    selectedIcon: Icons.inventory_2,
                    label: isBn ? 'প্রোডাক্টস ক্যাটালগ' : 'Products Directory',
                    isSelected: activeTabIndex == 0,
                    onTap: () => navigateToTab(0),
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.factory_outlined,
                    selectedIcon: Icons.factory,
                    label: isBn ? 'ম্যানুফ্যাকচারার' : 'Manufacturers',
                    isSelected: activeTabIndex == 1,
                    onTap: () => navigateToTab(1),
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.contacts_outlined,
                    selectedIcon: Icons.contacts,
                    label: isBn ? 'যোগাযোগের বিবরণ' : 'Contact Details',
                    isSelected: activeTabIndex == 2,
                    onTap: () => navigateToTab(2),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Divider(
                      height: 1,
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),

                  // Information & About Section
                  _buildDrawerTile(
                    context,
                    icon: Icons.info_outline_rounded,
                    selectedIcon: Icons.info_rounded,
                    label: isBn ? 'আমাদের সম্পর্কে' : 'About Us',
                    isSelected: false,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const AboutUsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    selectedIcon: Icons.privacy_tip_rounded,
                    label: isBn ? 'প্রাইভেসি পলিসি' : 'Privacy Policy',
                    isSelected: false,
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog<void>(
                        context: context,
                        builder: (context) => const PrivacyPolicyDialog(),
                      );
                    },
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.star_outline_rounded,
                    selectedIcon: Icons.star_rounded,
                    label: isBn ? 'রেটিং ও মতামত' : 'Rate & Feedback',
                    isSelected: false,
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog<void>(
                        context: context,
                        builder: (context) =>
                            const FeedbackDialog(isUserInitiated: true),
                      );
                    },
                  ),
                  _buildUpdateTile(context, ref, isBn: isBn),
                ],
              ),
            ),

            // Drawer Footer (Language Switcher & Copyright)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.language_rounded,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isBn ? 'ভাষা switch' : 'Language',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      ref.read(languageSettingProvider.notifier).toggle();
                    },
                    icon: const Icon(Icons.swap_horiz, size: 16),
                    label: Text(
                      isBn ? 'English' : 'বাংলা',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        selected: isSelected,
        selectedTileColor: colorScheme.primaryContainer.withValues(alpha: 0.6),
        leading: Icon(
          isSelected ? selectedIcon : icon,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
      ),
    );
  }

  Widget _buildUpdateTile(
    BuildContext context,
    WidgetRef ref, {
    required bool isBn,
  }) {
    final updateState = ref.watch(appUpdateProvider);
    final colorScheme = Theme.of(context).colorScheme;

    String label;
    IconData icon;
    if (updateState.status == UpdateStatus.downloaded) {
      label = isBn
          ? 'রিস্টার্ট করে আপডেট সম্পন্ন করুন'
          : 'Restart to Apply Update';
      icon = Icons.restart_alt_rounded;
    } else if (updateState.status == UpdateStatus.downloading) {
      label = isBn ? 'আপডেট ডাউনলোড হচ্ছে...' : 'Downloading Update...';
      icon = Icons.downloading_rounded;
    } else if (updateState.hasUpdate) {
      label = isBn ? 'নতুন আপডেট উপলব্ধ!' : 'Update Available!';
      icon = Icons.rocket_launch_rounded;
    } else {
      label = isBn ? 'আপডেট পরীক্ষা করুন' : 'Check for Updates';
      icon = Icons.system_update_rounded;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(
          icon,
          color: updateState.hasUpdate
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: updateState.hasUpdate
                ? FontWeight.w700
                : FontWeight.w500,
            color: updateState.hasUpdate
                ? colorScheme.primary
                : colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
        trailing: updateState.hasUpdate
            ? Badge(backgroundColor: colorScheme.primary, smallSize: 10)
            : (updateState.status == UpdateStatus.checking
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    )
                  : null),
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.of(context).pop();
          if (updateState.status == UpdateStatus.downloaded) {
            ref.read(appUpdateProvider.notifier).completeFlexibleUpdate();
          } else {
            ref
                .read(appUpdateProvider.notifier)
                .checkAndPromptUpdate(force: true);
          }
        },
      ),
    );
  }
}
