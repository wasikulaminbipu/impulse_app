import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/distributor.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/stakeholder_provider.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';
import 'package:impulse_dex/widgets/favorite_button.dart';
import 'package:impulse_dex/widgets/paginated_list_scaffold.dart';
import 'package:impulse_dex/widgets/animated_list_item.dart';
import 'package:impulse_dex/utils/bilingual_string.dart';

class DistributorsScreen extends ConsumerWidget {
  const DistributorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageSettingProvider);

    return PaginatedListScaffold<DistributorWithLocation>(
      title: lang == 'bn' ? 'ডিস্ট্রিবিউটর তালিকা' : 'Distributors List',
      searchHint: lang == 'bn'
          ? 'ডিস্ট্রিবিউটর বা এলাকা খুঁজুন...'
          : 'Search distributor or area...',
      provider: paginatedDistributorsProvider,
      onSearchChanged: (val) => ref
          .read(distributorSearchQueryProvider.notifier)
          .updateQuery(val),
      fetchNextPage: () =>
          ref.read(paginatedDistributorsProvider.notifier).fetchNextPage(),
      skeletonBuilder: (context, index) => const DistributorCardSkeleton(),
      emptyWidget: Center(
        child: Text(
          lang == 'bn' ? 'কোনো তথ্য পাওয়া যায়নি' : 'No distributors found',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            ref.read(languageSettingProvider.notifier).toggle();
          },
        ),
      ],
      itemBuilder: (context, d, index) {
        return AnimatedListItem(
          index: index,
          child: _DistributorCard(distributorWithLocation: d, lang: lang),
        );
      },
    );
  }
}

class _DistributorCard extends StatelessWidget {
  final DistributorWithLocation distributorWithLocation;
  final String lang;
  const _DistributorCard({required this.distributorWithLocation, required this.lang});

  @override
  Widget build(BuildContext context) {
    final distributor = distributorWithLocation.distributor;
    final area = distributorWithLocation.area;
    final region = distributorWithLocation.region;

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.45 : 0.65,
          ),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      distributor.nameEn.resolve(distributor.nameBn, lang),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    if (distributor.designation != null)
                      Text(
                        distributor.designation!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (lang == 'bn'
                        ? distributor.addressBn != null || area.nameBn != null
                        : distributor.addressEn != null)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _buildAddress(distributor, area, region, lang),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    if (distributor.mobile != null &&
                        distributor.mobile!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        distributor.mobile!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              FavoriteButton(
                refId: distributor.id,
                type: FavoriteType.distributor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildAddress(Distributor distributor, Area area, Region region, String lang) {
    final parts = <String>[];
    if (lang == 'bn') {
      if (distributor.addressBn != null) parts.add(distributor.addressBn!);
      parts.add(area.nameBn ?? area.nameEn);
      parts.add(region.nameBn ?? region.nameEn);
    } else {
      if (distributor.addressEn != null) parts.add(distributor.addressEn!);
      parts.add(area.nameEn);
      parts.add(region.nameEn);
    }
    return parts.join(', ');
  }
}
