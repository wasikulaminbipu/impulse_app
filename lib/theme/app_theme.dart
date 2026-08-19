import 'package:flutter/material.dart';

class CategoryColors extends ThemeExtension<CategoryColors> {
  final Color feedAdditiveColor;
  final Color vaccineColor;
  final Color poultryColor;
  final Color cattleColor;
  final Color aquaColor;
  final Color defaultCategoryColor;

  const CategoryColors({
    required this.feedAdditiveColor,
    required this.vaccineColor,
    required this.poultryColor,
    required this.cattleColor,
    required this.aquaColor,
    required this.defaultCategoryColor,
  });

  @override
  ThemeExtension<CategoryColors> copyWith({
    Color? feedAdditiveColor,
    Color? vaccineColor,
    Color? poultryColor,
    Color? cattleColor,
    Color? aquaColor,
    Color? defaultCategoryColor,
  }) {
    return CategoryColors(
      feedAdditiveColor: feedAdditiveColor ?? this.feedAdditiveColor,
      vaccineColor: vaccineColor ?? this.vaccineColor,
      poultryColor: poultryColor ?? this.poultryColor,
      cattleColor: cattleColor ?? this.cattleColor,
      aquaColor: aquaColor ?? this.aquaColor,
      defaultCategoryColor: defaultCategoryColor ?? this.defaultCategoryColor,
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
      feedAdditiveColor: Color.lerp(
        feedAdditiveColor,
        other.feedAdditiveColor,
        t,
      )!,
      vaccineColor: Color.lerp(vaccineColor, other.vaccineColor, t)!,
      poultryColor: Color.lerp(poultryColor, other.poultryColor, t)!,
      cattleColor: Color.lerp(cattleColor, other.cattleColor, t)!,
      aquaColor: Color.lerp(aquaColor, other.aquaColor, t)!,
      defaultCategoryColor: Color.lerp(
        defaultCategoryColor,
        other.defaultCategoryColor,
        t,
      )!,
    );
  }
}

class AppTheme {
  static final _categoryColors = CategoryColors(
    feedAdditiveColor: const Color(0xFF00796B), // Premium Teal
    vaccineColor: const Color(0xFF673AB7), // Premium Deep Purple
    poultryColor: const Color(0xFFFF8F00), // Premium Amber/Orange
    cattleColor: const Color(0xFF795548), // Premium Brown
    aquaColor: const Color(0xFF1976D2), // Premium Blue
    defaultCategoryColor: const Color(0xFF78909C),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Inter',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF006B5F), // Rich Emerald Teal
      brightness: Brightness.light,
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
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFD4DAD7), width: 1),
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
        borderSide: const BorderSide(color: Color(0xFFBFC9C6), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBFC9C6), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF006B5F), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1),
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
      labelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF191C1C)),
      secondaryLabelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFF00201C)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide.none,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E3E2),
      thickness: 1,
      space: 1,
    ),
    extensions: [_categoryColors],
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Inter',
    useMaterial3: true,
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
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF333A38), width: 1),
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
        borderSide: const BorderSide(color: Color(0xFF3F4947), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3F4947), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF80D5C7), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFB4AB), width: 1),
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
      labelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFFE1E3E2)),
      secondaryLabelStyle: const TextStyle(fontFamily: 'Inter', fontSize: 13, color: Color(0xFFA5F2E6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: const BorderSide(color: Color(0xFF282B2A), width: 1),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF282B2A),
      thickness: 1,
      space: 1,
    ),
    extensions: [_categoryColors],
  );
}
