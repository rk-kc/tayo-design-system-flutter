import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/tayo_colors.dart';

/// Soft sun-orange halo behind a child. Mirrors the `.sun-glow` CSS
/// pseudo-element: a scaled-up blurred plate of `rgba(255, 140, 66, 0.45)`
/// sitting one layer below the child.
///
/// Wrap sparingly — typically the hero Avatar in `TayoUserDetailSheet`,
/// or a splash logo. Two glows competing kills the brand feel.
class SunGlow extends StatelessWidget {
  const SunGlow({
    super.key,
    required this.child,
    this.scale = 1.4,
    this.blurSigma = 40,
    this.color = const Color(0x73FF8C42), // rgba(255,140,66,0.45)
  });

  final Widget child;
  final double scale;
  final double blurSigma;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        // Glow plate — scaled up + blurred. Uses `Transform.scale` rather
        // than `Container(width/height)` so the child's intrinsic size
        // drives the glow size automatically.
        Positioned.fill(
          child: IgnorePointer(
            child: Transform.scale(
              scale: scale,
              child: ImageFiltered(
                imageFilter: ui.ImageFilter.blur(
                  sigmaX: blurSigma,
                  sigmaY: blurSigma,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

/// Pure brand-color version used by other effects.
const Color sunGlowDefault = Color(0x73FF8C42);
const Color sunGlowFromTokens = TayoColors.sun; // for the linter's sake
