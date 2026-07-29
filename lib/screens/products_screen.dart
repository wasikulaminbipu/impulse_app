import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/products_provider.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/widgets/product_card.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Poultry',
    'Cattle',
    'Aqua',
    'Feed Additives',
    'Vaccines',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.health_and_safety_outlined,
              size: 28,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Text(
              // lang == 'bn' ? 'ইমপালস প্রডাক্টস' : 'Impulse Products',
              'Impulse Dex',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          IconButton(
            icon: Text(
              lang == 'bn' ? 'EN' : 'বাংলা',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            onPressed: () =>
                ref.read(languageSettingProvider.notifier).toggle(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => ref
                      .read(productSearchQueryProvider.notifier)
                      .updateQuery(val),
                  decoration: InputDecoration(
                    hintText: lang == 'bn'
                        ? 'প্রোডাক্ট খুঁজুন...'
                        : 'Search products...',
                    prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(productSearchQueryProvider.notifier)
                                  .updateQuery('');
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.7,
                ),
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent, // Remove default border
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs: _categories
                    .map(
                      (c) => Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(c),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories
            .map((c) => _CategoryProductList(category: c))
            .toList(),
      ),
    );
  }
}

class _CategoryProductList extends ConsumerStatefulWidget {
  final String category;
  const _CategoryProductList({required this.category});

  @override
  ConsumerState<_CategoryProductList> createState() =>
      _CategoryProductListState();
}

class _CategoryProductListState extends ConsumerState<_CategoryProductList> {
  final ScrollController _scrollController = ScrollController();
  final Set<int> _animatedItems = {};

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
        _scrollController.position.maxScrollExtent - 300) {
      ref
          .read(paginatedCategoryProductsProvider(widget.category).notifier)
          .fetchNextPage();
    }
    if (_animatedItems.length > 500) {
      _animatedItems.clear(); // prevent memory leak over long scrolling
    }
  }

  @override
  Widget build(BuildContext context) {
    final paginatedAsync = ref.watch(
      paginatedCategoryProductsProvider(widget.category),
    );
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);

    return paginatedAsync.when(
      data: (state) {
        final products = state.items;
        if (products.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lang == 'bn'
                        ? 'কোনো প্রোডাক্ট পাওয়া যায়নি'
                        : 'No products found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lang == 'bn'
                        ? 'অনুগ্রহ করে কিওয়ার্ড পরিবর্তন করুন অথবা অন্য কোনো ক্যাটাগরি নির্বাচন করুন।'
                        : 'Try modifying your search or select another category.',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: products.length + (state.hasMore ? 1 : 0),
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: 84,
          ),
          itemBuilder: (context, index) {
            if (index == products.length) {
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
            final product = products[index];
            final bool hasAnimated = _animatedItems.contains(product.id);
            if (!hasAnimated) {
              _animatedItems.add(product.id);
              return _AnimatedProductCard(
                index: index,
                product: product,
                lang: lang,
              );
            } else {
              return RepaintBoundary(
                child: ProductCard(
                  key: ValueKey(product.id),
                  product: product,
                  lang: lang,
                ),
              );
            }
          },
        );
      },
      loading: () => ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.only(top: 8, bottom: 84),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => const ProductCardSkeleton(),
      ),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                '$err',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedProductCard extends StatefulWidget {
  final int index;
  final ProductLabel product;
  final String lang;

  const _AnimatedProductCard({
    required this.index,
    required this.product,
    required this.lang,
  });

  @override
  State<_AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<_AnimatedProductCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        ((widget.index % 20) * 0.05).clamp(0.0, 0.6),
        1.0,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 25 * (1.0 - _animation.value)),
            child: child,
          );
        },
        child: RepaintBoundary(
          child: ProductCard(
            key: ValueKey(widget.product.id),
            product: widget.product,
            lang: widget.lang,
          ),
        ),
      ),
    );
  }
}
