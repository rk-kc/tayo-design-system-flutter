import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

import 'section_header.dart';

class PrimitivesPage extends StatefulWidget {
  const PrimitivesPage({super.key});

  @override
  State<PrimitivesPage> createState() => _PrimitivesPageState();
}

class _PrimitivesPageState extends State<PrimitivesPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTime? _date;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SectionHeader(
          eyebrow: '02 · Primitives',
          title: 'The building blocks',
          description: 'Every screen composes from this short list.',
        ),
        Group(
          title: 'Buttons',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              TayoButton(label: 'Save event', onPressed: () {}),
              TayoButton(
                label: 'Cancel',
                variant: TayoButtonVariant.secondary,
                onPressed: () {},
              ),
              TayoButton(
                label: 'Delete',
                variant: TayoButtonVariant.danger,
                onPressed: () {},
              ),
              TayoButton(
                label: 'Skip',
                variant: TayoButtonVariant.ghost,
                onPressed: () {},
              ),
              TayoButton(
                label: 'New event',
                leftIcon: Icon(LucideIcons.plus),
                onPressed: () {},
              ),
              TayoButton(label: 'Disabled', onPressed: null),
            ],
          ),
        ),
        Group(
          title: 'Sizes',
          child: Wrap(
            spacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              TayoButton(label: 'Sm', size: TayoButtonSize.sm, onPressed: () {}),
              TayoButton(label: 'Md', size: TayoButtonSize.md, onPressed: () {}),
              TayoButton(label: 'Lg', size: TayoButtonSize.lg, onPressed: () {}),
            ],
          ),
        ),
        Group(
          title: 'Input',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TayoInput(
                controller: _searchCtrl,
                hintText: 'Search friends...',
                leftIcon: Icon(LucideIcons.search),
              ),
              const SizedBox(height: 12),
              TayoInput(hintText: 'Small', size: TayoInputSize.sm),
              const SizedBox(height: 12),
              TayoInput(hintText: 'Large', size: TayoInputSize.lg),
            ],
          ),
        ),
        Group(
          title: 'Card',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TayoCard(
                child: Text('Standard card',
                    style: TayoTypography.textTheme.titleMedium),
              ),
              const SizedBox(height: 12),
              TayoCard(
                interactive: true,
                onTap: () {},
                child: Text('Interactive card (press me)',
                    style: TayoTypography.textTheme.titleMedium),
              ),
            ],
          ),
        ),
        const Group(
          title: 'Avatars',
          child: Row(
            children: <Widget>[
              TayoAvatar(name: 'Rumi K', size: TayoAvatarSize.sm),
              SizedBox(width: 16),
              TayoAvatar(name: 'Yuki T', size: TayoAvatarSize.md),
              SizedBox(width: 16),
              TayoAvatar(name: 'Aoi M', size: TayoAvatarSize.lg),
              SizedBox(width: 16),
              TayoAvatar(name: 'Hana S', size: TayoAvatarSize.xl, glow: true),
            ],
          ),
        ),
        const Group(
          title: 'Badges',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              TayoBadge(label: 'Creator', tone: TayoBadgeTone.leaf),
              TayoBadge(label: 'New', tone: TayoBadgeTone.sun),
              TayoBadge(label: 'Member', tone: TayoBadgeTone.neutral),
              TayoBadge(label: 'Live', tone: TayoBadgeTone.ok),
              TayoBadge(label: 'Deleted', tone: TayoBadgeTone.danger),
            ],
          ),
        ),
        Group(
          title: 'Stat tiles',
          child: Row(
            children: <Widget>[
              TayoStat(
                icon: Icon(LucideIcons.image),
                value: '132',
                label: 'photos',
              ),
              const SizedBox(width: 12),
              TayoStat(
                icon: Icon(LucideIcons.users),
                value: '8',
                label: 'shared',
              ),
            ],
          ),
        ),
        const Group(
          title: 'Skeleton',
          child: Row(
            children: <Widget>[
              TayoSkeleton.circle(size: 48),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TayoSkeleton.box(height: 14),
                    SizedBox(height: 8),
                    TayoSkeleton.box(height: 10, width: 160),
                  ],
                ),
              ),
            ],
          ),
        ),
        Group(
          title: 'FAB',
          child: SizedBox(
            height: 80,
            child: Center(
              child: TayoFab(
                icon: Icon(LucideIcons.camera),
                label: 'Add photo',
                onPressed: () {},
              ),
            ),
          ),
        ),
        Group(
          title: 'DatePicker (composed)',
          child: TayoDatePicker(
            value: _date,
            placeholder: 'Pick a date',
            sheetTitle: 'Event start',
            onChanged: (DateTime d) => setState(() => _date = d),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
