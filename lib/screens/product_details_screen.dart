import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/config/app_config.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/screens/sales_personnels_screen.dart';
import 'package:impulse_app/services/app_review_service.dart'
    show UrlLauncherWrapper;
import 'package:impulse_app/theme/app_theme.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/utils/product_share_service.dart';
import 'package:impulse_app/widgets/custom_badge.dart';
import 'package:impulse_app/widgets/favorite_button.dart';
import 'package:impulse_app/widgets/group_logo_viewer.dart';
import 'package:impulse_app/widgets/product_details/benefits_section.dart';
import 'package:impulse_app/widgets/product_details/composition_section.dart';
import 'package:impulse_app/widgets/product_details/directions_section.dart';
import 'package:impulse_app/widgets/product_details/indications_section.dart';
import 'package:impulse_app/widgets/product_details/manufacturer_section.dart';
import 'package:impulse_app/widgets/product_details/precautions_section.dart';
import 'package:impulse_app/widgets/product_details/presentations_section.dart';
import 'package:impulse_app/widgets/whatsapp_icon.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode;

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductLabel product;
  final UrlLauncherWrapper launcher;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.launcher = const UrlLauncherWrapper(),
  });

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final GlobalKey _shareBoundaryKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _handleWhatsAppInquiry(String productTitle, String lang) async {
    final message = lang == 'bn'
        ? 'হ্যালো ইমপালস টিম, আমি "$productTitle" পণ্যটি সম্পর্কে আরও জানতে আগ্রহী।'
        : 'Hello Impulse Team, I would like to inquire about the product: "$productTitle".';

    final uri = AppConfig.buildWhatsAppUri(message: message);

    try {
      final launched = await widget.launcher.launch(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              lang == 'bn'
                  ? 'হোয়াটসঅ্যাপ খোলা যায়নি'
                  : 'Could not open WhatsApp',
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              lang == 'bn'
                  ? 'হোয়াটসঅ্যাপ খোলা যায়নি'
                  : 'Could not open WhatsApp',
            ),
          ),
        );
      }
    }
  }

  CategoryColorToken _getCategoryColorToken(BuildContext context) {
    final categoryColors = Theme.of(context).extension<CategoryColors>();
    if (categoryColors == null) {
      return const CategoryColorToken(
        primary: Colors.grey,
        container: Color(0x1F9E9E9E),
        border: Color(0x429E9E9E),
        text: Colors.grey,
      );
    }
    return categoryColors.resolve(
      category: widget.product.category.nameEn,
      targetGroups: widget.product.targetGroups.map((tg) => tg.nameEn),
    );
  }

  Future<void> _handleShareImage(String title) async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      await ProductShareService.shareProductCard(
        repaintBoundaryKey: _shareBoundaryKey,
        shareTitle: title,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share product image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  Future<void> _handleSharePdf(String title) async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      Product productToShare;
      final fullProductAsync = ref.read(
        productDetailProvider(widget.product.id),
      );
      if (fullProductAsync.hasValue && fullProductAsync.value != null) {
        productToShare = fullProductAsync.value!;
      } else {
        try {
          productToShare = await ref.read(
            productDetailProvider(widget.product.id).future,
          );
        } catch (_) {
          productToShare = Product(
            id: widget.product.id,
            titleEn: widget.product.titleEn,
            titleBn: widget.product.titleBn,
            slug: '',
            categoryId: widget.product.categoryId,
            category: widget.product.category,
            targetGroups: widget.product.targetGroups,
            presentations: widget.product.presentations,
            shortDescriptionEn: widget.product.shortDescriptionEn,
            shortDescriptionBn: widget.product.shortDescriptionBn,
            mottoEn: widget.product.mottoEn,
            mottoBn: widget.product.mottoBn,
            imageUrl: widget.product.imageUrl,
            createdAt: '',
            updatedAt: '',
          );
        }
      }

      final speciesList = ref.read(speciesProvider).value ?? [];

      await ProductShareService.shareProductPdf(
        product: productToShare,
        shareSubject: title,
        speciesList: speciesList,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share product PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  void _showShareOptionsModal({
    required BuildContext context,
    required String productTitle,
    required String lang,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang == 'bn' ? 'পণ্য শেয়ার করুন' : 'Share Product',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lang == 'bn'
                      ? 'শেয়ার করার জন্য ফরম্যাট নির্বাচন করুন'
                      : 'Choose format to share',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: isDark ? 0.3 : 0.6,
                        ),
                      ),
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.6,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      lang == 'bn' ? 'ছবি শেয়ার করুন' : 'Share as Image',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      lang == 'bn'
                          ? 'উচ্চ মানের পিএনজি ছবি'
                          : 'High-resolution PNG image',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      _handleShareImage(productTitle);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: isDark ? 0.3 : 0.6,
                        ),
                      ),
                    ),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      lang == 'bn' ? 'পিডিএফ শেয়ার করুন' : 'Share as PDF',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      lang == 'bn'
                          ? 'প্রিন্টযোগ্য সম্পূর্ণ স্পেসিফিকেশন শিট'
                          : 'Printable full specification sheet',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      _handleSharePdf(productTitle);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final lang = ref.watch(languageSettingProvider);
    final productTitle = widget.product.titleEn.resolve(
      widget.product.titleBn,
      lang,
    );

    final whatsappBg = isDark
        ? const Color(0xFF132F23)
        : const Color(0xFFE8F8F0);
    final whatsappFg = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF0F763E);
    final whatsappBorder = isDark
        ? const Color(0xFF25D366).withValues(alpha: 0.35)
        : const Color(0xFF25D366).withValues(alpha: 0.50);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: ColoredBox(
                        color: Colors.black.withValues(alpha: 0.2),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.2),
                          child: IconButton(
                            icon: Text(
                              lang == 'bn' ? 'EN' : 'বাংলা',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            tooltip: lang == 'bn' ? 'English' : 'বাংলা',
                            onPressed: () => ref
                                .read(languageSettingProvider.notifier)
                                .toggle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.2),
                          child: IconButton(
                            icon: _isSharing
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.share, color: Colors.white),
                            onPressed: _isSharing
                                ? null
                                : () => _showShareOptionsModal(
                                    context: context,
                                    productTitle: productTitle,
                                    lang: lang,
                                  ),
                            tooltip: lang == 'bn' ? 'শেয়ার করুন' : 'Share',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      right: 8.0,
                    ),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.2),
                          child: FavoriteButton(
                            refId: widget.product.id,
                            type: FavoriteType.product,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'product-image-${widget.product.id}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: _buildProductImage(context, colorScheme),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBadge.fromToken(
                            token: _getCategoryColorToken(context),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            text: widget.product.categoryId != 0
                                ? widget.product.category.nameEn
                                      .resolve(
                                        widget.product.category.nameBn,
                                        lang,
                                      )
                                      .toUpperCase()
                                : '',
                          ),
                          GroupLogoViewer(
                            groupLogos: widget.product.targetGroups
                                .map((e) => e.iconName ?? "")
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        productTitle,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      if (lang == 'bn'
                          ? widget.product.mottoBn != null
                          : widget.product.mottoEn != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          widget.product.mottoEn.resolve(
                            widget.product.mottoBn,
                            lang,
                          ),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                      if (lang == 'bn'
                          ? widget.product.shortDescriptionBn != null
                          : widget.product.shortDescriptionEn != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          widget.product.shortDescriptionEn.resolve(
                            widget.product.shortDescriptionBn,
                            lang,
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ref
                          .watch(productDetailProvider(widget.product.id))
                          .when(
                            data: (fullProduct) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (fullProduct.compositions.isNotEmpty)
                                  CompositionSection(
                                    compositions: fullProduct.compositions,
                                    lang: lang,
                                    basisEn: fullProduct.compositionBasisEn,
                                    basisBn: fullProduct.compositionBasisBn,
                                  ),
                                if (fullProduct.benefits.isNotEmpty)
                                  BenefitsSection(
                                    benefits: fullProduct.benefits,
                                    lang: lang,
                                  ),
                                if (fullProduct.indications.isNotEmpty)
                                  IndicationsSection(
                                    indications: fullProduct.indications,
                                    lang: lang,
                                  ),
                                if (fullProduct.directions.isNotEmpty)
                                  DirectionsSection(
                                    directions: fullProduct.directions,
                                    lang: lang,
                                    speciesList:
                                        ref.watch(speciesProvider).value ?? [],
                                    targetGroupsList:
                                        ref.watch(targetGroupsProvider).value ??
                                        [],
                                  ),
                                if (fullProduct.precautions.isNotEmpty)
                                  PrecautionsSection(
                                    precautions: fullProduct.precautions,
                                    lang: lang,
                                  ),
                                PresentationsSection(
                                  presentations: fullProduct.presentations,
                                  lang: lang,
                                ),
                                if (fullProduct.manufacturer.nameEn.isNotEmpty)
                                  ManufacturerSection(
                                    manufacturer: fullProduct.manufacturer,
                                    lang: lang,
                                  ),
                              ],
                            ),
                            loading: () => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            error: (err, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: Text(
                                  err.toString(),
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton.icon(
                                key: const Key(
                                  'product_whatsapp_inquiry_button',
                                ),
                                onPressed: () =>
                                    _handleWhatsAppInquiry(productTitle, lang),
                                icon: WhatsAppIcon(size: 18, color: whatsappFg),
                                label: Text(
                                  lang == 'bn' ? 'আরও জানুন' : 'Inquire',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: whatsappFg,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: whatsappBg,
                                  foregroundColor: whatsappFg,
                                  side: BorderSide(
                                    color: whatsappBorder,
                                    width: 1.2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: FilledButton.icon(
                                key: const Key(
                                  'product_find_field_team_button',
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          const SalesPersonnelsScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.people_alt_rounded,
                                  size: 18,
                                ),
                                label: Text(
                                  lang == 'bn' ? 'ফিল্ড টিম' : 'Field Team',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Off-screen RepaintBoundary to capture complete product layout from image to manufacturer section
          Positioned(
            left: -9999,
            top: -9999,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: RepaintBoundary(
                key: _shareBoundaryKey,
                child: Container(
                  width: 420,
                  color: colorScheme.surface,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Branding
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.medication,
                              color: colorScheme.onPrimaryContainer,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'IMPULSE',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'AgriScience Products Directory',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Product Image Container
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.3,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: _buildProductImage(context, colorScheme),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Badges and Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBadge.fromToken(
                            token: _getCategoryColorToken(context),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            text: widget.product.categoryId != 0
                                ? widget.product.category.nameEn
                                      .resolve(
                                        widget.product.category.nameBn,
                                        lang,
                                      )
                                      .toUpperCase()
                                : '',
                          ),
                          GroupLogoViewer(
                            groupLogos: widget.product.targetGroups
                                .map((e) => e.iconName ?? "")
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        productTitle,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      if (lang == 'bn'
                          ? widget.product.mottoBn != null
                          : widget.product.mottoEn != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          widget.product.mottoEn.resolve(
                            widget.product.mottoBn,
                            lang,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                      if (lang == 'bn'
                          ? widget.product.shortDescriptionBn != null
                          : widget.product.shortDescriptionEn != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          widget.product.shortDescriptionEn.resolve(
                            widget.product.shortDescriptionBn,
                            lang,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // Details Sections
                      ref
                          .watch(productDetailProvider(widget.product.id))
                          .maybeWhen(
                            data: (fullProduct) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (fullProduct.compositions.isNotEmpty)
                                  CompositionSection(
                                    compositions: fullProduct.compositions,
                                    lang: lang,
                                    basisEn: fullProduct.compositionBasisEn,
                                    basisBn: fullProduct.compositionBasisBn,
                                  ),
                                if (fullProduct.benefits.isNotEmpty)
                                  BenefitsSection(
                                    benefits: fullProduct.benefits,
                                    lang: lang,
                                  ),
                                if (fullProduct.indications.isNotEmpty)
                                  IndicationsSection(
                                    indications: fullProduct.indications,
                                    lang: lang,
                                  ),
                                if (fullProduct.directions.isNotEmpty)
                                  DirectionsSection(
                                    directions: fullProduct.directions,
                                    lang: lang,
                                    speciesList:
                                        ref.watch(speciesProvider).value ?? [],
                                    targetGroupsList:
                                        ref.watch(targetGroupsProvider).value ??
                                        [],
                                  ),
                                if (fullProduct.precautions.isNotEmpty)
                                  PrecautionsSection(
                                    precautions: fullProduct.precautions,
                                    lang: lang,
                                  ),
                                PresentationsSection(
                                  presentations: fullProduct.presentations,
                                  lang: lang,
                                ),
                                if (fullProduct.manufacturer.nameEn.isNotEmpty)
                                  ManufacturerSection(
                                    manufacturer: fullProduct.manufacturer,
                                    lang: lang,
                                  ),
                              ],
                            ),
                            orElse: () => const SizedBox.shrink(),
                          ),
                      const SizedBox(height: 16),
                      // Footer watermark
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Shared from Impulse Mobile App',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context, ColorScheme colorScheme) {
    final imagePath = widget.product.fullImageUrl;
    if (imagePath == null) {
      return ColoredBox(
        color: colorScheme.primaryContainer,
        child: Icon(
          Icons.medication,
          size: 80,
          color: colorScheme.onPrimaryContainer,
        ),
      );
    }

    return Container(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(12),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (ctx, err, stackTrace) => ColoredBox(
          color: colorScheme.primaryContainer,
          child: Icon(
            Icons.medication,
            size: 80,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
