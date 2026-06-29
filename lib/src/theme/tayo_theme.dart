import 'package:flutter/material.dart';

import 'tayo_colors.dart';
import 'tayo_theme_ext.dart';
import 'tayo_typography.dart';

/// Single composer for the Tayo `ThemeData`. The app wires this up via:
///
/// ```dart
/// MaterialApp(theme: TayoTheme.dark(), themeMode: ThemeMode.dark)
/// ```
///
/// No light variant in v0.1 — Tayo is single-mode dark.
class TayoTheme {
  TayoTheme._();

  static ThemeData dark() {
    const colorScheme = ColorScheme.dark(
      primary: TayoColors.leaf,
      onPrimary: Colors.white,
      secondary: TayoColors.sun,
      onSecondary: TayoColors.ink,
      surface: TayoColors.inkSoft,
      onSurface: Colors.white,
      error: TayoColors.danger,
      onError: Colors.white,
      outline: TayoColors.glassBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: TayoColors.ink,
      canvasColor: TayoColors.ink,
      textTheme: TayoTypography.textTheme,
      primaryTextTheme: TayoTypography.textTheme,
      fontFamily: TayoTypography.fontFamily,
      fontFamilyFallback: const <String>['Georgia', 'serif'],
      // Material defaults that would otherwise leak through:
      splashColor: TayoColors.white08,
      highlightColor: TayoColors.white05,
      // Brand-specific tokens.
      extensions: const <ThemeExtension<dynamic>>[
        TayoThemeExtension.dark,
      ],
    );
  }
}
