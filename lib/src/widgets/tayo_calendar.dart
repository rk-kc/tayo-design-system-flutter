import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../effects/glass_surface.dart';
import '../internal/scale_press.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

/// Month grid with prev/next navigation. Sunday-first week, 6 rows.
class TayoCalendar extends StatefulWidget {
  const TayoCalendar({
    super.key,
    this.value,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    this.surface = true,
  });

  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;

  /// Wrap in a `GlassSurface` card. Default true. Set false when
  /// nesting inside another surface (e.g. inside a BottomSheet).
  final bool surface;

  @override
  State<TayoCalendar> createState() => _TayoCalendarState();
}

class _TayoCalendarState extends State<TayoCalendar> {
  late DateTime _viewMonth;

  @override
  void initState() {
    super.initState();
    final DateTime seed = widget.value ?? DateTime.now();
    _viewMonth = DateTime(seed.year, seed.month);
  }

  void _goPrev() => setState(() {
        _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1);
      });

  void _goNext() => setState(() {
        _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1);
      });

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days = _buildMonthGrid(_viewMonth);
    final DateTime today = _stripTime(DateTime.now());
    final DateTime? minDay = widget.minDate == null ? null : _stripTime(widget.minDate!);
    final DateTime? maxDay = widget.maxDate == null ? null : _stripTime(widget.maxDate!);

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _header(),
        const SizedBox(height: 12),
        _weekdayRow(),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: <Widget>[
            for (final DateTime day in days)
              _DayCell(
                day: day,
                inMonth: day.month == _viewMonth.month,
                isSelected:
                    widget.value != null && _isSameDay(day, widget.value!),
                isToday: _isSameDay(day, today),
                isDisabled: (minDay != null && day.isBefore(minDay)) ||
                    (maxDay != null && day.isAfter(maxDay)),
                onTap: () => widget.onChanged(day),
              ),
          ],
        ),
      ],
    );

    if (!widget.surface) return content;
    return GlassSurface(
      borderRadius: TayoRadii.xl,
      padding: const EdgeInsets.all(16),
      includeShadow: false,
      child: content,
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _chevron(LucideIcons.chevronLeft, _goPrev, 'Previous month'),
        Text(
          '${_monthName(_viewMonth.month)} ${_viewMonth.year}',
          style: TayoTypography.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        _chevron(LucideIcons.chevronRight, _goNext, 'Next month'),
      ],
    );
  }

  Widget _chevron(IconData icon, VoidCallback onTap, String semanticsLabel) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: ScalePress.detector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: TayoColors.white05,
            borderRadius: TayoRadii.md,
          ),
          child: Icon(icon, size: 16, color: TayoColors.white70),
        ),
      ),
    );
  }

  Widget _weekdayRow() {
    const List<String> weekdays = <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      children: <Widget>[
        for (final String w in weekdays)
          Expanded(
            child: Center(
              child: Text(
                w,
                style: TayoTypography.textTheme.labelSmall!.copyWith(
                  color: TayoColors.white50,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.inMonth,
    required this.isSelected,
    required this.isToday,
    required this.isDisabled,
    required this.onTap,
  });

  final DateTime day;
  final bool inMonth;
  final bool isSelected;
  final bool isToday;
  final bool isDisabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;

    Color textColor;
    Color? bg;
    BoxBorder? border;
    List<BoxShadow>? shadow;

    if (isSelected) {
      textColor = Colors.white;
      bg = tayo.leaf;
      shadow = tayo.shadowLifted;
    } else if (!inMonth) {
      textColor = TayoColors.white25;
    } else {
      textColor = TayoColors.white85;
    }

    if (isToday && !isSelected) {
      border = Border.all(color: tayo.sun.withOpacity(0.6), width: 1);
    }

    final Widget cell = Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: TayoRadii.sm,
        border: border,
        boxShadow: shadow,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          fontFamily: TayoTypography.fontFamily,
          package: TayoTypography.fontPackage,
          color: textColor,
          fontSize: 13,
          fontVariations:
              isSelected ? TayoTypography.semibold : TayoTypography.regular,
        ),
      ),
    );

    if (isDisabled) {
      return Opacity(opacity: 0.3, child: cell);
    }
    return ScalePress.detector(onTap: onTap, child: cell);
  }
}

// ─── helpers ────────────────────────────────────────────────────────────

List<DateTime> _buildMonthGrid(DateTime viewMonth) {
  final DateTime firstOfMonth = DateTime(viewMonth.year, viewMonth.month);
  // Dart: weekday 1=Mon..7=Sun. We want offset to Sunday: Sunday → 0,
  // Monday → 1, ... Saturday → 6.
  final int startOffset = firstOfMonth.weekday % 7;
  final DateTime start = firstOfMonth.subtract(Duration(days: startOffset));
  return <DateTime>[
    for (int i = 0; i < 42; i++) start.add(Duration(days: i)),
  ];
}

DateTime _stripTime(DateTime d) => DateTime(d.year, d.month, d.day);

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

String _monthName(int m) {
  const List<String> names = <String>[
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  return names[m - 1];
}
