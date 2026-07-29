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
    defaultCategoryColor: const Color(0xFF9E9E9E),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Inter',
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF006B5F), // Vivid Teal accent
      brightness: Brightness.light,
      surface: const Color(0xFFF8F9FA), // Off-white for less eye strain
      onSurface: const Color(0xFF1C1B1F),
      primary: const Color(0xFF006B5F),
      onPrimary: Colors.white,
      surfaceContainerHighest: const Color(0xFFE9EEED), // subtle container
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA), 
    cardColor: Colors.white,
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 0.5), // subtle border
      ),
      shadowColor: const Color(0x0A000000), // very soft shadow
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8F9FA),
      foregroundColor: Color(0xFF1C1B1F),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    extensions: [_categoryColors],
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Inter',
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4DB6AC), // Slightly desaturated for dark mode
      brightness: Brightness.dark,
      surface: const Color(0xFF121212), // Deep dark
      onSurface: const Color(0xFFE1E3E1),
      primary: const Color(0xFF4DB6AC),
      onPrimary: const Color(0xFF003730),
      surfaceContainerHighest: const Color(0xFF1E2423),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E), // Elevated dark gray
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF2C2C2C), width: 0.5), // subtle border
      ),
      shadowColor: const Color(0x33000000),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Color(0xFFE1E3E1),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    extensions: [_categoryColors],
  );
}
