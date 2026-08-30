import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_app/models/app_maintenance.dart';
import 'package:impulse_app/providers/app_maintenance_provider.dart';
import 'package:impulse_app/providers/products_provider.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  final int refId;
  final FavoriteType type;
  final Color? color;
  final Color? activeColor;
  final double? size;

  const FavoriteButton({
    super.key,
    required this.refId,
    required this.type,
    this.color,
    this.activeColor,
    this.size,
  });

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.35),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.35, end: 1.0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFav = switch (widget.type) {
      FavoriteType.product => ref.watch(
        productFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(widget.refId)) ??
              false;
        }),
      ),
      FavoriteType.distributor => ref.watch(
        distributorFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(widget.refId)) ??
              false;
        }),
      ),
      FavoriteType.salesPersonnel => ref.watch(
        salesPersonnelFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(widget.refId)) ??
              false;
        }),
      ),
      FavoriteType.vetDoctor => ref.watch(
        vetDoctorFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(widget.refId)) ??
              false;
        }),
      ),
    };

    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            key: ValueKey<bool>(isFav),
            size: widget.size ?? 24,
            color: isFav
                ? (widget.activeColor ?? Colors.red)
                : (widget.color ?? Colors.grey),
          ),
        ),
        onPressed: () {
          _controller.forward(from: 0.0);
          HapticFeedback.mediumImpact();
          ref
              .read(favoriteToggleProvider.notifier)
              .toggle(widget.type, widget.refId);
        },
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
