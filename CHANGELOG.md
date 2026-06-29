# Changelog

## 0.1.0 — initial scaffold (2026-05-31)

- Full token system: colors (leaf / sun / ink / glass / semantic), radii,
  shadows (incl. glass with sun halo), motion (asymmetric sheet curves),
  spacing, typography (Libre Baskerville variable font).
- 15 widgets: Button, Input, Card, Avatar, Badge, Stat, Skeleton, Fab,
  TabBar, BottomSheet, Dialog, ActionSheet, Calendar, DatePicker,
  UserDetailSheet.
- Effects: GlassSurface, SunGlow, AmbientOrbs, SkeletonPulse, DragHandle.
- Custom PopupRoute (`_SheetRoute`) with asymmetric enter/exit durations
  matching the React design system's signature motion (360ms in / 280ms
  out for sheets, 200ms for dialogs).
- Showcase `example/` app mirroring the four React showcase pages
  (Tokens / Primitives / Overlays / Patterns).
