import 'package:flutter/animation.dart';

/// Motion tokens — easing curves and durations.
///
/// The asymmetric sheet timing (enter 360ms, exit 280ms) is signature
/// brand motion. Sheets enter slowly and settle; they leave snappier.
/// Don't unify these durations without product sign-off.
class TayoMotion {
  TayoMotion._();

  // ── Curves ────────────────────────────────────────────────────────────
  /// `cubic-bezier(0.22, 1, 0.36, 1)` — "settles" feel. Use for sheets
  /// entering, anything that should arrive deliberately.
  static const Curve easeOutExpo = Cubic(0.22, 1, 0.36, 1);

  /// `cubic-bezier(0.4, 0, 0.2, 1)` — snappy acknowledgement. Use for
  /// button presses, sheet exits, copied flashes.
  static const Curve easeSnap = Cubic(0.4, 0, 0.2, 1);

  /// `cubic-bezier(0.4, 0, 0.6, 1)` — symmetric ease used by the
  /// SkeletonPulse opacity oscillator.
  static const Curve easeInOut = Cubic(0.4, 0, 0.6, 1);

  // ── Durations ─────────────────────────────────────────────────────────
  /// Bottom-sheet enter — 360ms (with `easeOutExpo`).
  static const Duration sheetIn = Duration(milliseconds: 360);

  /// Bottom-sheet exit — 280ms (with `easeSnap`). **Deliberately shorter
  /// than enter** so dismissal feels effortless.
  static const Duration sheetOut = Duration(milliseconds: 280);

  /// Dialog / backdrop fade — 200ms (symmetric).
  static const Duration fade = Duration(milliseconds: 200);

  /// Skeleton pulse cycle — 1.6s, autoreverse.
  static const Duration skeletonPulse = Duration(milliseconds: 1600);
}
