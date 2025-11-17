import 'package:flutter/material.dart';

import '../config/theme/custom_painter.dart';
import '../models/custom_background.dart';

class DashboardBackground extends StatelessWidget {
  final CustomBackground background;
  final Widget child;

  const DashboardBackground({
    super.key,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: DashboardPainter(
            backgroundColors: background.backgroundColor,
            elementColors: background.elementColors,
            elementOpacity: background.backgroundOpacity,
          ),
          child: const SizedBox.expand(),
        ),
        child,
      ],
    );
  }
}
