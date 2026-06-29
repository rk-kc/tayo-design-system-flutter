import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/tayo_blur.dart';
import '../theme/tayo_colors.dart';
import '../theme/tayo_motion.dart';

/// Internal `PopupRoute` that powers `TayoBottomSheet` and `TayoDialog`.
///
/// The whole reason this exists: Flutter's stock `showModalBottomSheet`
/// has a single `transitionDuration`, so enter/exit timings can't differ.
/// Tayo's signature motion is **asymmetric** — sheets enter at 360ms
/// (settles in) and leave at 280ms (snappier). That's the brand.
///
/// Use the `kind` parameter to pick sheet vs dialog timings. Builders
/// receive forward/reverse `Animation<double>` (driven via the
/// `_paired*Animation` helpers) so they can apply their own
/// SlideTransition / FadeTransition / ScaleTransition.
class SheetRoute<T> extends PopupRoute<T> {
  SheetRoute({
    required this.builder,
    required this.kind,
    this.barrierDismissibleOverride,
    this.semanticsLabel,
    this.maxWidth = 448,
  });

  /// Builds the contents of the sheet/dialog. The first animation
  /// drives the enter timing, the second drives the exit timing — both
  /// progress 0→1 (you don't need to reverse anything yourself; the
  /// route swaps which one to use).
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
  ) builder;

  final SheetKind kind;

  /// `barrierDismissible` is normally tied to `kind`; pass non-null to
  /// override (e.g. a Dialog with `dismissable: false`).
  final bool? barrierDismissibleOverride;

  final String? semanticsLabel;
  final double maxWidth;

  @override
  Color? get barrierColor => const Color(0xB3000000); // black/70

  @override
  bool get barrierDismissible =>
      barrierDismissibleOverride ?? (kind != SheetKind.dialogModal);

  @override
  String? get barrierLabel => semanticsLabel ?? 'Dismiss';

  @override
  Duration get transitionDuration => switch (kind) {
        SheetKind.bottomSheet => TayoMotion.sheetIn,
        SheetKind.dialog || SheetKind.dialogModal => TayoMotion.fade,
      };

  @override
  Duration get reverseTransitionDuration => switch (kind) {
        SheetKind.bottomSheet => TayoMotion.sheetOut,
        SheetKind.dialog || SheetKind.dialogModal => TayoMotion.fade,
      };

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // Backdrop blur is applied by the route on a separate layer below
    // the content so each sheet doesn't have to re-render it.
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        IgnorePointer(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: TayoBlur.sm,
              sigmaY: TayoBlur.sm,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        Align(
          alignment: switch (kind) {
            SheetKind.bottomSheet => Alignment.bottomCenter,
            // Dialogs: bottom on narrow viewports, center otherwise.
            SheetKind.dialog ||
            SheetKind.dialogModal =>
              MediaQuery.sizeOf(context).width >= 600
                  ? Alignment.center
                  : Alignment.bottomCenter,
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: builder(context, animation),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child; // Per-widget transitions live in `builder` — they have
    // direct access to the animation and can compose
    // SlideTransition + FadeTransition the way they want.
  }
}

enum SheetKind { bottomSheet, dialog, dialogModal }

/// Curved animation pre-set for the "enter" half of any sheet/dialog.
/// Use `_paired*Animation` helpers in widget builders so the curves are
/// consistent across the system.
CurvedAnimation pairedEnterCurve(Animation<double> a, SheetKind kind) {
  return CurvedAnimation(
    parent: a,
    curve: switch (kind) {
      SheetKind.bottomSheet => TayoMotion.easeOutExpo,
      SheetKind.dialog || SheetKind.dialogModal => TayoMotion.easeSnap,
    },
    reverseCurve: switch (kind) {
      SheetKind.bottomSheet => TayoMotion.easeSnap,
      SheetKind.dialog || SheetKind.dialogModal => TayoMotion.easeSnap,
    },
  );
}

/// Backdrop dim color above the blur. Exported for any custom barriers
/// that don't go through `SheetRoute`.
const Color kTayoBackdrop = TayoColors.ink;
