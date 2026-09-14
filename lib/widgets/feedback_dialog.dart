import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/app_review_provider.dart';

/// A bilingual, customer-first Material 3 Star Rating & Play Store Feedback Dialog.
/// Designed to offer maximum convenience and zero hassle to customers.
class FeedbackDialog extends ConsumerStatefulWidget {
  /// Whether the dialog was opened directly by the user (e.g. from the Drawer/About screen)
  /// or auto-prompted after milestone session usage.
  final bool isUserInitiated;

  /// Optional override for feedback recipient email. Defaults to [FeedbackConfig.email].
  final String? feedbackEmail;

  /// Optional override for feedback WhatsApp link/number. Defaults to [FeedbackConfig.whatsApp].
  final String? feedbackWhatsApp;

  /// Optional callbacks for unit and widget testing dependency injection.
  final VoidCallback? onPlayStoreTapped;
  final ValueChanged<String?>? onFeedbackEmailTapped;
  final ValueChanged<String?>? onFeedbackWhatsAppTapped;
  final VoidCallback? onPostponed;
  final VoidCallback? onNeverAskAgain;

  const FeedbackDialog({
    super.key,
    this.isUserInitiated = false,
    this.feedbackEmail,
    this.feedbackWhatsApp,
    this.onPlayStoreTapped,
    this.onFeedbackEmailTapped,
    this.onFeedbackWhatsAppTapped,
    this.onPostponed,
    this.onNeverAskAgain,
  });

  @override
  ConsumerState<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends ConsumerState<FeedbackDialog> {
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _showFeedbackInput = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _onStarTapped(int rating) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedRating = rating;
      _showFeedbackInput = rating > 0 && rating <= 3;
    });
  }

  void _handlePlayStoreRating() {
    if (widget.onPlayStoreTapped != null) {
      widget.onPlayStoreTapped!();
    } else {
      ref.read(appReviewProvider.notifier).openPlayStore();
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _handleEmailFeedback() {
    final text = _feedbackController.text.trim();
    if (widget.onFeedbackEmailTapped != null) {
      widget.onFeedbackEmailTapped!(text);
    } else {
      ref
          .read(appReviewProvider.notifier)
          .sendFeedbackEmail(
            feedback: text,
            recipientEmail: widget.feedbackEmail,
          );
      ref.read(appReviewProvider.notifier).markRated();
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _handleWhatsAppFeedback() {
    final text = _feedbackController.text.trim();
    if (widget.onFeedbackWhatsAppTapped != null) {
      widget.onFeedbackWhatsAppTapped!(text);
    } else {
      ref
          .read(appReviewProvider.notifier)
          .sendFeedbackWhatsApp(
            feedback: text,
            whatsAppTarget: widget.feedbackWhatsApp,
          );
      ref.read(appReviewProvider.notifier).markRated();
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _handlePostpone() {
    if (widget.onPostponed != null) {
      widget.onPostponed!();
    } else {
      ref.read(appReviewProvider.notifier).markPostponed();
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _handleNeverAskAgain() {
    if (widget.onNeverAskAgain != null) {
      widget.onNeverAskAgain!();
    } else {
      ref.read(appReviewProvider.notifier).markNeverAskAgain();
    }
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final lang = ref.watch(languageSettingProvider);
    final isBn = lang == 'bn';

    return AlertDialog(
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _selectedRating >= 4
              ? Icons.auto_awesome_rounded
              : (_selectedRating > 0
                    ? Icons.favorite_rounded
                    : Icons.star_rate_rounded),
          size: 36,
          color: colorScheme.primary,
        ),
      ),
      title: Text(
        isBn ? 'ইমপালস ব্যবহার কেমন লাগছে?' : 'Enjoying Impulse?',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamic Subtitle / Encouragement
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Text(
                _getSubtitleText(isBn),
                key: ValueKey<int>(_selectedRating),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // 5-Star Interactive Selector (Protected against right overflow)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _selectedRating;
                  return IconButton(
                    key: Key('feedback_star_$starIndex'),
                    onPressed: () => _onStarTapped(starIndex),
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 4,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                    splashRadius: 22,
                    icon: Icon(
                      isFilled
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 36,
                      color: isFilled
                          ? const Color(0xFFFFB800)
                          : colorScheme.outlineVariant,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // Action routing based on star selection
            if (_selectedRating >= 4) ...[
              // Positive Route: Google Play Store
              FilledButton.icon(
                key: const Key('feedback_play_store_button'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _handlePlayStoreRating,
                icon: const Icon(Icons.rate_review_rounded, size: 20),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    isBn ? 'প্লে স্টোরে রেটিং দিন' : 'Rate on Google Play',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ] else if (_selectedRating >= 1 && _selectedRating <= 3) ...[
              // Constructive Route: In-app support / feedback channels
              if (_showFeedbackInput) ...[
                TextField(
                  key: const Key('feedback_text_field'),
                  controller: _feedbackController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: isBn
                        ? 'কীভাবে আমরা অ্যাপটি আরও ভালো করতে পারি লিখুন...'
                        : 'Tell us how we can improve...',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              OverflowBar(
                spacing: 8,
                overflowSpacing: 8,
                alignment: MainAxisAlignment.center,
                overflowAlignment: OverflowBarAlignment.center,
                children: [
                  OutlinedButton.icon(
                    key: const Key('feedback_email_button'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _handleEmailFeedback,
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(isBn ? 'ইমেইল' : 'Email'),
                    ),
                  ),
                  FilledButton.tonalIcon(
                    key: const Key('feedback_whatsapp_button'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _handleWhatsAppFeedback,
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 18,
                    ),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(isBn ? 'হোয়াটসঅ্যাপ' : 'WhatsApp'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 4,
      actions: [
        TextButton(
          key: const Key('feedback_maybe_later_button'),
          onPressed: _handlePostpone,
          child: Text(
            widget.isUserInitiated
                ? (isBn ? 'বন্ধ করুন' : 'Close')
                : (isBn ? 'হয়তো পরে' : 'Maybe Later'),
            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
          ),
        ),
        if (!widget.isUserInitiated)
          TextButton(
            key: const Key('feedback_never_ask_button'),
            onPressed: _handleNeverAskAgain,
            child: Text(
              isBn ? 'আর দেখাবেন না' : "Don't ask again",
              style: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }

  String _getSubtitleText(bool isBn) {
    if (_selectedRating == 0) {
      return isBn
          ? 'আপনার সামগ্রিক অভিজ্ঞতা কেমন? রেটিং দিতে স্টারে ট্যাপ করুন।'
          : 'How has your experience been? Tap a star to share your rating.';
    } else if (_selectedRating >= 4) {
      return isBn
          ? 'অনেক ধন্যবাদ! প্লে স্টোরে একটি সুন্দর রিভিউ দিয়ে আমাদের সাহায্য করুন।'
          : 'Thank you so much! A positive review on the Play Store helps us tremendously.';
    } else {
      return isBn
          ? 'আমরা সবসময় সেবার মান বাড়াতে সচেষ্ট। আপনার মতামত আমাদের জানান।'
          : 'We value your input. Let us know how we can make Impulse better for you.';
    }
  }
}
