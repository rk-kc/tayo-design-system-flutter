import 'package:flutter/painting.dart';

/// Shadow stacks mirroring the React `--shadow-*` tokens.
///
/// Use these as the `boxShadow` value on `BoxDecoration` (they're already
/// `List<BoxShadow>`).
class TayoShadows {
  TayoShadows._();

  /// Small inline panels. `0 2px 8px rgba(0,0,0,0.20)`.
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  /// Default for prominent cards / primary buttons. `0 8px 24px rgba(0,0,0,0.40)`.
  static const List<BoxShadow> lifted = <BoxShadow>[
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  /// Floating action buttons. `0 12px 32px rgba(0,0,0,0.50)`.
  static const List<BoxShadow> fab = <BoxShadow>[
    BoxShadow(
      color: Color(0x80000000),
      offset: Offset(0, 12),
      blurRadius: 32,
    ),
  ];

  /// **Signature** — three-layer ambient drop + crisp lift + sun-tinted
  /// halo. The halo is what makes glass surfaces feel airborne. Do not
  /// drop the sun layer without product sign-off.
  ///
  /// Mirrors:
  ///   0 20px 50px -20px rgba(0,0,0,0.55),
  ///   0 4px  16px -6px  rgba(0,0,0,0.35),
  ///   0 0    30px -10px rgba(255,140,66,0.12);
  ///
  /// Flutter's `BoxShadow` doesn't support CSS-style `spread` of negative
  /// values; we approximate with `spreadRadius` clamped at 0 and rely on
  /// `blurRadius` to do most of the visual work. The sun-orange halo
  /// (third entry) is the load-bearing brand element.
  static const List<BoxShadow> glass = <BoxShadow>[
    BoxShadow(
      color: Color(0x8C000000),
      offset: Offset(0, 20),
      blurRadius: 50,
    ),
    BoxShadow(
      color: Color(0x59000000),
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
    BoxShadow(
      color: Color(0x1FFF8C42),
      offset: Offset.zero,
      blurRadius: 30,
    ),
  ];
}
