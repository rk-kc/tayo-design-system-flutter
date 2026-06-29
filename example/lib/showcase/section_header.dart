import 'package:flutter/material.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            eyebrow,
            style: TayoTypography.textTheme.labelSmall!.copyWith(
              color: TayoColors.sun,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TayoTypography.textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TayoTypography.textTheme.bodyMedium!.copyWith(
              color: TayoColors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class Group extends StatelessWidget {
  const Group({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TayoTypography.textTheme.labelSmall!.copyWith(
              color: TayoColors.white50,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
