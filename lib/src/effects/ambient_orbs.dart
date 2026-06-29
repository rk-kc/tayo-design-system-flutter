import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Two large soft-orange blurred discs that sit behind hero content.
/// In the React design system these decorate the desktop frame canvas;
/// on mobile they're useful for splash screens and onboarding hero
/// surfaces — anywhere you want a warm "lit" feel without putting
/// imagery on the page.
///
/// Wrap inside a `Stack(children: [AmbientOrbs(), ...content])`. The
/// orbs ignore pointer events.
class AmbientOrbs extends StatelessWidget {
  const AmbientOrbs({
    super.key,
    this.sunColor = const Color(0x2EFF8C42), // rgba(255,140,66,0.18)
    this.deepColor = const Color(0x1FE56B3A), // rgba(229,107,58,0.12)
    this.size = 520,
    this.blurSigma = 80,
  });

  final Color sunColor;
  final Color deepColor;
  final double size;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: <Widget>[
            // Top-left sun
            Positioned(
              top: -160,
              left: -128,
              child: _Orb(color: sunColor, size: size, blurSigma: blurSigma),
            ),
            // Bottom-right deep
            Positioned(
              bottom: -192,
              right: -128,
              child: _Orb(color: deepColor, size: size, blurSigma: blurSigma),
            ),
          ],
        ),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({
    required this.color,
    required this.size,
    required this.blurSigma,
  });

  final Color color;
  final double size;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
