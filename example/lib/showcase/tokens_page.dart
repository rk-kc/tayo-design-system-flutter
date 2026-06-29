import 'package:flutter/material.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

import 'section_header.dart';

class TokensPage extends StatelessWidget {
  const TokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    return ListView(
      children: <Widget>[
        const SectionHeader(
          eyebrow: '01 · Tokens',
          title: 'The brand vocabulary',
          description: 'Colors, type, radii, shadows, motion — everything reads from here.',
        ),
        Group(
          title: 'Colors — brand + ink',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _Swatch(name: 'leaf', color: tayo.leaf),
              _Swatch(name: 'leafDeep', color: tayo.leafDeep),
              _Swatch(name: 'sun', color: tayo.sun),
              _Swatch(name: 'sunDeep', color: tayo.sunDeep),
              _Swatch(name: 'ink', color: tayo.ink),
              _Swatch(name: 'inkSoft', color: tayo.inkSoft),
            ],
          ),
        ),
        Group(
          title: 'Colors — semantic',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _Swatch(name: 'ok', color: tayo.ok),
              _Swatch(name: 'warn', color: tayo.warn),
              _Swatch(name: 'danger', color: tayo.danger),
            ],
          ),
        ),
        const Group(
          title: 'Typography',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Tayo serif'),
              SizedBox(height: 8),
              _TypeSpec(label: 'Display', sample: 'Memories worth keeping', style: 'displayLarge'),
              _TypeSpec(label: 'H1', sample: 'Tokyo Summer Trip', style: 'headlineLarge'),
              _TypeSpec(label: 'H2', sample: 'Event QR Code', style: 'headlineMedium'),
              _TypeSpec(label: 'Body', sample: 'Share this code to invite people', style: 'bodyMedium'),
              _TypeSpec(label: 'Caption', sample: 'MAY 31 - JUN 2, 2026', style: 'labelSmall'),
            ],
          ),
        ),
        const Group(
          title: 'Radii',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _RadiusChip(label: 'sm', radius: TayoRadii.sm),
              _RadiusChip(label: 'md', radius: TayoRadii.md),
              _RadiusChip(label: 'lg', radius: TayoRadii.lg),
              _RadiusChip(label: 'xl', radius: TayoRadii.xl),
              _RadiusChip(label: 'xl2', radius: TayoRadii.xl2),
            ],
          ),
        ),
        Group(
          title: 'Shadows',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              _ShadowBox(label: 'card', shadow: tayo.shadowCard),
              _ShadowBox(label: 'lifted', shadow: tayo.shadowLifted),
              _ShadowBox(label: 'fab', shadow: tayo.shadowFab),
              _ShadowBox(label: 'glass', shadow: tayo.shadowGlass),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.name, required this.color});
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 64,
            decoration: BoxDecoration(
              color: color,
              borderRadius: TayoRadii.md,
              border: Border.all(color: TayoColors.white15, width: 1),
            ),
          ),
          const SizedBox(height: 6),
          Text(name, style: TayoTypography.textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _TypeSpec extends StatelessWidget {
  const _TypeSpec({required this.label, required this.sample, required this.style});
  final String label;
  final String sample;
  final String style;

  @override
  Widget build(BuildContext context) {
    final TextStyle? s = switch (style) {
      'displayLarge' => TayoTypography.textTheme.displayLarge,
      'headlineLarge' => TayoTypography.textTheme.headlineLarge,
      'headlineMedium' => TayoTypography.textTheme.headlineMedium,
      'bodyMedium' => TayoTypography.textTheme.bodyMedium,
      'labelSmall' => TayoTypography.textTheme.labelSmall,
      _ => TayoTypography.textTheme.bodyMedium,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TayoTypography.textTheme.labelSmall!.copyWith(
                color: TayoColors.white50,
              ),
            ),
          ),
          Expanded(child: Text(sample, style: s)),
        ],
      ),
    );
  }
}

class _RadiusChip extends StatelessWidget {
  const _RadiusChip({required this.label, required this.radius});
  final String label;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: TayoColors.white05,
        borderRadius: radius,
        border: Border.all(color: TayoColors.white15, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(label, style: TayoTypography.textTheme.labelSmall),
    );
  }
}

class _ShadowBox extends StatelessWidget {
  const _ShadowBox({required this.label, required this.shadow});
  final String label;
  final List<BoxShadow> shadow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 64,
            decoration: BoxDecoration(
              color: TayoColors.inkSoft,
              borderRadius: TayoRadii.md,
              boxShadow: shadow,
            ),
          ),
          const SizedBox(height: 10),
          Text(label, style: TayoTypography.textTheme.labelSmall),
        ],
      ),
    );
  }
}
