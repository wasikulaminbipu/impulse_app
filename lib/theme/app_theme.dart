import 'package:flutter/material.dart';

/// Represents a cohesive, contrast-calibrated color token set for a category or target group.
class CategoryColorToken {
  final Color primary;
  final Color container;
  final Color border;
  final Color text;

  const CategoryColorToken({
    required this.primary,
    required this.container,
    required this.border,
    required this.text,
  });

  /// Generates a [CategoryColorToken] from a single base color with default opacities.
  factory CategoryColorToken.fromColor(Color color) {
    return CategoryColorToken(
      primary: color,
      container: color.withValues(alpha: 0.12),
      border: color.withValues(alpha: 0.25),
      text: color,
    );
  }

  CategoryColorToken copyWith({
    Color? primary,
    Color? container,
    Color? border,
    Color? text,
  }) {
    return CategoryColorToken(
      primary: primary ?? this.primary,
      container: container ?? this.container,
      border: border ?? this.border,
      text: text ?? this.text,
    );
  }

  static CategoryColorToken lerp(
    CategoryColorToken a,
    CategoryColorToken b,
    double t,
  ) {
    return CategoryColorToken(
      primary: Color.lerp(a.primary, b.primary, t)!,
      container: Color.lerp(a.container, b.container, t)!,
      border: Color.lerp(a.border, b.border, t)!,
      text: Color.lerp(a.text, b.text, t)!,
    );
  }
}

class CategoryColors extends ThemeExtension<CategoryColors> {
  final CategoryColorToken feedAdditive;
  final CategoryColorToken vaccine;
  final CategoryColorToken poultry;
  final CategoryColorToken cattle;
  final CategoryColorToken aqua;
  final CategoryColorToken defaultToken;

  const CategoryColors({
    required this.feedAdditive,
    required this.vaccine,
    required this.poultry,
    required this.cattle,
    required this.aqua,
    required this.defaultToken,
  });

  /// Factory constructor for constructing [CategoryColors] from raw colors.
  factory CategoryColors.raw({
    required Color feedAdditiveColor,
    required Color vaccineColor,
    required Color poultryColor,
    required Color cattleColor,
    required Color aquaColor,
    required Color defaultCategoryColor,
  }) {
    return CategoryColors(
      feedAdditive: CategoryColorToken.fromColor(feedAdditiveColor),
      vaccine: CategoryColorToken.fromColor(vaccineColor),
      poultry: CategoryColorToken.fromColor(poultryColor),
      cattle: CategoryColorToken.fromColor(cattleColor),
      aqua: CategoryColorToken.fromColor(aquaColor),
      defaultToken: CategoryColorToken.fromColor(defaultCategoryColor),
    );
  }

  // Backwards-compatible legacy color getters:
  Color get feedAdditiveColor => feedAdditive.primary;
  Color get vaccineColor => vaccine.primary;
  Color get poultryColor => poultry.primary;
  Color get cattleColor => cattle.primary;
  Color get aquaColor => aqua.primary;
  Color get defaultCategoryColor => defaultToken.primary;

  /// Resolves the appropriate [CategoryColorToken] with category taking primary precedence,
  /// followed by target group if applicable.
  CategoryColorToken resolve({
    String? category,
    Iterable<String>? targetGroups,
  }) {
    if (category != null && category.trim().isNotEmpty) {
      final cat = category.trim().toLowerCase();
      if (cat.contains('feed additive')) {
        return feedAdditive;
      }
      if (cat.contains('vaccine')) {
        return vaccine;
      }
      if (cat.contains('poultry')) {
        return poultry;
      }
      if (cat.contains('cattle')) {
        return cattle;
      }
      if (cat.contains('aqua')) {
        return aqua;
      }
    }

    if (targetGroups != null) {
      for (final tg in targetGroups) {
        final group = tg.trim().toLowerCase();
        if (group.contains('poultry')) {
          return poultry;
        }
        if (group.contains('cattle')) {
          return cattle;
        }
        if (group.contains('aqua')) {
          return aqua;
        }
      }
    }

    return defaultToken;
  }

  @override
  ThemeExtension<CategoryColors> copyWith({
    CategoryColorToken? feedAdditive,
    CategoryColorToken? vaccine,
    CategoryColorToken? poultry,
    CategoryColorToken? cattle,
    CategoryColorToken? aqua,
    CategoryColorToken? defaultToken,
    Color? feedAdditiveColor,
    Color? vaccineColor,
    Color? poultryColor,
    Color? cattleColor,
    Color? aquaColor,
    Color? defaultCategoryColor,
  }) {
    return CategoryColors(
      feedAdditive:
          feedAdditive ??
          (feedAdditiveColor != null
              ? this.feedAdditive.copyWith(primary: feedAdditiveColor)
              : this.feedAdditive),
      vaccine:
          vaccine ??
          (vaccineColor != null
              ? this.vaccine.copyWith(primary: vaccineColor)
              : this.vaccine),
      poultry:
          poultry ??
          (poultryColor != null
              ? this.poultry.copyWith(primary: poultryColor)
              : this.poultry),
      cattle:
          cattle ??
          (cattleColor != null
              ? this.cattle.copyWith(primary: cattleColor)
              : this.cattle),
      aqua:
          aqua ??
          (aquaColor != null
              ? this.aqua.copyWith(primary: aquaColor)
              : this.aqua),
      defaultToken:
          defaultToken ??
          (defaultCategoryColor != null
              ? this.defaultToken.copyWith(primary: defaultCategoryColor)
              : this.defaultToken),
    );
  }

  @override
  ThemeExtension<CategoryColors> lerp(
    covariant ThemeExtension<CategoryColors>? other,
    double t,
  ) {
    if (other is! CategoryColors) {
      return this;
    }
    return CategoryColors(
      feedAdditive: CategoryColorToken.lerp(
        feedAdditive,
        other.feedAdditive,
        t,
      ),
      vaccine: CategoryColorToken.lerp(vaccine, other.vaccine, t),
      poultry: CategoryColorToken.lerp(poultry, other.poultry, t),
      cattle: CategoryColorToken.lerp(cattle, other.cattle, t),
      aqua: CategoryColorToken.lerp(aqua, other.aqua, t),
      defaultToken: CategoryColorToken.lerp(
        defaultToken,
        other.defaultToken,
        t,
      ),
    );
  }
}

class GlassThemeExtension extends ThemeExtension<GlassThemeExtension> {
  final double blurSigma;
  final Color backgroundColor;
  final Color borderColor;
  final Color topSpecularColor;

  const GlassThemeExtension({
    required this.blurSigma,
    required this.backgroundColor,
    required this.borderColor,
    required this.topSpecularColor,
  });

  @override
  GlassThemeExtension copyWith({
    double? blurSigma,
    Color? backgroundColor,
    Color? borderColor,
    Color? topSpecularColor,
  }) {
    return GlassThemeExtension(
      blurSigma: blurSigma ?? this.blurSigma,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      topSpecularColor: topSpecularColor ?? this.topSpecularColor,
    );
  }

  @override
  GlassThemeExtension lerp(
    covariant ThemeExtension<GlassThemeExtension>? other,
    double t,
  ) {
    if (other is! GlassThemeExtension) {
      return this;
    }
    return GlassThemeExtension(
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      topSpecularColor: Color.lerp(
        topSpecularColor,
        other.topSpecularColor,
        t,
      )!,
    );
  }
}

class AppTheme {
  static const _glassLight = GlassThemeExtension(
    blurSigma: 16.0,
    backgroundColor: Color(0x99FFFFFF),
    borderColor: Color(0x33000000),
    topSpecularColor: Color(0x66FFFFFF),
  );

  static const _glassDark = GlassThemeExtension(
    blurSigma: 20.0,
    backgroundColor: Color(0x1F2B2930),
    borderColor: Color(0x26FFFFFF),
    topSpecularColor: Color(0x33FFFFFF),
  );

  static const _categoryColorsLight = CategoryColors(
    feedAdditive: CategoryColorToken(
      primary: Color(0xFF00796B),
      container: Color(0xFFE0F2F1),
      border: Color(0xFF80CBC4),
      text: Color(0xFF004D40),
    ),
    vaccine: CategoryColorToken(
      primary: Color(0xFF673AB7),
      container: Color(0xFFEDE7F6),
      border: Color(0xFFB39DDB),
      text: Color(0xFF311B92),
    ),
    poultry: CategoryColorToken(
      primary: Color(0xFFE65100),
      container: Color(0xFFFFF3E0),
      border: Color(0xFFFFCC80),
      text: Color(0xFFBF360C),
    ),
    cattle: CategoryColorToken(
      primary: Color(0xFF5D4037),
      container: Color(0xFFEFEBE9),
      border: Color(0xFFBCAAA4),
      text: Color(0xFF3E2723),
    ),
    aqua: CategoryColorToken(
      primary: Color(0xFF0277BD),
      container: Color(0xFFE1F5FE),
      border: Color(0xFF81D4FA),
      text: Color(0xFF01579B),
    ),
    defaultToken: CategoryColorToken(
      primary: Color(0xFF546E7A),
      container: Color(0xFFECEFF1),
      border: Color(0xFFB0BEC5),
      text: Color(0xFF37474F),
    ),
  );

  static const _categoryColorsDark = CategoryColors(
    feedAdditive: CategoryColorToken(
      primary: Color(0xFF4DB6AC),
      container: Color(0x2E4DB6AC),
      border: Color(0x594DB6AC),
      text: Color(0xFF80CBC4),
    ),
    vaccine: CategoryColorToken(
      primary: Color(0xFFB39DDB),
      container: Color(0x2EB39DDB),
      border: Color(0x59B39DDB),
      text: Color(0xFFD1C4E9),
    ),
    poultry: CategoryColorToken(
      primary: Color(0xFFFFB74D),
      container: Color(0x2EFEB84D),
      border: Color(0x59FFB74D),
      text: Color(0xFFFFE082),
    ),
    cattle: CategoryColorToken(
      primary: Color(0xFFBCAAA4),
      container: Color(0x2EBCAAA4),
      border: Color(0x59BCAAA4),
      text: Color(0xFFD7CCC8),
    ),
    aqua: CategoryColorToken(
      primary: Color(0xFF4FC3F7),
      container: Color(0x2E4FC3F7),
      border: Color(0x594FC3F7),
      text: Color(0xFF81D4FA),
    ),
    defaultToken: CategoryColorToken(
      primary: Color(0xFF90A4AE),
      container: Color(0x2E90A4AE),
      border: Color(0x5990A4AE),
      text: Color(0xFFCFD8DC),
    ),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Inter',
    useMaterial3: true,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF006B5F), // Rich Emerald Teal
      surface: const Color(0xFFF8F9FA), // Soft modern light surface
      onSurface: const Color(0xFF191C1C),
      primary: const Color(0xFF006B5F),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFA5F2E6),
      onPrimaryContainer: const Color(0xFF00201C),
      secondary: const Color(0xFF4A635F),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFCCE8E3),
      onSecondaryContainer: const Color(0xFF051F1C),
      tertiary: const Color(0xFF4B607A),
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFFD3E4FF),
      onTertiaryContainer: const Color(0xFF041C33),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF2F4F3),
      surfaceContainer: const Color(0xFFECEEEF),
      surfaceContainerHigh: const Color(0xFFE6E8E8),
      surfaceContainerHighest: const Color(0xFFE0E3E2),
      outline: const Color(0xFF6F7977),
      outlineVariant: const Color(0xFFBFC9C6),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFD4DAD7)),
      ),
      shadowColor: const Color(0x14000000),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8F9FA),
      foregroundColor: Color(0xFF191C1C),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191C1C),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBFC9C6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBFC9C6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF006B5F), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF6F7977), fontSize: 14),
      labelStyle: const TextStyle(color: Color(0xFF4A635F), fontSize: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF006B5F),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF006B5F),
        side: const BorderSide(color: Color(0xFF006B5F), width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF006B5F),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF006B5F),
      foregroundColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFECEEEF),
      selectedColor: const Color(0xFFA5F2E6),
      disabledColor: const Color(0xFFE0E3E2),
      secondarySelectedColor: const Color(0xFFA5F2E6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFF191C1C),
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFF00201C),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide.none,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E3E2),
      thickness: 1,
      space: 1,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
      bodyMedium: TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
    ),
    extensions: const [_categoryColorsLight, _glassLight],
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Inter',
    useMaterial3: true,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4DB6AC),
      brightness: Brightness.dark,
      surface: const Color(0xFF121414),
      onSurface: const Color(0xFFE1E3E2),
      primary: const Color(0xFF80D5C7),
      onPrimary: const Color(0xFF003731),
      primaryContainer: const Color(0xFF005047),
      onPrimaryContainer: const Color(0xFFA5F2E6),
      secondary: const Color(0xFFB0CCC6),
      onSecondary: const Color(0xFF1C3531),
      secondaryContainer: const Color(0xFF334B47),
      onSecondaryContainer: const Color(0xFFCCE8E3),
      tertiary: const Color(0xFFB3C8E8),
      onTertiary: const Color(0xFF1C314A),
      tertiaryContainer: const Color(0xFF334861),
      onTertiaryContainer: const Color(0xFFD3E4FF),
      surfaceContainerLowest: const Color(0xFF0D0F0F),
      surfaceContainerLow: const Color(0xFF1A1C1C),
      surfaceContainer: const Color(0xFF1E2020),
      surfaceContainerHigh: const Color(0xFF282B2A),
      surfaceContainerHighest: const Color(0xFF333635),
      outline: const Color(0xFF899390),
      outlineVariant: const Color(0xFF3F4947),
    ),
    scaffoldBackgroundColor: const Color(0xFF121414),
    cardTheme: CardThemeData(
      color: const Color(0xFF1D2121),
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF333A38)),
      ),
      shadowColor: const Color(0x3D000000),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121414),
      foregroundColor: Color(0xFFE1E3E2),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE1E3E2),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E2020),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3F4947)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3F4947)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF80D5C7), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFB4AB), width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF899390), fontSize: 14),
      labelStyle: const TextStyle(color: Color(0xFFB0CCC6), fontSize: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF80D5C7),
        foregroundColor: const Color(0xFF003731),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF80D5C7),
        side: const BorderSide(color: Color(0xFF80D5C7), width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF80D5C7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF80D5C7),
      foregroundColor: const Color(0xFF003731),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1E2020),
      selectedColor: const Color(0xFF005047),
      disabledColor: const Color(0xFF1A1C1C),
      secondarySelectedColor: const Color(0xFF005047),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFFE1E3E2),
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        color: Color(0xFFA5F2E6),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: const BorderSide(color: Color(0xFF282B2A)),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF282B2A),
      thickness: 1,
      space: 1,
    ),
    extensions: const [_categoryColorsDark, _glassDark],
  );
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => switch (getPlatform(context)) {
    TargetPlatform.android ||
    TargetPlatform.fuchsia => GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Theme.of(context).colorScheme.primary,
      child: child,
    ),
    _ => super.buildOverscrollIndicator(context, child, details),
  };
}
