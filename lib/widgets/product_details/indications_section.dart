import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class IndicationsSection extends StatelessWidget {
  final List<Indication> indications;
  final String lang;

  const IndicationsSection({super.key, required this.indications, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: lang == 'bn' ? 'নির্দেশনা' : 'Indications',
      icon: Icons.healing,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: indications
            .map(
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(i.textEn.resolve(i.textBn, lang)),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
