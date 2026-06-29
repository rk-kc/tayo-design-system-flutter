import 'package:flutter/material.dart';

import '../effects/glass_surface.dart';
import '../internal/scale_press.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';
import 'tayo_bottom_sheet.dart';

class TayoActionSheetOption {
  const TayoActionSheetOption({
    required this.icon,
    required this.title,
    required this.onSelect,
    this.subtitle,
  });

  final Widget icon;
  final String title;
  final String? subtitle;
  final VoidCallback onSelect;
}

/// Slide-up menu of 2–4 options. Pure composition on `TayoBottomSheet`.
///
/// Order matters: closes the sheet first, *then* calls `onSelect`, so
/// any navigation triggered by the option starts after the dismiss
/// animation. Matches React behavior.
Future<void> showTayoActionSheet({
  required BuildContext context,
  required List<TayoActionSheetOption> options,
}) {
  return showTayoBottomSheet<void>(
    context: context,
    builder: (BuildContext c) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final TayoActionSheetOption opt in options) ...<Widget>[
            _OptionRow(
              option: opt,
              onTap: () {
                Navigator.of(c).pop();
                // Defer onSelect by one frame so any navigation it
                // triggers doesn't race the sheet's exit animation.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  opt.onSelect();
                });
              },
            ),
            if (opt != options.last) const SizedBox(height: 12),
          ],
        ],
      );
    },
  );
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({required this.option, required this.onTap});

  final TayoActionSheetOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    return ScalePress.detector(
      onTap: onTap,
      child: GlassSurface(
        borderRadius: TayoRadii.lg,
        includeShadow: false,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: tayo.sun.withOpacity(0.15),
                borderRadius: TayoRadii.md,
              ),
              child: IconTheme(
                data: IconThemeData(color: tayo.sun, size: 18),
                child: Center(child: option.icon),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    option.title,
                    style: TayoTypography.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  if (option.subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      option.subtitle!,
                      style: TayoTypography.textTheme.bodySmall!.copyWith(
                        color: TayoColors.white50,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
