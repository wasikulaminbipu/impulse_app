import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/products_provider.dart';

import 'package:impulse_dex/widgets/custom_badge.dart';
import 'package:impulse_dex/widgets/group_logo_viewer.dart';
import 'package:impulse_dex/widgets/favorite_button.dart';
import 'package:impulse_dex/screens/sales_personnels_screen.dart';
import 'package:impulse_dex/utils/bilingual_string.dart';
import 'package:impulse_dex/utils/product_share_service.dart';

import 'package:impulse_dex/widgets/product_details/composition_section.dart';
import 'package:impulse_dex/widgets/product_details/indications_section.dart';
import 'package:impulse_dex/widgets/product_details/directions_section.dart';
import 'package:impulse_dex/widgets/product_details/precautions_section.dart';
import 'package:impulse_dex/widgets/product_details/presentations_section.dart';
import 'package:impulse_dex/widgets/product_details/manufacturer_section.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductLabel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final GlobalKey _shareBoundaryKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _handleShare(String title) async {
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
            content: Text('Failed to share product: $e'),
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);
    final productTitle =
        widget.product.titleEn.resolve(widget.product.titleBn, lang);

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
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.2),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                        child: Container(
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
                                : () => _handleShare(productTitle),
                            tooltip: lang == 'bn' ? 'শেয়ার করুন' : 'Share',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
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
                          CustomBadge(
                            color: Colors.teal,
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            text: widget.product.categoryId != 0
                                ? widget.product.category.nameEn
                                    .resolve(widget.product.category.nameBn, lang)
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
                          widget.product.mottoEn
                              .resolve(widget.product.mottoBn, lang),
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
                              widget.product.shortDescriptionBn, lang),
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ref.watch(productDetailProvider(widget.product.id)).when(
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
                                if (fullProduct.indications.isNotEmpty)
                                  IndicationsSection(
                                      indications: fullProduct.indications,
                                      lang: lang),
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
                                      lang: lang),
                                if (fullProduct.presentations.isNotEmpty)
                                  PresentationsSection(
                                      presentations: fullProduct.presentations,
                                      lang: lang),
                                if (fullProduct.manufacturer.nameEn.isNotEmpty)
                                  ManufacturerSection(
                                      manufacturer: fullProduct.manufacturer,
                                      lang: lang),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SalesPersonnelsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.people),
                          label: Text(
                            lang == 'bn' ? 'ফিল্ড টিম খুঁজুন' : 'Find Field Team',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'IMPULSE DEX',
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
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Product Image Container
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          color: colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          padding: const EdgeInsets.all(12),
                          child: _buildProductImage(context, colorScheme),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Badges and Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBadge(
                            color: Colors.teal,
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            text: widget.product.categoryId != 0
                                ? widget.product.category.nameEn
                                    .resolve(widget.product.category.nameBn, lang)
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
                          widget.product.mottoEn
                              .resolve(widget.product.mottoBn, lang),
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
                              widget.product.shortDescriptionBn, lang),
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // Details Sections
                      ref.watch(productDetailProvider(widget.product.id)).maybeWhen(
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
                                if (fullProduct.indications.isNotEmpty)
                                  IndicationsSection(
                                      indications: fullProduct.indications,
                                      lang: lang),
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
                                      lang: lang),
                                if (fullProduct.presentations.isNotEmpty)
                                  PresentationsSection(
                                      presentations: fullProduct.presentations,
                                      lang: lang),
                                if (fullProduct.manufacturer.nameEn.isNotEmpty)
                                  ManufacturerSection(
                                      manufacturer: fullProduct.manufacturer,
                                      lang: lang),
                              ],
                            ),
                            orElse: () => const SizedBox.shrink(),
                          ),
                      const SizedBox(height: 16),
                      // Footer watermark
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield_outlined,
                                size: 16, color: colorScheme.primary),
                            const SizedBox(width: 6),
                            Text(
                              'Shared from Impulse Dex Mobile App',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
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
      return Container(
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
        errorBuilder: (ctx, err, stackTrace) => Container(
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

