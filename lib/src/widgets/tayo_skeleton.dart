import 'package:flutter/material.dart';

import '../effects/skeleton_pulse.dart';
import '../theme/tayo_colors.dart';

/// Loading placeholder. Mirrors the React `<Skeleton className="...">`
/// pattern: two named constructors for box vs circle shapes.
class TayoSkeleton extends StatelessWidget {
  const TayoSkeleton._({
    super.key,
    required this.width,
    required this.height,
    required this.shape,
    required this.radius,
  });

  /// Rectangular skeleton. `radius` defaults to 8 (smallest pill).
  const TayoSkeleton.box({
    Key? key,
    double? width,
    required double height,
    double radius = 8,
  }) : this._(
          key: key,
          width: width,
          height: height,
          shape: BoxShape.rectangle,
          radius: radius,
        );

  /// Circular skeleton — for avatar placeholders.
  const TayoSkeleton.circle({
    Key? key,
    required double size,
  }) : this._(
          key: key,
          width: size,
          height: size,
          shape: BoxShape.circle,
          radius: 0,
        );

  final double? width;
  final double height;
  final BoxShape shape;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SkeletonPulse(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: TayoColors.white08,
          shape: shape,
          borderRadius:
              shape == BoxShape.rectangle ? BorderRadius.circular(radius) : null,
        ),
      ),
    );
  }
}
