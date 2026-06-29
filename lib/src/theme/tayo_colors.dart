import 'package:flutter/painting.dart';

/// Static brand palette. Mirrors the React design-system's `tokens.css`
/// `--color-*` block exactly.
///
/// Widgets should generally read colors via
/// `Theme.of(context).extension<TayoThemeExtension>()!` rather than
/// importing this class directly — that's the seam for future re-theming.
class TayoColors {
  TayoColors._();

  // ── Brand primary ─────────────────────────────────────────────────────
  /// Moss green — primary CTA, FAB, focus ring, identity. `#546B41`.
  static const Color leaf = Color(0xFF546B41);

  /// Pressed / hover state for leaf-filled buttons. `#3F5230`.
  static const Color leafDeep = Color(0xFF3F5230);

  // ── Secondary accent ──────────────────────────────────────────────────
  /// Warm orange — sparkles, recent markers, decorative warmth. `#FF8C42`.
  static const Color sun = Color(0xFFFF8C42);

  /// Pressed / hover state for sun-filled surfaces. `#E56B3A`.
  static const Color sunDeep = Color(0xFFE56B3A);

  // ── Ink (base surfaces) ───────────────────────────────────────────────
  /// True app background — pure black. `#000000`.
  static const Color ink = Color(0xFF000000);

  /// Slightly lifted ink for stacking inside dark contexts. `#0A0A0A`.
  static const Color inkSoft = Color(0xFF0A0A0A);

  // ── Glass surface ─────────────────────────────────────────────────────
  /// Frosted card fill — rgba(255,255,255,0.04).
  static const Color glassFill = Color(0x0AFFFFFF);

  /// Frosted card border — rgba(255,255,255,0.10).
  static const Color glassBorder = Color(0x1AFFFFFF);

  // ── Semantic ──────────────────────────────────────────────────────────
  /// Success / live. `#30D158`.
  static const Color ok = Color(0xFF30D158);

  /// Caution / soft warning. `#FFB547`.
  static const Color warn = Color(0xFFFFB547);

  /// Destructive / error. `#FF453A`.
  static const Color danger = Color(0xFFFF453A);

  // ── Common white opacities (used heavily in CSS as `text-white/N`) ───
  static const Color white05 = Color(0x0DFFFFFF);
  static const Color white08 = Color(0x14FFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white25 = Color(0x40FFFFFF);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white85 = Color(0xD9FFFFFF);
}
