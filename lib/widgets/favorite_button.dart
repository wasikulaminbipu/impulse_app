import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/products_provider.dart';

class FavoriteButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFav = switch (type) {
      FavoriteType.product => ref.watch(productFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(refId)) ?? false;
        })),
      FavoriteType.distributor => ref.watch(distributorFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(refId)) ?? false;
        })),
      FavoriteType.salesPersonnel => ref.watch(salesPersonnelFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(refId)) ?? false;
        })),
      FavoriteType.vetDoctor => ref.watch(vetDoctorFavoritesProvider.select((favs) {
          return favs.whenOrNull(data: (ids) => ids.contains(refId)) ?? false;
        })),
    };

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        size: size ?? 24,
        color: isFav ? (activeColor ?? Colors.red) : (color ?? Colors.grey),
      ),
      onPressed: () {
        ref.read(favoriteToggleProvider.notifier).toggle(type, refId);
      },
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
    );
  }
}
