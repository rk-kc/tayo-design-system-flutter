import 'package:flutter/material.dart';

import '../effects/drag_handle.dart';
import '../effects/glass_surface.dart';
import '../internal/sheet_route.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';

/// The Tayo bottom sheet primitive — slides up from the bottom of the
/// viewport with the brand's asymmetric timing (360ms enter / 280ms exit).
///
/// Push via `showTayoBottomSheet<T>(context, ...)`.
class TayoBottomSheet extends StatelessWidget {
  const TayoBottomSheet({
    super.key,
    required this.child,
    this.showHandle = true,
  });

  final Widget child;
  final bool showHandle;

  @override
  Widget build(BuildContext context) {
    // SizedBox(width: ∞) forces the sheet to fill the horizontal slot
    // its parent allows (the SheetRoute's ConstrainedBox / Align gives
    // a max but no min). Without it, the sheet wraps to content width
    // and looks pinched on wider phones.
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: TayoRadii.topXl2,
          child: ColoredBox(
            color: TayoColors.ink.withOpacity(0.80),
            child: GlassSurface(
              borderRadius: TayoRadii.topXl2,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
              includeShadow: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (showHandle) ...<Widget>[
                    const Align(
                      alignment: Alignment.center,
                      child: DragHandle(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Push a Tayo bottom sheet. Returns the value the sheet pops with,
/// or null if dismissed.
///
/// Always uses the root navigator so a sheet pushed inside a
/// `StatefulShellRoute` branch isn't trapped in the wrong stack.
Future<T?> showTayoBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool showHandle = true,
  double maxWidth = 448,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(
    SheetRoute<T>(
      kind: SheetKind.bottomSheet,
      maxWidth: maxWidth,
      builder: (BuildContext c, Animation<double> animation) {
        final CurvedAnimation curve = pairedEnterCurve(animation, SheetKind.bottomSheet);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curve),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.6, end: 1.0).animate(curve),
            child: TayoBottomSheet(
              showHandle: showHandle,
              child: builder(c),
            ),
          ),
        );
      },
    ),
  );
}
