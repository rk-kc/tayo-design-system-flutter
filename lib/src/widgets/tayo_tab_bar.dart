import 'package:flutter/material.dart';

import '../internal/scale_press.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

/// One tab in `TayoTabBar`. Pass `onSelect: null` to make the slot a
/// non-navigating action (e.g. opens an ActionSheet). When `onSelect`
/// is null, the tab still calls `onTap` but doesn't change index.
class TayoTabBarItem {
  const TayoTabBarItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final Widget icon;
  final String label;

  /// When provided, called on tap regardless of index change. Useful
  /// for the "Create" slot that opens a sheet instead of navigating.
  final VoidCallback? onTap;
}

/// Custom bottom tab bar — glass top border, leaf indicator behind
/// the active icon, lucide-style icons.
///
/// Designed to be placed at the bottom of a `Scaffold` body inside a
/// `Column`, or as `bottomNavigationBar` (it provides its own background).
class TayoTabBar extends StatelessWidget {
  const TayoTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
  });

  final List<TayoTabBarItem> items;
  final int currentIndex;

  /// Called when the user taps a different tab. Items with `onTap`
  /// still receive their callback; if their onTap is non-null AND they
  /// aren't the active index, this is also invoked. Consumers can
  /// short-circuit by checking `item.onTap != null`.
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final EdgeInsets padding = MediaQuery.paddingOf(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: TayoColors.ink.withOpacity(0.6),
        border: Border(top: BorderSide(color: tayo.glassBorder, width: 1)),
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : 8),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (int i = 0; i < items.length; i++)
                _Tab(
                  item: items[i],
                  active: i == currentIndex,
                  onTap: () {
                    items[i].onTap?.call();
                    if (i != currentIndex) onChanged(i);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final TayoTabBarItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final Color color = active ? tayo.leaf : TayoColors.white50;

    return Expanded(
      child: ScalePress.detector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: active ? tayo.leaf.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconTheme(
                data: IconThemeData(color: color, size: 20),
                child: item.icon,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: TayoTypography.textTheme.labelSmall!.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
