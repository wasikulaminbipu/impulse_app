import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:impulse_dex/theme/app_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? blurSigma;
  final Color? customBackgroundColor;
  final Color? customBorderColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding,
    this.margin,
    this.blurSigma,
    this.customBackgroundColor,
    this.customBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final glassTheme = Theme.of(context).extension<GlassThemeExtension>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final sigma = blurSigma ?? glassTheme?.blurSigma ?? 14.0;
    final defaultBg = glassTheme?.backgroundColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.07)
            : Colors.black.withValues(alpha: 0.04));

    final defaultBorder = glassTheme?.borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.16)
            : Colors.black.withValues(alpha: 0.08));

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: customBackgroundColor ?? defaultBg,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: customBorderColor ?? defaultBorder,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: (glassTheme?.topSpecularColor ??
                          (isDark
                              ? Colors.white.withValues(alpha: 0.15)
                              : Colors.white.withValues(alpha: 0.5))),
                  blurRadius: 0.5,
                  spreadRadius: 0,
                  offset: const Offset(0, -1),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
