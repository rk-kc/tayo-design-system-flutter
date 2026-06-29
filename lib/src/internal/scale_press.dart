import 'package:flutter/material.dart';

/// Mirrors the React `active:scale-[0.98]` press-feedback feel.
/// Wrap any tappable surface in this to get a tiny scale-down on press.
///
/// Usage: place between the gesture detector and the visual child:
///
/// ```dart
/// GestureDetector(
///   onTap: ...,
///   child: ScalePress(
///     child: Container(...),
///   ),
/// )
/// ```
///
/// Or use the `.detector(...)` factory to combine gesture + scale.
class ScalePress extends StatefulWidget {
  const ScalePress({
    super.key,
    required this.child,
    this.scale = 0.98,
    this.duration = const Duration(milliseconds: 100),
    this.pressed,
  });

  /// Manually controlled mode. Pass a value to drive the scale from
  /// outside (e.g., when the gesture lives on a parent). When null,
  /// the widget exposes nothing useful by itself — pair with
  /// `ScalePress.detector(...)` instead.
  final bool? pressed;

  final Widget child;
  final double scale;
  final Duration duration;

  /// Convenience: pairs a gesture detector with a scale-press. Handles
  /// the press state internally.
  static Widget detector({
    Key? key,
    required Widget child,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    double scale = 0.98,
    HitTestBehavior behavior = HitTestBehavior.opaque,
  }) {
    return _ScalePressDetector(
      key: key,
      onTap: onTap,
      onLongPress: onLongPress,
      scale: scale,
      behavior: behavior,
      child: child,
    );
  }

  @override
  State<ScalePress> createState() => _ScalePressState();
}

class _ScalePressState extends State<ScalePress> {
  @override
  Widget build(BuildContext context) {
    final bool pressed = widget.pressed ?? false;
    return AnimatedScale(
      scale: pressed ? widget.scale : 1.0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: widget.child,
    );
  }
}

class _ScalePressDetector extends StatefulWidget {
  const _ScalePressDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scale = 0.98,
    this.behavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scale;
  final HitTestBehavior behavior;

  @override
  State<_ScalePressDetector> createState() => _ScalePressDetectorState();
}

class _ScalePressDetectorState extends State<_ScalePressDetector> {
  bool _pressed = false;

  void _setPressed(bool p) {
    if (_pressed != p) setState(() => _pressed = p);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: ScalePress(
        pressed: _pressed,
        scale: widget.scale,
        child: widget.child,
      ),
    );
  }
}
