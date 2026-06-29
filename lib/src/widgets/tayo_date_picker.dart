import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../internal/scale_press.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';
import 'tayo_bottom_sheet.dart';
import 'tayo_calendar.dart';
import 'tayo_input.dart';

/// Input-shaped trigger + `TayoBottomSheet` + `TayoCalendar` combo.
/// Heights mirror `TayoInput` so it lines up in form rows.
class TayoDatePicker extends StatelessWidget {
  const TayoDatePicker({
    super.key,
    this.value,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    this.placeholder = 'Select date',
    this.size = TayoInputSize.md,
    this.disabled = false,
    this.sheetTitle,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;
  final String placeholder;
  final TayoInputSize size;
  final bool disabled;
  final String? sheetTitle;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final double height = switch (size) {
      TayoInputSize.sm => 36,
      TayoInputSize.md => 48,
      TayoInputSize.lg => 56,
    };
    final EdgeInsets padding = switch (size) {
      TayoInputSize.sm => const EdgeInsets.symmetric(horizontal: 12),
      TayoInputSize.md => const EdgeInsets.symmetric(horizontal: 16),
      TayoInputSize.lg => const EdgeInsets.symmetric(horizontal: 20),
    };
    final TextStyle textStyle = switch (size) {
      TayoInputSize.sm => TayoTypography.textTheme.bodySmall!,
      TayoInputSize.md => TayoTypography.textTheme.bodyMedium!,
      TayoInputSize.lg => TayoTypography.textTheme.bodyLarge!,
    };

    final String? formatted =
        value == null ? null : DateFormat('MMM d, yyyy').format(value!);
    final String label = formatted ?? placeholder;

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: ScalePress.detector(
        onTap: disabled ? null : () => _openSheet(context),
        child: SizedBox(
          height: height,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: tayo.glassFill,
              border: Border.all(color: tayo.glassBorder, width: 1),
              borderRadius: TayoRadii.md,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: textStyle.copyWith(
                      color: value == null ? TayoColors.white25 : Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  LucideIcons.calendar,
                  size: 16,
                  color: TayoColors.white25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    await showTayoBottomSheet<void>(
      context: context,
      builder: (BuildContext c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (sheetTitle != null) ...<Widget>[
              Text(
                sheetTitle!,
                style: TayoTypography.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            TayoCalendar(
              value: value,
              minDate: minDate,
              maxDate: maxDate,
              surface: false,
              onChanged: (DateTime picked) {
                onChanged(picked);
                Navigator.of(c).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
