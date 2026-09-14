import 'package:flutter/material.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/screens/sales_personnels_screen.dart';
import 'package:impulse_app/widgets/product_details/section_card.dart';

class PresentationsSection extends StatelessWidget {
  final List<Presentation> presentations;
  final String lang;
  final VoidCallback? onCallForPriceTap;

  const PresentationsSection({
    super.key,
    required this.presentations,
    required this.lang,
    this.onCallForPriceTap,
  });

  void _navigateToContacts(BuildContext context) {
    if (onCallForPriceTap != null) {
      onCallForPriceTap!();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const SalesPersonnelsScreen(),
        ),
      );
    }
  }

  Widget _buildCallForPriceLink(BuildContext context) {
    final theme = Theme.of(context);
    final isBn = lang == 'bn';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToContacts(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone_in_talk_rounded,
                size: 13,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                isBn ? 'মূল্যের জন্য কল করুন' : 'Call for Price',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBn = lang == 'bn';

    if (presentations.isEmpty) {
      return SectionCard(
        title: isBn ? 'প্যাক সাইজ ও মূল্য' : 'Presentation & MRP',
        icon: Icons.inventory_2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBn ? 'মূল্য অপ্রাপ্য' : 'Price unlisted',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _buildCallForPriceLink(context),
            ],
          ),
        ),
      );
    }

    return SectionCard(
      title: isBn ? 'প্যাক সাইজ ও মূল্য' : 'Presentation & MRP',
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
                    if (p.mrp != null && p.mrp! > 0)
                      Text(
                        'MRP: ৳${p.mrp!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      )
                    else
                      _buildCallForPriceLink(context),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
