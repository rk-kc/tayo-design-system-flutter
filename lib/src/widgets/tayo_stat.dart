import 'package:flutter/material.dart';

import '../effects/glass_surface.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

/// Number + label tile, typically grouped in `UserDetailSheet`.
class TayoStat extends StatelessWidget {
  const TayoStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final Widget icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    return SizedBox(
      width: 92,
      child: GlassSurface(
        borderRadius: TayoRadii.lg,
        includeShadow: false,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: tayo.sun.withOpacity(0.15),
                borderRadius: TayoRadii.md,
              ),
              child: IconTheme(
                data: IconThemeData(color: tayo.sun, size: 16),
                child: Center(child: icon),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TayoTypography.textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontVariations: TayoTypography.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TayoTypography.textTheme.labelSmall!.copyWith(
                color: TayoColors.white50,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
