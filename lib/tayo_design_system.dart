/// Tayo design system — Flutter port.
///
/// Mirrors the React design system at `../../design-system/`.
/// See `../../design-system/DESIGN_SYSTEM.md` for the brand spec; it is
/// the source of truth for both ports.
///
/// Usage:
/// ```dart
/// import 'package:tayo_design_system/tayo_design_system.dart';
///
/// MaterialApp(
///   theme: TayoTheme.dark(),
///   themeMode: ThemeMode.dark,
///   home: Scaffold(
///     body: TayoButton(label: 'Hi', onPressed: () {}),
///   ),
/// );
/// ```
library tayo_design_system;

// ── Theme ─────────────────────────────────────────────────────────────
export 'src/theme/tayo_blur.dart';
export 'src/theme/tayo_colors.dart';
export 'src/theme/tayo_motion.dart';
export 'src/theme/tayo_radii.dart';
export 'src/theme/tayo_shadows.dart';
export 'src/theme/tayo_spacing.dart';
export 'src/theme/tayo_theme.dart';
export 'src/theme/tayo_theme_ext.dart';
export 'src/theme/tayo_typography.dart';

// ── Effects ───────────────────────────────────────────────────────────
export 'src/effects/ambient_orbs.dart';
export 'src/effects/drag_handle.dart';
export 'src/effects/glass_surface.dart';
export 'src/effects/skeleton_pulse.dart';
export 'src/effects/sun_glow.dart';

// ── Gesture helpers (exposed for consumer-app composition) ────────────
export 'src/internal/scale_press.dart';

// ── Widgets — primitives ──────────────────────────────────────────────
export 'src/widgets/tayo_avatar.dart';
export 'src/widgets/tayo_badge.dart';
export 'src/widgets/tayo_button.dart';
export 'src/widgets/tayo_card.dart';
export 'src/widgets/tayo_fab.dart';
export 'src/widgets/tayo_input.dart';
export 'src/widgets/tayo_skeleton.dart';
export 'src/widgets/tayo_stat.dart';
export 'src/widgets/tayo_tab_bar.dart';

// ── Widgets — overlays ────────────────────────────────────────────────
export 'src/widgets/tayo_action_sheet.dart';
export 'src/widgets/tayo_bottom_sheet.dart';
export 'src/widgets/tayo_dialog.dart';

// ── Widgets — date + composed ─────────────────────────────────────────
export 'src/widgets/tayo_calendar.dart';
export 'src/widgets/tayo_date_picker.dart';
export 'src/widgets/tayo_user_detail_sheet.dart';
