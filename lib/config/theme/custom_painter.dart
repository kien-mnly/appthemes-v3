import 'package:flutter/material.dart';

class DashboardPainter extends CustomPainter {
  final List<Color> colors;

  DashboardPainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final circlePaint = Paint()
      ..shader = RadialGradient(
        colors: colors.reversed.toList(),
        center: Alignment.center,
        radius: 1,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final circlePaths = [
      Offset(size.width * 0.1, size.height * 0.1),
      Offset(size.width * 0.1, size.height * 0.9),
      Offset(size.width * 1.2, size.height * 0.7),
    ];
    for (final offset in circlePaths) {
      canvas.drawCircle(offset, 200, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
