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

  /// Optional callbacks for unit and widget testing dependency injection.
  final VoidCallback? onPlayStoreTapped;
  final ValueChanged<String?>? onFeedbackEmailTapped;
  final ValueChanged<String?>? onFeedbackWhatsAppTapped;
  final VoidCallback? onPostponed;
  final VoidCallback? onNeverAskAgain;

  const FeedbackDialog({
    super.key,
    this.isUserInitiated = false,
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
      ref.read(appReviewProvider.notifier).sendFeedbackEmail(feedback: text);
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
      ref.read(appReviewProvider.notifier).sendFeedbackWhatsApp(feedback: text);
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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: colorScheme.surface,
      elevation: 6,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Icon Badge
              Container(
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
              const SizedBox(height: 18),

              // Title
              Text(
                isBn ? 'ইমপালস ব্যবহার কেমন লাগছে?' : 'Enjoying Impulse?',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

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

              // 5-Star Interactive Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _selectedRating;
                  return IconButton(
                    key: Key('feedback_star_$starIndex'),
                    onPressed: () => _onStarTapped(starIndex),
                    splashRadius: 24,
                    icon: Icon(
                      isFilled
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 38,
                      color: isFilled
                          ? const Color(0xFFFFB800)
                          : colorScheme.outlineVariant,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Action routing based on star selection
              if (_selectedRating >= 4) ...[
                // Positive Route: Google Play Store
                FilledButton.icon(
                  key: const Key('feedback_play_store_button'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: _handlePlayStoreRating,
                  icon: const Icon(Icons.rate_review_rounded, size: 20),
                  label: Text(
                    isBn ? 'প্লে স্টোরে রেটিং দিন' : 'Rate on Google Play',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
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
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        key: const Key('feedback_email_button'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _handleEmailFeedback,
                        icon: const Icon(Icons.mail_outline_rounded, size: 18),
                        label: Text(isBn ? 'ইমেইল' : 'Email'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        key: const Key('feedback_whatsapp_button'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _handleWhatsAppFeedback,
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 18,
                        ),
                        label: Text(isBn ? 'হোয়াটসঅ্যাপ' : 'WhatsApp'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],

              // Postpone / Dismissal / Never Ask controls for customer comfort
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  TextButton(
                    key: const Key('feedback_maybe_later_button'),
                    onPressed: _handlePostpone,
                    child: Text(
                      widget.isUserInitiated
                          ? (isBn ? 'বন্ধ করুন' : 'Close')
                          : (isBn ? 'হয়তো পরে' : 'Maybe Later'),
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  if (!widget.isUserInitiated) ...[
                    Text(
                      '•',
                      style: TextStyle(
                        color: colorScheme.outlineVariant,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      key: const Key('feedback_never_ask_button'),
                      onPressed: _handleNeverAskAgain,
                      child: Text(
                        isBn ? 'আর দেখাবেন না' : "Don't ask again",
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.8,
                          ),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
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
