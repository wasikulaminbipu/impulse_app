import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:impulse_dex/providers/paginated_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class PaginatedListScaffold<T> extends ConsumerStatefulWidget {
  final String title;
  final String searchHint;
  final ProviderListenable<AsyncValue<PaginatedState<T>>> provider;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCleared;
  final void Function() fetchNextPage;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? skeletonBuilder;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? emptyWidget;

  const PaginatedListScaffold({
    super.key,
    required this.title,
    required this.searchHint,
    required this.provider,
    required this.fetchNextPage,
    required this.itemBuilder,
    this.onSearchChanged,
    this.onSearchCleared,
    this.skeletonBuilder,
    this.bottom,
    this.actions,
    this.emptyWidget,
  });

  @override
  ConsumerState<PaginatedListScaffold<T>> createState() =>
      _PaginatedListScaffoldState<T>();
}

class _PaginatedListScaffoldState<T>
    extends ConsumerState<PaginatedListScaffold<T>> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchTextChange);
  }

  void _onSearchTextChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _searchController.removeListener(_onSearchTextChange);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(widget.provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.actions,
        bottom:
            widget.bottom ??
            (widget.onSearchChanged != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          if (widget.onSearchChanged != null) {
                            widget.onSearchChanged!(val);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: widget.searchHint,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    if (widget.onSearchCleared != null) {
                                      widget.onSearchCleared!();
                                    } else if (widget.onSearchChanged != null) {
                                      widget.onSearchChanged!('');
                                    }
                                  },
                                )
                              : null,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  )
                : null),
      ),
      body: asyncValue.when(
        data: (state) {
          final items = state.items;
          if (items.isEmpty) {
            return widget.emptyWidget ??
                const Center(child: Text('No items found'));
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: items.length + (state.hasMore ? 1 : 0),
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 74,
            ),
            itemBuilder: (context, index) {
              if (index == items.length) {
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
              return widget.itemBuilder(context, items[index], index);
            },
          );
        },
        loading: () => ListView.builder(
          itemCount: 8,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) => widget.skeletonBuilder != null
              ? widget.skeletonBuilder!(context, index)
              : const SizedBox(height: 100, child: Card()),
        ),
        error: (err, _) => Center(child: Text(err.toString())),
      ),
    );
  }
}
