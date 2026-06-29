import 'package:flutter/material.dart';

import '../theme/tayo_colors.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

enum TayoBadgeTone { leaf, sun, neutral, danger, ok }

/// Pill-shaped status / role chip. Tones map to brand colors at low
/// opacity background + solid foreground.
class TayoBadge extends StatelessWidget {
  const TayoBadge({
    super.key,
    required this.label,
    this.tone = TayoBadgeTone.neutral,
  });

  final String label;
  final TayoBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final ({Color bg, Color fg, Color border}) colors = switch (tone) {
      TayoBadgeTone.leaf => (
          bg: tayo.leaf.withOpacity(0.30),
          fg: Colors.white,
          border: tayo.leaf.withOpacity(0.45),
        ),
      TayoBadgeTone.sun => (
          bg: tayo.sun.withOpacity(0.15),
          fg: tayo.sun,
          border: tayo.sun.withOpacity(0.30),
        ),
      TayoBadgeTone.neutral => (
          bg: TayoColors.white05,
          fg: TayoColors.white70,
          border: TayoColors.white15,
        ),
      TayoBadgeTone.danger => (
          bg: tayo.danger.withOpacity(0.15),
          fg: tayo.danger,
          border: tayo.danger.withOpacity(0.30),
        ),
      TayoBadgeTone.ok => (
          bg: tayo.ok.withOpacity(0.15),
          fg: tayo.ok,
          border: tayo.ok.withOpacity(0.30),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: colors.bg,
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontFamily: TayoTypography.fontFamily,
          package: TayoTypography.fontPackage,
          fontSize: 10,
          letterSpacing: 0.8,
          color: colors.fg,
          fontVariations: TayoTypography.semibold,
        ),
      ),
    );
  }
}
