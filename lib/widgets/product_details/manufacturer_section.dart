import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/bilingual_string.dart';
import 'package:impulse_app/screens/manufacturer_details_screen.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class ManufacturerSection extends StatelessWidget {
  final Manufacturer manufacturer;
  final String lang;

  const ManufacturerSection({super.key, required this.manufacturer, required this.lang});

  @override
  Widget build(BuildContext context) {
    final addressText = manufacturer.addressEn.resolve(manufacturer.addressBn, lang);

    return SectionCard(
      title: lang == 'bn' ? 'প্রস্তুতকারক' : 'Manufacturer',
      icon: Icons.factory,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => ManufacturerDetailsScreen(manufacturer: manufacturer),
          ),
        ),
        child: Row(
          children: [
            if (manufacturer.logoUrl != null && manufacturer.logoUrl!.isNotEmpty) ...[
              const SizedBox(width: 8),
              Image.asset(
                'assets/manufacturers_logo/${manufacturer.logoUrl}',
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ],
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manufacturer.nameEn.resolve(manufacturer.nameBn, lang),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (addressText.isNotEmpty)
                    Text(
                      addressText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
