import 'package:flutter/material.dart';

import '../theme/tayo_colors.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';
import 'tayo_avatar.dart';
import 'tayo_badge.dart';
import 'tayo_bottom_sheet.dart';
import 'tayo_stat.dart';

/// One stat tile in a `TayoUserDetailSheet`.
class TayoUserStat {
  const TayoUserStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final Widget icon;
  final String value;
  final String label;
}

class TayoUserDetailSubtitle {
  const TayoUserDetailSubtitle({required this.icon, required this.text});

  final Widget icon;
  final String text;
}

class TayoUserDetailBadge {
  const TayoUserDetailBadge({required this.label, required this.tone});

  final String label;
  final TayoBadgeTone tone;
}

/// Profile detail sheet — composes `TayoBottomSheet` + glowing avatar +
/// optional badge + subtitle row + grid of stats, with a soft radial
/// sun gradient layered behind.
Future<void> showTayoUserDetailSheet({
  required BuildContext context,
  required String displayName,
  String? avatarUrl,
  TayoUserDetailSubtitle? subtitle,
  TayoUserDetailBadge? badge,
  List<TayoUserStat> stats = const <TayoUserStat>[],
  // Profile sheets feel pinched at the primitive's 448 default on
  // wider phones — default this composite to full-bleed. Pass an
  // explicit value to cap for tablets/desktop.
  double maxWidth = double.infinity,
}) {
  return showTayoBottomSheet<void>(
    context: context,
    maxWidth: maxWidth,
    builder: (BuildContext c) {
      return _UserDetailBody(
        displayName: displayName,
        avatarUrl: avatarUrl,
        subtitle: subtitle,
        badge: badge,
        stats: stats,
      );
    },
  );
}

class _UserDetailBody extends StatelessWidget {
  const _UserDetailBody({
    required this.displayName,
    required this.avatarUrl,
    required this.subtitle,
    required this.badge,
    required this.stats,
  });

  final String displayName;
  final String? avatarUrl;
  final TayoUserDetailSubtitle? subtitle;
  final TayoUserDetailBadge? badge;
  final List<TayoUserStat> stats;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    // `alignment: topCenter` matters: Stack defaults non-positioned
    // children to topStart, which left-justifies the Column when the
    // parent sheet stretches edge-to-edge.
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // Radial sun gradient behind the content
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.6),
                  radius: 0.9,
                  colors: <Color>[
                    tayo.sun.withOpacity(0.30),
                    tayo.sun.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const <double>[0, 0.35, 0.7],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TayoAvatar(
                name: displayName,
                src: avatarUrl,
                size: TayoAvatarSize.xl,
                glow: true,
              ),
              const SizedBox(height: 18),
              Text(
                displayName,
                style: TayoTypography.textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (badge != null) ...<Widget>[
                const SizedBox(height: 10),
                TayoBadge(label: badge!.label, tone: badge!.tone),
              ],
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconTheme(
                      data: IconThemeData(color: tayo.sun, size: 14),
                      child: subtitle!.icon,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        subtitle!.text,
                        style: TayoTypography.textTheme.bodySmall!.copyWith(
                          color: TayoColors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (stats.isNotEmpty) ...<Widget>[
                const SizedBox(height: 22),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    for (final TayoUserStat s in stats)
                      TayoStat(icon: s.icon, value: s.value, label: s.label),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
