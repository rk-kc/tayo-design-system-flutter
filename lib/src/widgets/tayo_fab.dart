import 'package:flutter/material.dart';

import '../internal/scale_press.dart';
import '../theme/tayo_theme_ext.dart';

/// 56×56 leaf-colored floating action button.
///
/// Prefer wiring this into `Scaffold.floatingActionButton` rather than
/// using the `.positioned()` factory — Scaffold handles the safe-area
/// and tab-bar clearance.
class TayoFab extends StatelessWidget {
  const TayoFab({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onPressed;

  /// Returns the FAB wrapped in a `Positioned` (bottom-right) for use
  /// inside a `Stack`. Use only when not in a `Scaffold` slot.
  static Widget positioned({
    Key? key,
    required Widget icon,
    required String label,
    required VoidCallback? onPressed,
    double bottom = 112,
    double right = 24,
  }) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: TayoFab(
        key: key,
        icon: icon,
        label: label,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    return Semantics(
      button: true,
      label: label,
      child: ScalePress.detector(
        onTap: onPressed,
        scale: 0.95,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tayo.leaf,
            boxShadow: tayo.shadowFab,
          ),
          child: IconTheme(
            data: const IconThemeData(color: Colors.white, size: 24),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
