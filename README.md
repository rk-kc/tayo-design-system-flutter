# tayo_design_system (Flutter)

Flutter port of the [Tayo design system](../design-system/). Same brand,
same tokens, same components — native Flutter widgets instead of React.

**Brand spec is the single source of truth** at
[`../design-system/DESIGN_SYSTEM.md`](../design-system/DESIGN_SYSTEM.md).
This Flutter package implements that spec; whenever the two diverge,
fix the docs first, then the code.

## What's inside

- **Tokens** — colors (`leaf`, `sun`, `ink`, glass, semantic), radii,
  shadows (including the brand-signature glass shadow with sun-tinted
  halo), motion curves + durations, spacing, typography (Libre
  Baskerville variable font).
- **`TayoTheme.dark()`** — single composer that wires `ColorScheme.dark`,
  `TextTheme`, and a `TayoThemeExtension` carrying everything Material
  doesn't model.
- **15 widgets** — Button, Input, Card, Avatar, Badge, Stat, Skeleton,
  Fab, TabBar, BottomSheet, Dialog, ActionSheet, Calendar, DatePicker,
  UserDetailSheet.
- **Asymmetric sheet motion** — 360ms enter / 280ms exit, the brand's
  signature. Implemented via a custom `PopupRoute` (`_SheetRoute`) since
  Flutter's `showModalBottomSheet` can't express asymmetric timings.

## Quick start (consumer app)

```yaml
# in your app's pubspec.yaml
dependencies:
  tayo_design_system:
    path: ../design-system-flutter
```

```dart
import 'package:flutter/material.dart';
import 'package:tayo_design_system/tayo_design_system.dart';

void main() {
  runApp(MaterialApp(
    theme: TayoTheme.dark(),
    themeMode: ThemeMode.dark,
    home: Scaffold(
      body: Center(
        child: TayoButton(label: 'Hello', onPressed: () {}),
      ),
    ),
  ));
}
```

## First-time setup

This repo ships only the Dart source. To run the showcase or any Flutter
test, you need a Flutter SDK and platform folders.

1. **Install Flutter** — `brew install --cask flutter`, then
   `flutter doctor` to validate.

2. **Bootstrap platform folders for the showcase**:
   ```bash
   cd example
   flutter create . --project-name tayo_design_system_example \
     --org com.kloudcore.tayo
   flutter pub get
   ```

3. **Run the showcase**:
   ```bash
   flutter run
   ```

The showcase mirrors the React design-system's gallery: Tokens →
Primitives → Overlays → Patterns.

## Fonts

`fonts/LibreBaskerville-VariableFont_wght.ttf` is bundled and declared
in `pubspec.yaml`. Weights apply per-style via `FontVariation` on the
`wght` axis (400 = Regular, 600 = SemiBold, 700 = Bold).

**License**: Libre Baskerville is **SIL OFL 1.1**. The full license
text must travel with the font. See `fonts/OFL.txt` for a summary;
drop the canonical `OFL-LICENSE.txt` from the Google Fonts download
alongside it before publishing.

## Architecture notes

- **Read tokens via `context.tayo`** — the convenience accessor returns
  the `TayoThemeExtension` or a safe default. Widgets never import
  `TayoColors` directly. This is the single chokepoint for re-theming.
- **Sheets always use the root navigator** —
  `Navigator.of(context, rootNavigator: true)` inside `showTayoBottomSheet`.
  Sheets pushed onto a `StatefulShellRoute` branch would be trapped in
  the wrong stack.
- **GlassSurface is everywhere** — cards, sheets, inputs, calendars all
  compose on top of it. If you need to optimize blur perf on lower-end
  Android, that's the chokepoint.

## Risks worth knowing

- **BackdropFilter perf**: stacked blurs (a sheet over a glassy screen)
  hit GPU hard on mid-range Android. The sheet barrier uses a light
  `sigma: 4` to keep it cheap; consider `RepaintBoundary` around the
  underlying glass surfaces when a sheet is open.
- **Flutter web rendering**: `BackdropFilter` looks broken with the
  HTML renderer. Use CanvasKit: `flutter run -d chrome --web-renderer canvaskit`.

## Versioning

`0.1.0` — initial scaffold, full parity with the React design system at
`0.1.0` (May 2026). No public release; consumed via local `path:` deps
within the Tayo monorepo.
