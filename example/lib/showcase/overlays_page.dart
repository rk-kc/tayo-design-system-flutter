import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

import 'section_header.dart';

class OverlaysPage extends StatelessWidget {
  const OverlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SectionHeader(
          eyebrow: '03 · Overlays',
          title: 'Sheets, dialogs, and menus',
          description: 'Asymmetric motion: sheets enter at 360ms and leave at 280ms. Time the difference.',
        ),
        Group(
          title: 'Bottom sheet',
          child: TayoButton(
            label: 'Open sheet',
            leftIcon: Icon(LucideIcons.arrowUp),
            onPressed: () => _openBottomSheet(context),
          ),
        ),
        Group(
          title: 'Dialog',
          child: Wrap(
            spacing: 12,
            children: <Widget>[
              TayoButton(
                label: 'Confirm',
                onPressed: () => _openDialog(context, dismissable: true),
              ),
              TayoButton(
                label: 'Modal (no dismiss)',
                variant: TayoButtonVariant.secondary,
                onPressed: () => _openDialog(context, dismissable: false),
              ),
            ],
          ),
        ),
        Group(
          title: 'ActionSheet',
          child: TayoButton(
            label: 'Add photo',
            leftIcon: Icon(LucideIcons.plus),
            onPressed: () => _openActionSheet(context),
          ),
        ),
        Group(
          title: 'User detail sheet',
          child: TayoButton(
            label: 'Show Yuki',
            variant: TayoButtonVariant.secondary,
            onPressed: () => _openUserDetail(context),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  void _openBottomSheet(BuildContext context) {
    showTayoBottomSheet<void>(
      context: context,
      builder: (BuildContext c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Hello from the sheet',
                style: TayoTypography.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Slides up at 360ms, dismisses at 280ms.',
              style: TayoTypography.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TayoButton(
              label: 'Done',
              expand: true,
              onPressed: () => Navigator.of(c).pop(),
            ),
          ],
        );
      },
    );
  }

  void _openDialog(BuildContext context, {required bool dismissable}) {
    showTayoDialog<void>(
      context: context,
      dismissable: dismissable,
      showCloseButton: dismissable,
      builder: (BuildContext c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Delete album?',
                style: TayoTypography.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'This removes every photo in the album. Cannot be undone.',
              style: TayoTypography.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TayoButton(
                    label: 'Cancel',
                    variant: TayoButtonVariant.secondary,
                    onPressed: dismissable ? () => Navigator.of(c).pop() : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TayoButton(
                    label: 'Delete',
                    variant: TayoButtonVariant.danger,
                    onPressed: () => Navigator.of(c).pop(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openActionSheet(BuildContext context) {
    showTayoActionSheet(
      context: context,
      options: <TayoActionSheetOption>[
        TayoActionSheetOption(
          icon: Icon(LucideIcons.camera),
          title: 'Take photo',
          subtitle: 'Capture with the camera, with location',
          onSelect: () {},
        ),
        TayoActionSheetOption(
          icon: Icon(LucideIcons.imagePlus),
          title: 'Choose from library',
          subtitle: 'Pick existing photos from this device',
          onSelect: () {},
        ),
      ],
    );
  }

  void _openUserDetail(BuildContext context) {
    showTayoUserDetailSheet(
      context: context,
      displayName: 'Yuki Tanaka',
      badge: const TayoUserDetailBadge(
        label: 'Creator',
        tone: TayoBadgeTone.leaf,
      ),
      subtitle: TayoUserDetailSubtitle(
        icon: Icon(LucideIcons.calendar),
        text: 'Joined May 31, 2026',
      ),
      stats: <TayoUserStat>[
        TayoUserStat(icon: Icon(LucideIcons.image), value: '47', label: 'photos'),
        TayoUserStat(icon: Icon(LucideIcons.users), value: '3', label: 'events'),
        TayoUserStat(icon: Icon(LucideIcons.heart), value: '128', label: 'reactions'),
      ],
    );
  }
}
