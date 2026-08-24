import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/products_provider.dart';


import 'package:impulse_dex/screens/manufacturer_details_screen.dart';
import 'package:impulse_dex/widgets/paginated_list_scaffold.dart';
import 'package:impulse_dex/widgets/animated_list_item.dart';
import 'package:impulse_dex/widgets/asset_fallback_image.dart';

class ManufacturersScreen extends ConsumerWidget {
  const ManufacturersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageSettingProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return PaginatedListScaffold<Manufacturer>(
      title: lang == 'bn' ? 'প্রস্তুতকারক তালিকা' : 'Manufacturers List',
      searchHint: lang == 'bn'
          ? 'প্রস্তুতকারক খুঁজুন...'
          : 'Search manufacturers...',
      provider: paginatedManufacturersProvider,
      onSearchChanged: (val) => ref
          .read(manufacturersSearchQueryProvider.notifier)
          .updateQuery(val),
      fetchNextPage: () =>
          ref.read(paginatedManufacturersProvider.notifier).fetchNextPage(),
      emptyWidget: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.business_outlined,
                size: 80,
                color: colorScheme.primary.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              Text(
                lang == 'bn'
                    ? 'কোনো প্রস্তুতকারক পাওয়া যায়নি'
                    : 'No manufacturers found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
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
      itemBuilder: (context, m, index) {
        return AnimatedListItem(
          index: index,
          child: _ManufacturerCard(manufacturer: m, lang: lang),
        );
      },
    );
  }
}

class _ManufacturerCard extends StatelessWidget {
  final Manufacturer manufacturer;
  final String lang;

  const _ManufacturerCard({
    required this.manufacturer,
    required this.lang,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final name = lang == 'bn'
        ? (manufacturer.nameBn ?? manufacturer.nameEn)
        : manufacturer.nameEn;
    final address = lang == 'bn'
        ? (manufacturer.addressBn ?? manufacturer.addressEn)
        : manufacturer.addressEn;
    final country = lang == 'bn'
        ? (manufacturer.countryOfOriginBn ?? manufacturer.countryOfOriginEn)
        : manufacturer.countryOfOriginEn;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.45 : 0.65,
          ),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark ? 0.25 : 0.06,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) =>
                      ManufacturerDetailsScreen(manufacturer: manufacturer),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'manufacturer-logo-${manufacturer.id}',
                  child: _buildLogoImage(colorScheme),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (address != null && address.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 15,
                                color: colorScheme.primary.withValues(alpha: 0.8),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (country != null && country.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.public,
                                size: 15,
                                color: colorScheme.primary.withValues(alpha: 0.8),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  '${lang == 'bn' ? 'উৎপত্তি দেশ' : 'Origin'}: $country',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoImage(ColorScheme colorScheme) {
    return AssetFallbackImage(
      imagePath: manufacturer.logoUrl?.isNotEmpty == true
          ? 'assets/manufacturers_logo/${manufacturer.logoUrl}'
          : null,
      width: 100,
      height: 110,
      fallbackIcon: Icons.business,
      fit: BoxFit.contain,
    );
  }
}
