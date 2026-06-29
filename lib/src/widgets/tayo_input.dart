import 'package:flutter/material.dart';

import '../theme/tayo_colors.dart';
import '../theme/tayo_radii.dart';
import '../theme/tayo_theme_ext.dart';
import '../theme/tayo_typography.dart';

enum TayoInputSize { sm, md, lg }

/// Frosted-glass text input with optional left icon. Heights match
/// `TayoButton` so they pair cleanly in row layouts.
class TayoInput extends StatefulWidget {
  const TayoInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.leftIcon,
    this.size = TayoInputSize.md,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final Widget? leftIcon;
  final TayoInputSize size;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enabled;
  final int? maxLines;
  final FocusNode? focusNode;

  @override
  State<TayoInput> createState() => _TayoInputState();
}

class _TayoInputState extends State<TayoInput> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_hasFocus != _focusNode.hasFocus) {
      setState(() => _hasFocus = _focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tayo = context.tayo;
    final double height = switch (widget.size) {
      TayoInputSize.sm => 36,
      TayoInputSize.md => 48,
      TayoInputSize.lg => 56,
    };
    final double iconSize = switch (widget.size) {
      TayoInputSize.sm => 14,
      TayoInputSize.md => 16,
      TayoInputSize.lg => 20,
    };
    final double iconLeftOffset = switch (widget.size) {
      TayoInputSize.sm => 10,
      _ => 16,
    };
    final EdgeInsets textPadding = switch (widget.size) {
      TayoInputSize.sm => EdgeInsets.only(
          left: widget.leftIcon == null ? 12 : 32,
          right: 12,
        ),
      TayoInputSize.md => EdgeInsets.only(
          left: widget.leftIcon == null ? 16 : 44,
          right: 16,
        ),
      TayoInputSize.lg => EdgeInsets.only(
          left: widget.leftIcon == null ? 20 : 48,
          right: 20,
        ),
    };

    final TextStyle textStyle = switch (widget.size) {
      TayoInputSize.sm => TayoTypography.textTheme.bodySmall!,
      TayoInputSize.md => TayoTypography.textTheme.bodyMedium!,
      TayoInputSize.lg => TayoTypography.textTheme.bodyLarge!,
    };

    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          // Glass surface body
          Container(
            decoration: BoxDecoration(
              color: tayo.glassFill,
              border: Border.all(
                color: _hasFocus ? tayo.leaf : tayo.glassBorder,
                width: _hasFocus ? 2 : 1,
              ),
              borderRadius: TayoRadii.md,
            ),
          ),
          // Text field
          Padding(
            padding: textPadding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                autofocus: widget.autofocus,
                enabled: widget.enabled,
                maxLines: widget.maxLines,
                style: textStyle.copyWith(color: Colors.white),
                cursorColor: tayo.leaf,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: textStyle.copyWith(color: TayoColors.white25),
                ),
              ),
            ),
          ),
          // Left icon
          if (widget.leftIcon != null)
            Positioned(
              left: iconLeftOffset,
              top: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      size: iconSize,
                      color: TayoColors.white25,
                    ),
                    child: widget.leftIcon!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
