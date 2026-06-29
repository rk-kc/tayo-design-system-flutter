import 'package:flutter/material.dart';

import 'tayo_colors.dart';
import 'tayo_motion.dart';
import 'tayo_shadows.dart';

/// Brand-specific tokens that don't fit cleanly into Material's
/// `ColorScheme`. Widgets read these via
/// `Theme.of(context).extension<TayoThemeExtension>()!`.
///
/// Keeps everything tweakable from one place — re-theming for a future
/// white-label or light-mode would touch only this class and its callers.
@immutable
class TayoThemeExtension extends ThemeExtension<TayoThemeExtension> {
  const TayoThemeExtension({
    required this.leaf,
    required this.leafDeep,
    required this.sun,
    required this.sunDeep,
    required this.ink,
    required this.inkSoft,
    required this.glassFill,
    required this.glassBorder,
    required this.ok,
    required this.warn,
    required this.danger,
    required this.shadowCard,
    required this.shadowLifted,
    required this.shadowFab,
    required this.shadowGlass,
    required this.sheetIn,
    required this.sheetOut,
    required this.fade,
    required this.easeOutExpo,
    required this.easeSnap,
  });

  /// The dark-themed default. The only variant in v0.1.
  static const TayoThemeExtension dark = TayoThemeExtension(
    leaf: TayoColors.leaf,
    leafDeep: TayoColors.leafDeep,
    sun: TayoColors.sun,
    sunDeep: TayoColors.sunDeep,
    ink: TayoColors.ink,
    inkSoft: TayoColors.inkSoft,
    glassFill: TayoColors.glassFill,
    glassBorder: TayoColors.glassBorder,
    ok: TayoColors.ok,
    warn: TayoColors.warn,
    danger: TayoColors.danger,
    shadowCard: TayoShadows.card,
    shadowLifted: TayoShadows.lifted,
    shadowFab: TayoShadows.fab,
    shadowGlass: TayoShadows.glass,
    sheetIn: TayoMotion.sheetIn,
    sheetOut: TayoMotion.sheetOut,
    fade: TayoMotion.fade,
    easeOutExpo: TayoMotion.easeOutExpo,
    easeSnap: TayoMotion.easeSnap,
  );

  // Colors
  final Color leaf;
  final Color leafDeep;
  final Color sun;
  final Color sunDeep;
  final Color ink;
  final Color inkSoft;
  final Color glassFill;
  final Color glassBorder;
  final Color ok;
  final Color warn;
  final Color danger;

  // Shadows
  final List<BoxShadow> shadowCard;
  final List<BoxShadow> shadowLifted;
  final List<BoxShadow> shadowFab;
  final List<BoxShadow> shadowGlass;

  // Motion
  final Duration sheetIn;
  final Duration sheetOut;
  final Duration fade;
  final Curve easeOutExpo;
  final Curve easeSnap;

  @override
  TayoThemeExtension copyWith({
    Color? leaf,
    Color? leafDeep,
    Color? sun,
    Color? sunDeep,
    Color? ink,
    Color? inkSoft,
    Color? glassFill,
    Color? glassBorder,
    Color? ok,
    Color? warn,
    Color? danger,
    List<BoxShadow>? shadowCard,
    List<BoxShadow>? shadowLifted,
    List<BoxShadow>? shadowFab,
    List<BoxShadow>? shadowGlass,
    Duration? sheetIn,
    Duration? sheetOut,
    Duration? fade,
    Curve? easeOutExpo,
    Curve? easeSnap,
  }) {
    return TayoThemeExtension(
      leaf: leaf ?? this.leaf,
      leafDeep: leafDeep ?? this.leafDeep,
      sun: sun ?? this.sun,
      sunDeep: sunDeep ?? this.sunDeep,
      ink: ink ?? this.ink,
      inkSoft: inkSoft ?? this.inkSoft,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      ok: ok ?? this.ok,
      warn: warn ?? this.warn,
      danger: danger ?? this.danger,
      shadowCard: shadowCard ?? this.shadowCard,
      shadowLifted: shadowLifted ?? this.shadowLifted,
      shadowFab: shadowFab ?? this.shadowFab,
      shadowGlass: shadowGlass ?? this.shadowGlass,
      sheetIn: sheetIn ?? this.sheetIn,
      sheetOut: sheetOut ?? this.sheetOut,
      fade: fade ?? this.fade,
      easeOutExpo: easeOutExpo ?? this.easeOutExpo,
      easeSnap: easeSnap ?? this.easeSnap,
    );
  }

  /// We don't animate between themes (single dark variant), so lerp
  /// snaps at the midpoint.
  @override
  TayoThemeExtension lerp(ThemeExtension<TayoThemeExtension>? other, double t) {
    if (other is! TayoThemeExtension) return this;
    return t < 0.5 ? this : other;
  }
}

/// Convenience accessor — `context.tayo` returns the extension or a
/// safe fallback. Saves the `Theme.of(...).extension<...>()!` mouthful
/// in widgets.
extension TayoThemeContext on BuildContext {
  TayoThemeExtension get tayo =>
      Theme.of(this).extension<TayoThemeExtension>() ?? TayoThemeExtension.dark;
}
