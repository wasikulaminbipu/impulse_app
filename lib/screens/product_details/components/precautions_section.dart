import 'package:flutter/material.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/utils/bilingual_string.dart';
import 'package:impulse_dex/screens/product_details/components/section_card.dart';

class PrecautionsSection extends StatelessWidget {
  final List<Precaution> precautions;
  final String lang;

  const PrecautionsSection({super.key, required this.precautions, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: lang == 'bn' ? 'সতর্কতা' : 'Precautions',
      icon: Icons.warning_amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: precautions
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(p.textEn.resolve(p.textBn, lang)),
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
