import 'package:flutter/material.dart';

class AssetFallbackImage extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final IconData fallbackIcon;
  final BoxFit fit;

  const AssetFallbackImage({
    super.key,
    this.imagePath,
    required this.width,
    required this.height,
    required this.fallbackIcon,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Widget fallback = Container(
      width: width,
      height: height,
      color: colorScheme.primaryContainer,
      child: Icon(
        fallbackIcon,
        size: 40,
        color: colorScheme.onPrimaryContainer,
      ),
    );

    if (imagePath == null || imagePath!.isEmpty) {
      return fallback;
    }

    return Image.asset(
      imagePath!,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (ctx, err, stackTrace) => fallback,
    );
  }
}
