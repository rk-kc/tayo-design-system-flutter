/// Backdrop blur sigma values mirroring the React `--blur-*` tokens.
///
/// Pillar usage:
/// - `sm` for modal backdrop dimming (light frosting)
/// - `xl` for `.glass-surface` (signature blur)
class TayoBlur {
  TayoBlur._();

  static const double sm = 8;
  static const double md = 20;
  static const double lg = 40;
  static const double xl = 60;
}
