import 'package:flutter/material.dart';

class DashboardPainter extends CustomPainter {
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final double elementOpacity;

  DashboardPainter({
    required this.backgroundColors,
    required this.elementColors,
    this.elementOpacity = 0.35,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Base gradient background
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: backgroundColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    final halfCirclePaint = Paint()..style = PaintingStyle.fill;

    final circlePositions = [
      {'offset': Offset(size.width * 0.1, size.height * 0), 'radius': 400.0},
      {'offset': Offset(size.width * 0, size.height * 1), 'radius': 250.0},
      {'offset': Offset(size.width * 1.2, size.height * 0.7), 'radius': 200.0},
    ];

    for (final circle in circlePositions) {
      final offset = circle['offset'] as Offset;
      final radius = circle['radius'] as double;

      halfCirclePaint.shader = LinearGradient(
        colors: elementColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: offset, radius: radius));

      canvas.save();

      canvas.translate(offset.dx, offset.dy);
      final center = Offset(size.width / 2, size.height / 2);
      final angleToCenter = (center - offset).direction;
      // rotate so the semicircle's midpoint (start + pi/2) points toward the center line
      canvas.rotate(angleToCenter - 3.14159 / 2);
      canvas.translate(-offset.dx, -offset.dy);

      final rect = Rect.fromCircle(center: offset, radius: radius);
      canvas.drawArc(rect, 0, 3.14159, true, halfCirclePaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant DashboardPainter oldDelegate) {
    return oldDelegate.backgroundColors != backgroundColors ||
        oldDelegate.elementColors != elementColors ||
        oldDelegate.elementOpacity != elementOpacity;
  }
}
