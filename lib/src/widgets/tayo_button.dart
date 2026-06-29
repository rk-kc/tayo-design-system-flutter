import 'package:flutter/material.dart';

import '../effects/glass_surface.dart';
import '../internal/scale_press.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

enum TayoButtonVariant { primary, secondary, danger, ghost }

enum TayoButtonSize { sm, md, lg }

/// All clickable primary/secondary/danger/ghost actions.
///
/// Mirrors the React `<Button variant size leftIcon rightIcon>` API.
/// Heights match `TayoInput` sizes so they line up side-by-side.
class TayoButton extends StatelessWidget {
  const TayoButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = TayoButtonVariant.primary,
    this.size = TayoButtonSize.md,
    this.leftIcon,
    this.rightIcon,
    this.expand = false,
  });

  /// `null` disables the button.
  final VoidCallback? onPressed;
  final String label;
  final TayoButtonVariant variant;
  final TayoButtonSize size;
  final Widget? leftIcon;
  final Widget? rightIcon;

  /// When true, the button stretches to its parent's width. Useful in
  /// stacked CTAs. (React `className="w-full"` equivalent.)
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final bool disabled = onPressed == null;
    final double height = switch (size) {
      TayoButtonSize.sm => 36,
      TayoButtonSize.md => 48,
      TayoButtonSize.lg => 56,
    };
    final EdgeInsets padding = switch (size) {
      TayoButtonSize.sm => const EdgeInsets.symmetric(horizontal: 12),
      TayoButtonSize.md => const EdgeInsets.symmetric(horizontal: 20),
      TayoButtonSize.lg => const EdgeInsets.symmetric(horizontal: 24),
    };
    final TextStyle textStyle = switch (size) {
      TayoButtonSize.lg => TayoTypography.textTheme.bodyLarge!.copyWith(
          fontVariations: TayoTypography.semibold,
        ),
      _ => TayoTypography.textTheme.labelLarge!,
    };

    final Widget content = Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (leftIcon != null) ...<Widget>[
            IconTheme.merge(
              data: IconThemeData(size: 16, color: textStyle.color),
              child: leftIcon!,
            ),
            const SizedBox(width: 8),
          ],
          // Flexible + ellipsis so a button rendered into a narrow
          // container (eg. side-by-side button row in a dialog, or a
          // long label like "Continue without location") clips
          // gracefully instead of overflowing with yellow stripes.
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                color: disabled
                    ? textStyle.color?.withOpacity(0.5)
                    : textStyle.color,
              ),
            ),
          ),
          if (rightIcon != null) ...<Widget>[
            const SizedBox(width: 8),
            IconTheme.merge(
              data: IconThemeData(size: 16, color: textStyle.color),
              child: rightIcon!,
            ),
          ],
        ],
      ),
    );

    final Widget body = _variantWrap(
      variant: variant,
      tayo: tayo,
      height: height,
      child: content,
    );

    final Widget interactive = Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: MouseRegion(
        cursor: disabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: ScalePress.detector(
          onTap: disabled ? null : onPressed,
          child: body,
        ),
      ),
    );

    return expand
        ? SizedBox(width: double.infinity, child: interactive)
        : interactive;
  }

  Widget _variantWrap({
    required TayoButtonVariant variant,
    required TayoThemeExtension tayo,
    required double height,
    required Widget child,
  }) {
    switch (variant) {
      case TayoButtonVariant.primary:
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: tayo.leaf,
            borderRadius: TayoRadii.md,
            boxShadow: tayo.shadowLifted,
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.white),
            child: child,
          ),
        );
      case TayoButtonVariant.danger:
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: tayo.danger,
            borderRadius: TayoRadii.md,
            boxShadow: tayo.shadowLifted,
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.white),
            child: child,
          ),
        );
      case TayoButtonVariant.secondary:
        return SizedBox(
          height: height,
          child: GlassSurface(
            borderRadius: TayoRadii.md,
            includeShadow: false,
            child: Center(
              child: DefaultTextStyle.merge(
                style: const TextStyle(color: Colors.white),
                child: child,
              ),
            ),
          ),
        );
      case TayoButtonVariant.ghost:
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: TayoRadii.md,
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: TayoColors.white70),
            child: child,
          ),
        );
    }
  }
}
