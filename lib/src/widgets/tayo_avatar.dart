import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../effects/sun_glow.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_typography.dart';

enum TayoAvatarSize { sm, md, lg, xl }

/// User identity with fallback to initial.
///
/// Sizes: sm=32, md=56, lg=80, xl=112.
/// `glow: true` wraps in `SunGlow` for hero placements.
class TayoAvatar extends StatelessWidget {
  const TayoAvatar({
    super.key,
    required this.name,
    this.src,
    this.size = TayoAvatarSize.md,
    this.glow = false,
  });

  final String name;
  final String? src;
  final TayoAvatarSize size;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final double dim = switch (size) {
      TayoAvatarSize.sm => 32,
      TayoAvatarSize.md => 56,
      TayoAvatarSize.lg => 80,
      TayoAvatarSize.xl => 112,
    };
    final double borderWidth = switch (size) {
      TayoAvatarSize.xl => 4,
      _ => 2,
    };
    final Color borderColor = switch (size) {
      TayoAvatarSize.xl => TayoColors.white85,
      TayoAvatarSize.lg => TayoColors.white25,
      _ => TayoColors.white15,
    };
    final double fontSize = switch (size) {
      TayoAvatarSize.sm => 12,
      TayoAvatarSize.md => 18,
      TayoAvatarSize.lg => 28,
      TayoAvatarSize.xl => 40,
    };
    final String initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();

    final Widget inner = ClipOval(
      child: SizedBox(
        width: dim,
        height: dim,
        child: src != null && src!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: src!,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(color: TayoColors.white08),
                errorWidget: (_, __, ___) => _Initial(
                  initial: initial,
                  fontSize: fontSize,
                ),
              )
            : _Initial(initial: initial, fontSize: fontSize),
      ),
    );

    final Widget bordered = Container(
      width: dim,
      height: dim,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: inner,
    );

    if (!glow) return bordered;

    return SunGlow(child: bordered);
  }
}

class _Initial extends StatelessWidget {
  const _Initial({required this.initial, required this.fontSize});

  final String initial;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TayoColors.white08,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontFamily: TayoTypography.fontFamily,
          package: TayoTypography.fontPackage,
          fontSize: fontSize,
          color: Colors.white,
          fontVariations: TayoTypography.bold,
        ),
      ),
    );
  }
}
