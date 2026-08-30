import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';
import 'package:impulse_app/widgets/product_card.dart';

class ManufacturerDetailsScreen extends ConsumerStatefulWidget {
  final Manufacturer manufacturer;
  const ManufacturerDetailsScreen({super.key, required this.manufacturer});

  @override
  ConsumerState<ManufacturerDetailsScreen> createState() =>
      _ManufacturerDetailsScreenState();
}

class _ManufacturerDetailsScreenState
    extends ConsumerState<ManufacturerDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _displayedCount = 15;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      setState(() {
        _displayedCount += 15;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageSettingProvider);
    final productsAsync = ref.watch(
      productsByManufacturerProvider(widget.manufacturer.id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'bn'
              ? (widget.manufacturer.nameBn ?? widget.manufacturer.nameEn)
              : widget.manufacturer.nameEn,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      if (widget.manufacturer.logoUrl != null &&
                          widget.manufacturer.logoUrl!.isNotEmpty) ...[
                        Image.asset(
                          'assets/manufacturers_logo/${widget.manufacturer.logoUrl}',
                          height: 80,
                          width: 80,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        lang == 'bn'
                            ? (widget.manufacturer.nameBn ??
                                widget.manufacturer.nameEn)
                            : widget.manufacturer.nameEn,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      if (lang == 'bn'
                          ? widget.manufacturer.addressBn != null
                          : widget.manufacturer.addressEn != null)
                        _InfoRow(
                          icon: Icons.location_on,
                          text: (lang == 'bn'
                              ? widget.manufacturer.addressBn
                              : widget.manufacturer.addressEn)!,
                        ),
                      if (widget.manufacturer.email != null)
                        _InfoRow(
                          icon: Icons.email,
                          text: widget.manufacturer.email!,
                        ),
                      if (widget.manufacturer.website != null)
                        _InfoRow(
                          icon: Icons.language,
                          text: widget.manufacturer.website!,
                        ),
                      if (widget.manufacturer.mobile != null)
                        _InfoRow(
                          icon: Icons.phone,
                          text: widget.manufacturer.mobile!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                lang == 'bn' ? 'প্রডাক্ট তালিকা' : 'Product List',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          productsAsync.when(
            data: (products) {
              final currentItems = products.take(_displayedCount).toList();
              final hasMore = products.length > currentItems.length;

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == currentItems.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        ),
                      );
                    }
                    final product = currentItems[index];
                    return ProductCard(
                      product: product.toLabel(),
                      disableNavigation: true,
                      heroTagPrefix: 'manufacturer-',
                    );
                  }, childCount: currentItems.length + (hasMore ? 1 : 0)),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(child: Text(err.toString())),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
