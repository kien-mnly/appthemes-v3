import 'package:flutter/material.dart';
import '../config/theme/custom_background.dart';
import '../config/theme/custom_painter.dart';

class DashboardBackground extends StatelessWidget {
  final CustomBackground background;

  const DashboardBackground({super.key, required this.background});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashboardPainter(
        backgroundColors: background.backgroundColors,
        elementColors: background.elementColors,
        elementOpacity: background.backgroundOpacity,
      ),
      child: Container(),
    );
  }
}
