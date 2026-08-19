import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupLogoViewer extends StatelessWidget {
  final List<String> groupLogos;
  const GroupLogoViewer({super.key, required this.groupLogos});

  @override
  Widget build(BuildContext context) {
    final validLogos = groupLogos.where((logo) => logo.trim().isNotEmpty).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: validLogos.map((logo) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: SvgPicture.asset(
            'assets/icons/$logo.svg',
            colorFilter: Theme.of(context).brightness == Brightness.dark
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
          ),
        );
      }).toList(),
    );
  }
}

