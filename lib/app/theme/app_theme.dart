import 'package:flutter/material.dart';

import 'package:flutter_app_template/app/theme/app_radius.dart';
import 'package:flutter_app_template/app/theme/app_spacing.dart';

abstract final class AppTheme {
  static ThemeData buildTheme() {
    const seedColor = Color(0xFF0F766E);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF4F1EA),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.large,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        disabledColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        secondarySelectedColor: colorScheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
        secondaryLabelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
        brightness: Brightness.light,
      ),
    );
  }
}
