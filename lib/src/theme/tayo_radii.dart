import 'package:flutter/painting.dart';

/// Radius scale mirroring the React `--radius-*` tokens.
///
/// Buttons + inputs are `md`. Cards + dialogs are `xl`. Sheets and
/// hero containers use `xl2`. Desktop frame uses `xl3` (not relevant
/// on mobile, but kept for parity).
class TayoRadii {
  TayoRadii._();

  // Naked Radius values (for `BorderRadius.only`).
  static const Radius rSm = Radius.circular(8);
  static const Radius rMd = Radius.circular(12);
  static const Radius rLg = Radius.circular(16);
  static const Radius rXl = Radius.circular(24);
  static const Radius rXl2 = Radius.circular(32);
  static const Radius rXl3 = Radius.circular(48);

  // All-corner BorderRadius (the usual case).
  static const BorderRadius sm = BorderRadius.all(rSm);
  static const BorderRadius md = BorderRadius.all(rMd);
  static const BorderRadius lg = BorderRadius.all(rLg);
  static const BorderRadius xl = BorderRadius.all(rXl);
  static const BorderRadius xl2 = BorderRadius.all(rXl2);
  static const BorderRadius xl3 = BorderRadius.all(rXl3);

  /// Top-only XL2 — bottom sheets' top corners.
  static const BorderRadius topXl2 = BorderRadius.only(
    topLeft: rXl2,
    topRight: rXl2,
  );
}
