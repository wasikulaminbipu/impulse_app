import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class CompositionSection extends StatelessWidget {
  final List<Composition> compositions;
  final String lang;
  final String? basisEn;
  final String? basisBn;

  const CompositionSection({
    super.key,
    required this.compositions,
    required this.lang,
    this.basisEn,
    this.basisBn,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: lang == 'bn' ? 'উপাদান' : 'Composition',
      icon: Icons.biotech,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (basisEn != null && basisEn!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                lang == 'bn'
                    ? 'প্রতি ${basisBn?.isNotEmpty ?? false ? basisBn : basisEn} এ আছে:'
                    : 'Each $basisEn contains:',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ...compositions.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      c.ingredientEn.resolve(c.ingredientBn, lang),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (c.concentration != null)
                    Text(
                      c.concentration!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
