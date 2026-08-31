import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/screens/product_details_screen.dart';
import 'package:impulse_app/theme/app_theme.dart';
import 'package:impulse_app/utils/app_constants.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/widgets/asset_fallback_image.dart';
import 'package:impulse_app/widgets/custom_badge.dart';
import 'package:impulse_app/widgets/favorite_button.dart';
import 'package:impulse_app/widgets/group_logo_viewer.dart';
import 'package:impulse_app/widgets/highlight_text.dart';

class ProductCard extends StatefulWidget {
  final ProductLabel product;
  final bool disableNavigation;
  final String lang;
  final String heroTagPrefix;
  final String searchQuery;
  final void Function(String categoryName)? onCategoryTap;

  const ProductCard({
    super.key,
    required this.product,
    this.disableNavigation = false,
    this.lang = 'en',
    this.heroTagPrefix = '',
    this.searchQuery = '',
    this.onCategoryTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.12)
                  : colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: Theme.of(context).brightness == Brightness.dark
                      ? 0.35
                      : 0.08,
                ),
                blurRadius: 16,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: widget.disableNavigation
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(
                          PageRouteBuilder<void>(
                            transitionDuration: const Duration(
                              milliseconds: 400,
                            ),
                            reverseTransitionDuration: const Duration(
                              milliseconds: 400,
                            ),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductDetailsScreen(
                                      product: widget.product,
                                    ),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 125,
                      child: Hero(
                        tag:
                            '${widget.heroTagPrefix}product-image-${widget.product.id}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: _buildProductImage(colorScheme),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Top Row (Badge + Favorite)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomBadge(
                                    color: _getCategoryColor(
                                      context,
                                      widget.product,
                                    ),
                                    text: widget.product.categoryId != 0
                                        ? widget.product.category.nameEn
                                              .resolve(
                                                widget.product.category.nameBn,
                                                widget.lang,
                                              )
                                        : '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    onTap:
                                        widget.onCategoryTap != null &&
                                            widget.product.categoryId != 0
                                        ? () {
                                            final catName = widget
                                                .product
                                                .category
                                                .nameEn
                                                .resolve(
                                                  widget
                                                      .product
                                                      .category
                                                      .nameBn,
                                                  widget.lang,
                                                );
                                            widget.onCategoryTap!(catName);
                                          }
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GroupLogoViewer(
                                  groupLogos: widget.product.targetGroups
                                      .map((e) => e.iconName ?? "")
                                      .toList(),
                                ),
                                FavoriteButton(
                                  refId: widget.product.id,
                                  type: FavoriteType.product,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            HighlightText(
                              text: widget.product.titleEn.resolve(
                                widget.product.titleBn,
                                widget.lang,
                              ),
                              query: widget.searchQuery,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            if (widget.product.shortDescriptionEn != null &&
                                widget.product.shortDescriptionEn!.isNotEmpty)
                              HighlightText(
                                text: widget.product.shortDescriptionEn!
                                    .resolve(
                                      widget.product.shortDescriptionBn,
                                      widget.lang,
                                    ),
                                query: widget.searchQuery,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: widget.product.presentations.map((
                                presentation,
                              ) {
                                return CustomBadge(
                                  text: presentation.size ?? '',
                                  color: colorScheme.surfaceContainerHighest,
                                  textStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFeatures: const [
                                      FontFeature.tabularFigures(),
                                    ],
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(4),
      child: AssetFallbackImage(
        imagePath: widget.product.fullImageUrl,
        width: double.infinity,
        height: double.infinity,
        fallbackIcon: Icons.medication,
        fit: BoxFit.contain,
      ),
    );
  }

  /// Get category name from product
  String _getCategoryName(ProductLabel product) {
    return product.category.nameEn;
  }

  Color _getCategoryColor(BuildContext context, ProductLabel product) {
    final categoryColors = Theme.of(context).extension<CategoryColors>();
    final defaultColor = categoryColors?.defaultCategoryColor ?? Colors.grey;
    final categoryName = _getCategoryName(product);

    if (categoryName.toLowerCase().contains(
      AppConstants.categoryFeedAdditive.toLowerCase(),
    )) {
      return categoryColors?.feedAdditiveColor ?? defaultColor;
    }
    if (categoryName.toLowerCase().contains(
      AppConstants.categoryVaccine.toLowerCase(),
    )) {
      return categoryColors?.vaccineColor ?? defaultColor;
    }

    final hasPoultry = product.targetGroups.any(
      (tg) =>
          tg.nameEn.toLowerCase() == AppConstants.categoryPoultry.toLowerCase(),
    );
    final hasCattle = product.targetGroups.any(
      (tg) =>
          tg.nameEn.toLowerCase() == AppConstants.categoryCattle.toLowerCase(),
    );
    final hasAqua = product.targetGroups.any(
      (tg) =>
          tg.nameEn.toLowerCase() == AppConstants.categoryAqua.toLowerCase(),
    );

    if (hasPoultry) {
      return categoryColors?.poultryColor ?? defaultColor;
    } else if (hasCattle) {
      return categoryColors?.cattleColor ?? defaultColor;
    } else if (hasAqua) {
      return categoryColors?.aquaColor ?? defaultColor;
    }

    switch (categoryName) {
      case AppConstants.categoryPoultry:
        return categoryColors?.poultryColor ?? defaultColor;
      case AppConstants.categoryCattle:
        return categoryColors?.cattleColor ?? defaultColor;
      case AppConstants.categoryAqua:
        return categoryColors?.aquaColor ?? defaultColor;
      case AppConstants.categoryFeedAdditives:
        return categoryColors?.feedAdditiveColor ?? defaultColor;
      case AppConstants.categoryVaccines:
        return categoryColors?.vaccineColor ?? defaultColor;
      default:
        return defaultColor;
    }
  }
}
