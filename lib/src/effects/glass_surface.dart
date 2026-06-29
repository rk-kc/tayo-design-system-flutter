import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/tayo_blur.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';

/// The frosted card surface used across the system: semi-transparent
/// white fill (~4%) + 1px white-10% border + heavy backdrop blur + the
/// three-layer brand shadow with sun-tinted halo.
///
/// Compose freely: cards, sheets, inputs, calendars all wrap their
/// content in a `GlassSurface`. The `borderRadius` defaults to the
/// "card" radius (24); pass a different one for sheets, buttons, etc.
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.borderRadius = TayoRadii.xl,
    this.padding,
    this.includeShadow = true,
    this.blurSigma = TayoBlur.xl,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool includeShadow;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final body = DecoratedBox(
      decoration: BoxDecoration(
        color: tayo.glassFill,
        border: Border.all(color: tayo.glassBorder, width: 1),
        borderRadius: borderRadius,
        // Shadow goes outside the clipped blur region (cast on the page,
        // not the frosted glass itself), so it sits on the outer
        // DecoratedBox. The inner ClipRRect handles the backdrop filter.
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );

    if (!includeShadow) return body;

    // A second DecoratedBox below the frosted body carries the shadow.
    // We can't put `boxShadow` on the same decoration as the backdrop
    // clip without paint-order surprises; this keeps things predictable.
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: tayo.shadowGlass,
      ),
      child: body,
    );
  }
}
