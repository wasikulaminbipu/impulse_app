import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impulse_dex/models/distributor.dart';
import 'package:impulse_dex/models/app_maintenance.dart';
import 'package:impulse_dex/providers/app_maintenance_provider.dart';
import 'package:impulse_dex/providers/stakeholder_provider.dart';
import 'package:impulse_dex/widgets/skeleton_loader.dart';
import 'package:impulse_dex/widgets/favorite_button.dart';
import 'package:impulse_dex/utils/bilingual_string.dart';

import 'package:impulse_dex/widgets/paginated_list_scaffold.dart';
import 'package:impulse_dex/widgets/animated_list_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SalesPersonnelsScreen extends ConsumerWidget {
  const SalesPersonnelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageSettingProvider);

    return PaginatedListScaffold<SalesPersonnelWithAreas>(
      title: lang == 'bn' ? 'প্রতিনিধি তালিকা' : 'Representatives List',
      searchHint: lang == 'bn'
          ? 'প্রতিনিধি খুঁজুন...'
          : 'Search representative...',
      provider: paginatedSalesPersonnelProvider,
      onSearchChanged: (val) => ref
          .read(salesPersonnelSearchQueryProvider.notifier)
          .updateQuery(val),
      fetchNextPage: () =>
          ref.read(paginatedSalesPersonnelProvider.notifier).fetchNextPage(),
      skeletonBuilder: (context, index) => const DistributorCardSkeleton(),
      emptyWidget: Center(
        child: Text(
          lang == 'bn' ? 'কোনো তথ্য পাওয়া যায়নি' : 'No representatives found',
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
      itemBuilder: (context, p, index) {
        return AnimatedListItem(
          index: index,
          child: _SalesPersonnelCard(personnelWithAreas: p, lang: lang),
        );
      },
    );
  }
}

class _SalesPersonnelCard extends StatelessWidget {
  final SalesPersonnelWithAreas personnelWithAreas;
  final String lang;
  const _SalesPersonnelCard({required this.personnelWithAreas, required this.lang});

  @override
  Widget build(BuildContext context) {
    final personnel = personnelWithAreas.personnel;
    final areas = personnelWithAreas.areas;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (personnel.photoUrl != null && personnel.photoUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                          personnel.photoUrl!.startsWith('assets/') 
                              ? personnel.photoUrl! 
                              : 'assets/images/${personnel.photoUrl}',
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          personnel.nameEn.resolve(personnel.nameBn, lang),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        if (personnel.designation != null)
                          Text(
                            personnel.designation!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),
                        const SizedBox(height: 8),
                        if (areas.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  areas.map((a) => (a.nameEn.resolve(a.nameBn, lang))).join(', '),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        if (personnel.mobile != null && personnel.mobile!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            personnel.mobile!,
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
                    refId: personnel.id,
                    type: FavoriteType.salesPersonnel,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () async {
                      if (personnel.mobile != null && personnel.mobile!.isNotEmpty) {
                        final Uri uri = Uri.parse('tel:${personnel.mobile}');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }
                    },
                    icon: const Icon(Icons.call, size: 18),
                    label: Text(lang == 'bn' ? 'কল করুন' : 'Call'),
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () async {
                      try {
                        final newContact = Contact(
                          name: Name(first: personnel.nameEn.resolve(personnel.nameBn, lang)),
                          phones: [Phone(number: personnel.mobile ?? '')],
                          organizations: [
                            Organization(
                              name: 'Impulse',
                              jobTitle: personnel.designation ?? '',
                            )
                          ],
                        );
                        await FlutterContacts.native.showCreator(contact: newContact);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.person_add, size: 18),
                    label: Text(lang == 'bn' ? 'সেভ করুন' : 'Save'),
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
