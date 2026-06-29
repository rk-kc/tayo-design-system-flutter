import 'package:flutter/material.dart';

import '../theme/tayo_motion.dart';

/// Subtle opacity oscillator used by `TayoSkeleton`. Pulses 1.0 → 0.5
/// over 1.6s with a symmetric ease, autoreversing.
///
/// Pulses opacity (not gradient shimmer) — feels less noisy on dark.
class SkeletonPulse extends StatefulWidget {
  const SkeletonPulse({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<SkeletonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: TayoMotion.skeletonPulse,
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 1.0, end: 0.5)
        .chain(CurveTween(curve: TayoMotion.easeInOut))
        .animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (BuildContext context, Widget? child) {
        return Opacity(opacity: _opacity.value, child: child);
      },
      child: widget.child,
    );
  }
}
