import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

import 'section_header.dart';

class PatternsPage extends StatelessWidget {
  const PatternsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SectionHeader(
          eyebrow: '04 · Patterns',
          title: 'Composed scenes',
          description: 'How the primitives stitch together in real screens.',
        ),
        const Group(
          title: 'Event card',
          child: _EventCardSample(),
        ),
        const Group(
          title: 'Friend row',
          child: _FriendRowSample(),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _EventCardSample extends StatelessWidget {
  const _EventCardSample();

  @override
  Widget build(BuildContext context) {
    return TayoCard(
      padding: TayoCardPadding.none,
      interactive: true,
      onTap: () {},
      child: ClipRRect(
        borderRadius: TayoRadii.xl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    TayoColors.sun.withOpacity(0.4),
                    TayoColors.leaf.withOpacity(0.4),
                  ],
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Tokyo Summer Trip',
                      style: TayoTypography.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Icon(LucideIcons.calendar, size: 12, color: TayoColors.white70),
                      const SizedBox(width: 6),
                      Text('May 31 – Jun 4, 2026',
                          style: TayoTypography.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(LucideIcons.image, size: 14, color: TayoColors.white60),
                  const SizedBox(width: 4),
                  Text('132', style: TayoTypography.textTheme.bodySmall),
                  const SizedBox(width: 16),
                  Icon(LucideIcons.users, size: 14, color: TayoColors.white60),
                  const SizedBox(width: 4),
                  Text('8', style: TayoTypography.textTheme.bodySmall),
                  const Spacer(),
                  Icon(LucideIcons.qrCode, size: 16, color: TayoColors.white70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendRowSample extends StatelessWidget {
  const _FriendRowSample();

  @override
  Widget build(BuildContext context) {
    return TayoCard(
      interactive: true,
      onTap: () {},
      child: Row(
        children: <Widget>[
          const TayoAvatar(name: 'Aoi Matsumoto'),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Aoi Matsumoto', style: TayoTypography.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text('Recent: Tokyo Summer Trip',
                    style: TayoTypography.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(LucideIcons.image, size: 12, color: TayoColors.white60),
                  const SizedBox(width: 4),
                  Text('47', style: TayoTypography.textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Icon(LucideIcons.users, size: 12, color: TayoColors.white60),
                  const SizedBox(width: 4),
                  Text('3', style: TayoTypography.textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
