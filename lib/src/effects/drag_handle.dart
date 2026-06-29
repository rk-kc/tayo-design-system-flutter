import 'package:flutter/material.dart';

import '../theme/tayo_colors.dart';

/// The little pill at the top of every bottom sheet. 40×4 px, white@25%.
/// Visual affordance for "this is dismissible / draggable".
class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: TayoColors.white25,
        borderRadius: BorderRadius.circular(9999),
      ),
    );
  }
}
