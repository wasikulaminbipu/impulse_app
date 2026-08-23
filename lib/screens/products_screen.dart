import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:impulse_dex/constants/app_assets.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/products_provider.dart';
import 'package:impulse_dex/providers/search_history_provider.dart';
import 'package:impulse_dex/widgets/product_card.dart';
import 'package:impulse_dex/widgets/privacy_policy_dialog.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchTextChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _onSearchTextChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchController.removeListener(_onSearchTextChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchHistoryChips(
      BuildContext context, WidgetRef ref, String lang) {
    if (!_searchFocusNode.hasFocus) {
      return const SizedBox.shrink();
    }

    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final suggestionsAsync = ref.watch(productSearchTrieSuggestionsProvider);
      return suggestionsAsync.when(
        data: (items) {
          if (items.isEmpty) return const SizedBox.shrink();
          return SizedBox(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final term = items[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ActionChip(
                    avatar: Icon(Icons.auto_awesome, size: 14, color: Theme.of(context).colorScheme.primary),
                    label: Text(
                      term,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      _searchController.text = term;
                      ref
                          .read(productSearchQueryProvider.notifier)
                          .updateQuery(term);
                      ref.read(searchHistoryProvider.notifier).addQuery(term);
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (e, s) => const SizedBox.shrink(),
      );
    }

    final historyAsync = ref.watch(searchHistoryProvider);
    return historyAsync.when(
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return SizedBox(
          height: 32,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final term = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ActionChip(
                  avatar: const Icon(Icons.history, size: 14),
                  label: Text(
                    term,
                    style: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    _searchController.text = term;
                    ref
                        .read(productSearchQueryProvider.notifier)
                        .updateQuery(term);
                  },
                ),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }

  void _onCategoryTap(String categoryName) {
    _searchController.text = categoryName;
    ref.read(productSearchQueryProvider.notifier).updateQuery(categoryName);
    if (categoryName.trim().isNotEmpty) {
      ref.read(searchHistoryProvider.notifier).addQuery(categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lang = ref.watch(languageSettingProvider);
    final history = ref.watch(searchHistoryProvider).value ?? [];
    final trieSuggestions = ref.watch(productSearchTrieSuggestionsProvider).value ?? [];
    final categoriesAsync = ref.watch(availableCategoriesProvider);
    final categories = categoriesAsync.value ?? const ['All'];
    final bool showChips = _searchFocusNode.hasFocus &&
        (_searchController.text.trim().isNotEmpty ? trieSuggestions.isNotEmpty : history.isNotEmpty);

    return DefaultTabController(
      key: ValueKey(categories.join(',')),
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: 32,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.inventory_2, size: 32),
                ),
                const SizedBox(width: 10),
                Text(
                  'Impulse Dex',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                if (ref.watch(productSearchQueryProvider).isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_rounded, size: 12, color: colorScheme.onPrimaryContainer),
                        const SizedBox(width: 4),
                        Text(
                          lang == 'bn' ? 'ফিল্টার' : 'Active',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline_rounded, size: 20),
              tooltip: 'Privacy Policy & Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const PrivacyPolicyDialog(),
                );
              },
            ),
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
            preferredSize: Size.fromHeight(showChips ? 140 : 102),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 2, 16, 6),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: (val) => ref
                        .read(productSearchQueryProvider.notifier)
                        .updateQuery(val),
                    onSubmitted: (val) async {
                      if (val.trim().isNotEmpty) {
                        ref.read(searchHistoryProvider.notifier).addQuery(val);
                        final dao = await ref.read(appMaintenanceDaoProvider.future);
                        final currentItems = ref.read(paginatedCategoryProductsProvider('All')).value?.items.length ?? 0;
                        await dao.logSearchEvent(val, currentItems);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: lang == 'bn'
                          ? 'প্রোডাক্ট, উপসর্গ, উপাদান খুঁজুন...'
                          : 'Search products, symptoms, ingredients...',
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
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
                      fillColor: colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.4),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color:
                              colorScheme.outlineVariant.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color:
                              colorScheme.outlineVariant.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                _buildSearchHistoryChips(context, ref, lang),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: colorScheme.primary,
                    unselectedLabelColor:
                        colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    indicatorColor: colorScheme.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 14),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      letterSpacing: 0.2,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.5,
                    ),
                    tabs: categories
                        .map(
                          (c) => Tab(
                            height: 36,
                            text: c,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            return _ProductCategoryTab(
              category: category,
              onCategoryTap: _onCategoryTap,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ProductCategoryTab extends ConsumerWidget {
  final String category;
  final void Function(String categoryName)? onCategoryTap;

  const _ProductCategoryTab({
    required this.category,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(productSearchQueryProvider);
    final lang = ref.watch(languageSettingProvider);
    final productsAsync = ref.watch(paginatedCategoryProductsProvider(category));

    return productsAsync.when(
      data: (state) {
        final products = state.items;
        if (products.isEmpty) {
          final suggestionsAsync = ref.watch(productSearchFuzzySuggestionsProvider);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 12),
                Text(
                  lang == 'bn' ? 'কোনো প্রোডাক্ট পাওয়া যায়নি' : 'No products found',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
                if (searchQuery.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  suggestionsAsync.maybeWhen(
                    data: (suggestions) {
                      if (suggestions.isEmpty) return const SizedBox.shrink();
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lang == 'bn' ? 'আপনি কি বোঝাতে চেয়েছেন:' : 'Did you mean:',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: suggestions.map((suggestion) {
                              return ActionChip(
                                avatar: Icon(
                                  Icons.search,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                label: Text(
                                  suggestion,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                onPressed: () {
                                  if (onCategoryTap != null) {
                                    onCategoryTap!(suggestion);
                                  } else {
                                    ref
                                        .read(productSearchQueryProvider.notifier)
                                        .updateQuery(suggestion);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          );
        }

        final animatedItems = <int>{};
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 300) {
              ref
                  .read(paginatedCategoryProductsProvider(category).notifier)
                  .fetchNextPage();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: products.length + (state.hasMore ? 1 : 0),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 74),
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
              final bool hasAnimated = animatedItems.contains(product.id);
              if (!hasAnimated) {
                animatedItems.add(product.id);
                return _AnimatedProductCard(
                  index: index,
                  product: product,
                  lang: lang,
                  searchQuery: searchQuery,
                  onCategoryTap: onCategoryTap,
                );
              } else {
                return RepaintBoundary(
                  child: ProductCard(
                    key: ValueKey(product.id),
                    product: product,
                    lang: lang,
                    searchQuery: searchQuery,
                    onCategoryTap: onCategoryTap,
                  ),
                );
              }
            },
          ),
        );
      },
      loading: () => ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.only(top: 8, bottom: 74),
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
  final String searchQuery;
  final void Function(String categoryName)? onCategoryTap;

  const _AnimatedProductCard({
    required this.index,
    required this.product,
    required this.lang,
    required this.searchQuery,
    this.onCategoryTap,
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
            searchQuery: widget.searchQuery,
            onCategoryTap: widget.onCategoryTap,
          ),
        ),
      ),
    );
  }
}
