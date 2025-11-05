import 'package:flutter/material.dart';

class CustomBackground {
  final String id;
  final String name;
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final Color accentColor;
  final double backgroundOpacity;
  final Color background;

  CustomBackground({
    required this.id,
    required this.name,
    required this.backgroundColors,
    required this.elementColors,
    required this.accentColor,
    required this.backgroundOpacity,
    required this.background,
  });
}
