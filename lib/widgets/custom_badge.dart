import 'package:flutter/material.dart';
import 'package:impulse_app/theme/app_theme.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

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
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  /// Factory constructor to build a tonal badge using a [CategoryColorToken].
  factory CustomBadge.fromToken({
    Key? key,
    required CategoryColorToken token,
    required String text,
    TextStyle? textStyle,
    TextOverflow? overflow,
    int? maxLines,
    VoidCallback? onTap,
  }) {
    return CustomBadge(
      key: key,
      color: token.container,
      backgroundColor: token.container,
      borderColor: token.border,
      textColor: token.text,
      text: text,
      textStyle:
          (textStyle ??
                  const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ))
              .copyWith(color: token.text),
      overflow: overflow,
      maxLines: maxLines,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBg = backgroundColor ?? color;
    final effectiveBorder = borderColor != null
        ? Border.all(color: borderColor!)
        : null;
    final effectiveTextStyle =
        (textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ))
            .copyWith(color: textColor ?? textStyle?.color ?? Colors.white);

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: effectiveBg,
        border: effectiveBorder,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: effectiveTextStyle,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashFactory: InkRipple.splashFactory,
        child: badge,
      );
    }

    return badge;
  }
}
