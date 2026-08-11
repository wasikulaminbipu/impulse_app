import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomBadge({
    super.key,
    required this.color,
    required this.text,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 9,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: textStyle,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}
