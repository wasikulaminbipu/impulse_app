import 'package:flutter/material.dart';
import 'package:impulse_dex/models/product.dart';
import 'package:impulse_dex/widgets/product_details/section_card.dart';

class PresentationsSection extends StatelessWidget {
  final List<Presentation> presentations;
  final String lang;

  const PresentationsSection({super.key, required this.presentations, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: lang == 'bn' ? 'প্যাক সাইজ ও মূল্য' : 'Presentation & MRP',
      icon: Icons.inventory_2,
      child: Column(
        children: presentations
            .map(
              (p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.size ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    if (p.mrp != null)
                      Text(
                        'MRP: ৳${p.mrp!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
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
