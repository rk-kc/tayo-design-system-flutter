import 'package:flutter/material.dart';

import 'tayo_colors.dart';

/// Typography tokens: a `TextTheme` built on Libre Baskerville (variable
/// font, `wght` axis 400–700).
///
/// All styles default to `Colors.white` since Tayo is single-mode dark.
/// Weights apply via `FontVariation` rather than per-file font assets —
/// one TTF, axis-driven.
class TayoTypography {
  TayoTypography._();

  static const String fontFamily = 'Libre Baskerville';
  static const String fontPackage = 'tayo_design_system';

  static const FontVariation _wRegular = FontVariation('wght', 400);
  static const FontVariation _wSemiBold = FontVariation('wght', 600);
  static const FontVariation _wBold = FontVariation('wght', 700);

  /// Convenience for setting bold weight on any inherited style.
  static const List<FontVariation> bold = <FontVariation>[_wBold];
  static const List<FontVariation> semibold = <FontVariation>[_wSemiBold];
  static const List<FontVariation> regular = <FontVariation>[_wRegular];

  /// The TextTheme mapped to the Tailwind text-* sizes used across the
  /// React design system. Match-to-Material naming:
  ///
  ///   displayLarge  = text-6xl bold  (hero "Tayo")
  ///   displayMedium = text-5xl bold  (rare splash)
  ///   headlineLarge = text-4xl bold  (h1 in React)
  ///   headlineMedium= text-3xl bold  (h2)
  ///   headlineSmall = text-2xl bold  (h3)
  ///   titleLarge    = text-xl  bold  (h4)
  ///   titleMedium   = text-base       (body-strong)
  ///   bodyLarge     = text-base       (body)
  ///   bodyMedium    = text-sm
  ///   bodySmall     = text-xs
  ///   labelLarge    = button / label
  ///   labelMedium   = caption (10–12px metadata)
  ///   labelSmall    = micro
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 60,
      height: 1.05,
      letterSpacing: -1,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 48,
      height: 1.1,
      letterSpacing: -0.8,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 36,
      height: 1.15,
      letterSpacing: -0.4,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 28,
      height: 1.2,
      letterSpacing: -0.3,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 22,
      height: 1.25,
      letterSpacing: -0.2,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 18,
      height: 1.3,
      color: Colors.white,
      fontVariations: <FontVariation>[_wBold],
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 16,
      height: 1.4,
      color: Colors.white,
      fontVariations: <FontVariation>[_wSemiBold],
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 14,
      height: 1.4,
      color: Colors.white,
      fontVariations: <FontVariation>[_wSemiBold],
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 16,
      height: 1.5,
      color: Colors.white,
      fontVariations: <FontVariation>[_wRegular],
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 14,
      height: 1.5,
      color: TayoColors.white85,
      fontVariations: <FontVariation>[_wRegular],
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 12,
      height: 1.5,
      color: TayoColors.white70,
      fontVariations: <FontVariation>[_wRegular],
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 14,
      height: 1.2,
      letterSpacing: 0.1,
      color: Colors.white,
      fontVariations: <FontVariation>[_wSemiBold],
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 12,
      height: 1.3,
      letterSpacing: 0.4,
      color: TayoColors.white70,
      fontVariations: <FontVariation>[_wRegular],
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      package: fontPackage,
      fontSize: 10,
      height: 1.4,
      letterSpacing: 0.8,
      color: TayoColors.white60,
      fontVariations: <FontVariation>[_wSemiBold],
    ),
  );
}
