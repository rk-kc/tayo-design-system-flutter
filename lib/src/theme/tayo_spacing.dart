/// Semantic spacing constants mirroring the React `--spacing-*` tokens.
///
/// Use literal values (not these) for one-off paddings; reach for these
/// when the role is named ("page gutter", "tab-bar clearance").
class TayoSpacing {
  TayoSpacing._();

  /// Default horizontal page gutter — list pages, gallery. 16px.
  static const double pageX = 16;

  /// Wider gutter for hero / feature screens. 24px.
  static const double pageXLg = 24;

  /// Top safe area on hero screens (clears the status bar). 56px.
  static const double screenY = 56;

  /// Bottom clearance to keep content above the tab bar. 96px.
  static const double bottomTab = 96;
}
