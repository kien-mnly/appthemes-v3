import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Shared helper class for painting gradient background,
/// semi-circular elements, and optional noise overlay.
class CirclePatternPainterHelper {
  static void drawBackground(
    Canvas canvas,
    Size size,
    List<Color> backgroundColors,
  ) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: backgroundColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  /// Draws semi-circular gradient shapes with flexible rotation control.
  ///
  /// - [rotationMode]: `'center'` (default), `'none'`, or `'custom'`.
  /// - [rotationCallback]: if `rotationMode == 'custom'`, provides an angle (radians) for each circle.
  ///

  static void drawHalfCircles({
    required Canvas canvas,
    required Size size,
    required List<Color> elementColors,
    required double elementOpacity,
    required List<Map<String, dynamic>> circles,
    String rotationMode = 'center',
    double Function(int index, Offset offset, Size size)? rotationCallback,
  }) {
    final layerRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final overlayPaint = Paint()
      ..color = Colors.white.withValues(alpha: elementOpacity);
    canvas.saveLayer(layerRect, overlayPaint);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final opaqueColors = elementColors
        .map((c) => c.withValues(alpha: 1))
        .toList();

    for (final circle in circles) {
      final offset = circle['offset'] as Offset;
      final radius = circle['radius'] as double;

      paint.shader = LinearGradient(
        colors: opaqueColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: offset, radius: radius));

      // --- Rotation handling ---
      double rotationAngle = 0;
      if (rotationMode == 'center') {
        final center = Offset(size.width / 2, size.height / 2);
        rotationAngle = (center - offset).direction - math.pi / 2;
      } else if (rotationMode == 'custom' && rotationCallback != null) {
        rotationAngle = rotationCallback(circles.indexOf(circle), offset, size);
      }

      canvas.save();
      if (rotationMode != 'none') {
        canvas.translate(offset.dx, offset.dy);
        canvas.rotate(rotationAngle);
        canvas.translate(-offset.dx, -offset.dy);
      }

      final rect = Rect.fromCircle(center: offset, radius: radius);
      canvas.drawArc(rect, 0, math.pi, true, paint);
      canvas.restore();
    }
    canvas.restore();
  }

  static void drawNoise({
    required Canvas canvas,
    required Size size,
    required double strokeWidth,
    required double opacity,
    required double density,
    int? seed,
  }) {
    final rand = math.Random(seed);
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    final points = <Offset>[];
    for (double x = 0; x < size.width; x += 1.0) {
      for (double y = 0; y < size.height; y += 1.0) {
        if (rand.nextDouble() <= density) {
          points.add(Offset(x + rand.nextDouble(), y + rand.nextDouble()));
        }
      }
    }
    if (points.isNotEmpty) {
      canvas.drawPoints(PointMode.points, points, paint);
    }
  }
}

class DashboardPainter extends CustomPainter {
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final double elementOpacity;

  DashboardPainter({
    required this.backgroundColors,
    required this.elementColors,
    this.elementOpacity = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    CirclePatternPainterHelper.drawBackground(canvas, size, backgroundColors);

    final circles = [
      {'offset': Offset(size.width * 0.1, size.height * 0), 'radius': 400.0},
      {'offset': Offset(size.width * 0, size.height * 1), 'radius': 250.0},
      {'offset': Offset(size.width * 1.2, size.height * 0.75), 'radius': 200.0},
    ];

    CirclePatternPainterHelper.drawHalfCircles(
      canvas: canvas,
      size: size,
      elementColors: elementColors,
      elementOpacity: elementOpacity,
      circles: circles,
    );

    CirclePatternPainterHelper.drawNoise(
      canvas: canvas,
      size: size,
      strokeWidth: 0.65,
      opacity: 0.35,
      density: 0.75,
    );
  }

  @override
  bool shouldRepaint(covariant DashboardPainter oldDelegate) =>
      oldDelegate.backgroundColors != backgroundColors ||
      oldDelegate.elementColors != elementColors ||
      oldDelegate.elementOpacity != elementOpacity;
}

class ThemeSelector extends CustomPainter {
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final double elementOpacity;

  ThemeSelector({
    required this.backgroundColors,
    required this.elementColors,
    this.elementOpacity = 0.45,
  });

  @override
  void paint(Canvas canvas, Size size) {
    CirclePatternPainterHelper.drawBackground(canvas, size, backgroundColors);

    final circles = [
      {
        'offset': Offset(size.width * -0.12, size.height * 0.25),
        'radius': 40.0,
      },
      {'offset': Offset(size.width * 0.92, size.height * 0.4), 'radius': 40.0},
      {'offset': Offset(size.width * 0.8, size.height * 1.2), 'radius': 40.0},
    ];

    CirclePatternPainterHelper.drawHalfCircles(
      canvas: canvas,
      size: size,
      elementColors: elementColors,
      elementOpacity: elementOpacity,
      circles: circles,
      rotationMode: 'custom',
      rotationCallback: (index, offset, size) {
        if (index == 0) {
          return 6;
        } else if (index == 1) {
          return 3;
        } else if (index == 2) {
          return 3;
        }
        return 0;
      },
    );

    CirclePatternPainterHelper.drawNoise(
      canvas: canvas,
      size: size,
      strokeWidth: 0.9,
      opacity: 0.22,
      density: 0.5,
      seed: 64,
    );
  }

  @override
  bool shouldRepaint(covariant ThemeSelector oldDelegate) =>
      oldDelegate.backgroundColors != backgroundColors ||
      oldDelegate.elementColors != elementColors ||
      oldDelegate.elementOpacity != elementOpacity;
}
