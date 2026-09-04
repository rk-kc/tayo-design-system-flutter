import 'package:flutter/material.dart';

import '../effects/glass_surface.dart';
import '../internal/sheet_route.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';

/// Centered confirmation modal (not navigational). On mobile it
/// bottom-aligns; on wider viewports it centers.
///
/// Push via `showTayoDialog<T>(context, ...)`.
class TayoDialog extends StatelessWidget {
  const TayoDialog({
    super.key,
    required this.child,
    this.showCloseButton = false,
    this.onClose,
  });

  final Widget child;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    // SheetRoute pushes without a Material ancestor — same gap
    // TayoBottomSheet had (see that file's identical fix). Without this,
    // a TextField anywhere inside a TayoDialog (e.g. a rename dialog)
    // throws "No Material widget found" instead of just missing styling,
    // since TextField hard-requires a Material ancestor to render at all.
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            GlassSurface(
              borderRadius: TayoRadii.xl,
              padding: const EdgeInsets.all(24),
              child: child,
            ),
            if (showCloseButton)
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: onClose ?? () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: TayoColors.white08,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Push a Tayo dialog.
Future<T?> showTayoDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool dismissable = true,
  bool showCloseButton = false,
  double maxWidth = 448,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(
    SheetRoute<T>(
      kind: dismissable ? SheetKind.dialog : SheetKind.dialogModal,
      maxWidth: maxWidth,
      barrierDismissibleOverride: dismissable,
      builder: (BuildContext c, Animation<double> animation) {
        final CurvedAnimation curve = pairedEnterCurve(animation, SheetKind.dialog);
        return FadeTransition(
          opacity: curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curve),
            child: PopScope(
              canPop: dismissable,
              child: TayoDialog(
                showCloseButton: showCloseButton,
                onClose: dismissable ? () => Navigator.of(c).pop() : null,
                child: builder(c),
              ),
            ),
          ),
        );
      },
    ),
  );
}
