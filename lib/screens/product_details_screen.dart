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

import 'package:impulse_dex/widgets/product_details/composition_section.dart';
import 'package:impulse_dex/widgets/product_details/indications_section.dart';
import 'package:impulse_dex/widgets/product_details/directions_section.dart';
import 'package:impulse_dex/widgets/product_details/precautions_section.dart';
import 'package:impulse_dex/widgets/product_details/presentations_section.dart';
import 'package:impulse_dex/widgets/product_details/manufacturer_section.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductLabel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);

    return Scaffold(
      body: CustomScrollView(
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
                      child: FavoriteButton(
                        refId: product.id,
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
                    tag: 'product-image-${product.id}',
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
                        text: product.categoryId != 0
                            ? product.category.nameEn.resolve(product.category.nameBn, lang).toUpperCase()
                            : '',
                      ),
                      GroupLogoViewer(
                        groupLogos: product.targetGroups
                            .map((e) => e.iconName ?? "")
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.titleEn.resolve(product.titleBn, lang),
                    style: const TextStyle(
                      fontSize: 28, // slightly larger
                      fontWeight: FontWeight.w800, // bolder
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  if (lang == 'bn' ? product.mottoBn != null : product.mottoEn != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      product.mottoEn.resolve(product.mottoBn, lang),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary, // use primary color for motto
                      ),
                    ),
                  ],
                  if (lang == 'bn' ? product.shortDescriptionBn != null : product.shortDescriptionEn != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      product.shortDescriptionEn.resolve(product.shortDescriptionBn, lang),
                      style: TextStyle(
                        fontSize: 15, 
                        height: 1.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ref.watch(productDetailProvider(product.id)).when(
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
                              IndicationsSection(indications: fullProduct.indications, lang: lang),
                            if (fullProduct.directions.isNotEmpty)
                              DirectionsSection(
                                directions: fullProduct.directions,
                                lang: lang,
                                speciesList: ref.watch(speciesProvider).value ?? [],
                                targetGroupsList: ref.watch(targetGroupsProvider).value ?? [],
                              ),
                            if (fullProduct.precautions.isNotEmpty)
                              PrecautionsSection(precautions: fullProduct.precautions, lang: lang),
                            if (fullProduct.presentations.isNotEmpty)
                              PresentationsSection(presentations: fullProduct.presentations, lang: lang),
                            if (fullProduct.manufacturer.nameEn.isNotEmpty)
                              ManufacturerSection(manufacturer: fullProduct.manufacturer, lang: lang),
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
                            builder: (context) => const SalesPersonnelsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people),
                      label: Text(
                        lang == 'bn' ? 'প্রতিনিধিদের সাথে যোগাযোগ করুন' : 'Contact Representatives',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18), // taller button
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
    );
  }

  Widget _buildProductImage(BuildContext context, ColorScheme colorScheme) {
    final imagePath = product.fullImageUrl;
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

