import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class BenefitsSection extends StatelessWidget {
  final List<Benefit> benefits;
  final String lang;

  const BenefitsSection({
    super.key,
    required this.benefits,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    if (benefits.isEmpty) {
      return const SizedBox.shrink();
    }
    return SectionCard(
      title: lang == 'bn' ? 'উপকারিতা' : 'Benefits',
      icon: Icons.verified_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: benefits
            .map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Text(b.textEn.resolve(b.textBn, lang))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
