import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

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

    final halfCirclePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final layerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final layerCompositePaint = Paint()
      ..color = Colors.white.withValues(alpha: elementOpacity);
    canvas.saveLayer(layerRect, layerCompositePaint);

    final opaqueColors = elementColors
        .map((c) => c.withValues(alpha: 1.0))
        .toList();

    final circlePositions = [
      {'offset': Offset(size.width * 0.1, size.height * 0), 'radius': 400.0},
      {'offset': Offset(size.width * 0, size.height * 1), 'radius': 250.0},
      {'offset': Offset(size.width * 1.2, size.height * 0.75), 'radius': 200.0},
    ];

    for (final circle in circlePositions) {
      final offset = circle['offset'] as Offset;
      final radius = circle['radius'] as double;

      halfCirclePaint.shader = LinearGradient(
        colors: opaqueColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: offset, radius: radius));

      canvas.save();

      canvas.translate(offset.dx, offset.dy);

      // rotate so the semicircle's midpoint (start + pi/2) points toward the center line
      final center = Offset(size.width / 2, size.height / 2);
      final angleToCenter = (center - offset).direction;
      canvas.rotate(angleToCenter - math.pi / 2);
      canvas.translate(-offset.dx, -offset.dy);

      final rect = Rect.fromCircle(center: offset, radius: radius);
      canvas.drawArc(rect, 0, math.pi, true, halfCirclePaint);

      canvas.restore();
    }

    // --- Mono noise overlay ---
    // Noise parameters requested:
    // size: 0.5, density: 75%, color: #000000 with 35% opacity
    final double noiseSize = 0.5;
    final double density = 0.75;
    final Paint noisePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = noiseSize
      ..isAntiAlias = true;

    // Build a grid of sample points (1px step) and keep ~density of them.
    // We use a fixed seed for deterministic results across frames.
    final rand = math.Random(42);
    final List<Offset> noisePoints = <Offset>[];
    for (double x = 0; x < size.width; x += 1.0) {
      for (double y = 0; y < size.height; y += 1.0) {
        if (rand.nextDouble() <= density) {
          // jitter to avoid strict grid appearance
          final dx = x + rand.nextDouble();
          final dy = y + rand.nextDouble();
          noisePoints.add(Offset(dx, dy));
        }
      }
    }

    if (noisePoints.isNotEmpty) {
      canvas.drawPoints(PointMode.points, noisePoints, noisePaint);
    }

    // restore the layer created earlier
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant DashboardPainter oldDelegate) {
    return oldDelegate.backgroundColors != backgroundColors ||
        oldDelegate.elementColors != elementColors ||
        oldDelegate.elementOpacity != elementOpacity;
  }
}
