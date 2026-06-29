import 'package:flutter/material.dart';

import '../effects/glass_surface.dart';
import '../internal/scale_press.dart';
import '../theme/tayo_radii.dart';

enum TayoCardPadding { none, sm, md, lg }

/// Default content container — glass surface, rounded-xl. The base for
/// almost every grouped content in the system.
class TayoCard extends StatelessWidget {
  const TayoCard({
    super.key,
    required this.child,
    this.padding = TayoCardPadding.md,
    this.interactive = false,
    this.onTap,
  });

  final Widget child;
  final TayoCardPadding padding;

  /// When true, adds press scale + hover lift cursor.
  final bool interactive;

  /// Tap handler — implies `interactive: true`.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets pad = switch (padding) {
      TayoCardPadding.none => EdgeInsets.zero,
      TayoCardPadding.sm => const EdgeInsets.all(12),
      TayoCardPadding.md => const EdgeInsets.all(16),
      TayoCardPadding.lg => const EdgeInsets.all(24),
    };

    final Widget body = GlassSurface(
      borderRadius: TayoRadii.xl,
      padding: pad,
      child: child,
    );

    final bool isInteractive = interactive || onTap != null;
    if (!isInteractive) return body;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ScalePress.detector(
        onTap: onTap,
        child: body,
      ),
    );
  }
}
