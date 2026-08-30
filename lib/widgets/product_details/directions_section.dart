import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class DirectionsSection extends StatelessWidget {
  final List<Direction> directions;
  final String lang;
  final List<Species> speciesList;
  final List<TargetGroup> targetGroupsList;

  const DirectionsSection({
    super.key,
    required this.directions,
    required this.lang,
    required this.speciesList,
    required this.targetGroupsList,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: lang == 'bn' ? 'মাত্রা ও প্রয়োগবিধি' : 'Dosage & Administration',
      icon: Icons.medication,
      child: Builder(
        builder: (context) {
          final Map<int, List<Direction>> directionsByTgId = {};
          for (final d in directions) {
            final spec = speciesList.firstWhere(
              (s) => s.id == d.speciesId,
              orElse: () => const Species(id: 0, targetGroupId: 0, nameEn: ''),
            );
            final tgId = spec.id != 0 ? spec.targetGroupId : 0;
            directionsByTgId.putIfAbsent(tgId, () => []).add(d);
          }

          final List<Widget> directionWidgets = [];

          for (final tg in targetGroupsList) {
            final dirs = directionsByTgId[tg.id];
            if (dirs == null || dirs.isEmpty) {
              continue;
            }

            directionWidgets.add(
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  tg.nameEn.resolve(tg.nameBn, lang),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            );

            for (final d in dirs) {
              final spec = speciesList.firstWhere(
                (s) => s.id == d.speciesId,
                orElse: () =>
                    const Species(id: 0, targetGroupId: 0, nameEn: ''),
              );
              final specName = spec.id != 0
                  ? spec.nameEn.resolve(spec.nameBn, lang)
                  : '';
              final dosageText = d.dosageEn.resolve(d.dosageBn, lang);

              if (dosageText.isNotEmpty) {
                directionWidgets.add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      specName.isNotEmpty
                          ? '$specName: $dosageText'
                          : dosageText,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }

              final adminText = d.administrationEn.resolve(
                d.administrationBn,
                lang,
              );
              if (adminText.isNotEmpty) {
                directionWidgets.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${lang == 'bn' ? 'প্রয়োগ' : 'Administration'}: $adminText',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              }
            }
          }

          final unknownDirs = directionsByTgId[0];
          if (unknownDirs != null && unknownDirs.isNotEmpty) {
            for (final d in unknownDirs) {
              final dosageText = d.dosageEn.resolve(d.dosageBn, lang);
              if (dosageText.isNotEmpty) {
                directionWidgets.add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(dosageText),
                  ),
                );
              }
              final adminText = d.administrationEn.resolve(
                d.administrationBn,
                lang,
              );
              if (adminText.isNotEmpty) {
                directionWidgets.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${lang == 'bn' ? 'প্রয়োগ' : 'Administration'}: $adminText',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              }
            }
          }

          bool isAquaProduct = false;
          for (final tg in targetGroupsList) {
            if (directionsByTgId.containsKey(tg.id)) {
              if (tg.nameEn.toLowerCase() == 'aqua') {
                isAquaProduct = true;
                break;
              }
            }
          }

          final String staticLineEn = isAquaProduct
              ? 'Or, as directed by Veterinarians or Aquaculturists.'
              : 'Or, as directed by Veterinarians.';

          final String staticLineBn = isAquaProduct
              ? 'অথবা, ভেটেরিনারি চিকিৎসক বা মৎস্য বিশেষজ্ঞের পরামর্শ অনুযায়ী।'
              : 'অথবা, ভেটেরিনারি চিকিৎসকের পরামর্শ অনুযায়ী।';

          final String staticLine = lang == 'bn' ? staticLineBn : staticLineEn;

          directionWidgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                staticLine,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: directionWidgets,
          );
        },
      ),
    );
  }
}
