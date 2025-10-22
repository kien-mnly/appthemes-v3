import 'package:flutter/material.dart';
import 'custom_colors.dart';

class CustomBackground {
  final String id;
  final String name;
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final Color accentColor;
  final double elementOpacity;

  CustomBackground({
    required this.id,
    required this.name,
    required this.backgroundColors,
    required this.elementColors,
    required this.accentColor,
    this.elementOpacity = 1.0,
  });
}

final List<CustomBackground> customBackgrounds = [
  CustomBackground(
    id: 'bg0',
    name: 'Tech-Savvy',
    backgroundColors: [
      CustomColors.green800,
      CustomColors.green800.withValues(alpha: 0.75),
    ],
    //requires 3 colors for better gradient effect
    elementColors: [
      CustomColors.green800,
      CustomColors.green800,
      CustomColors.green300,
    ],
    accentColor: CustomColors.green300,
    elementOpacity: 0.75,
  ),
  CustomBackground(
    id: 'bg1',
    name: 'Finance',
    backgroundColors: [
      CustomColors.green800,
      CustomColors.green800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800,
      CustomColors.turqoise500,
    ],
    accentColor: CustomColors.turqoise500,
    elementOpacity: 0.75,
  ),
  CustomBackground(
    id: 'bg2',
    name: 'Environment',
    backgroundColors: [
      CustomColors.green800,
      CustomColors.green800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.green800,
      CustomColors.green800,
      CustomColors.green300,
    ],
    accentColor: CustomColors.green300,
    elementOpacity: 0.75,
  ),
  CustomBackground(
    id: 'bg3',
    name: 'Doomsday',
    backgroundColors: [
      CustomColors.green800,
      CustomColors.green800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800,
      CustomColors.turqoise500,
    ],
    accentColor: CustomColors.turqoise500,
    elementOpacity: 0.75,
  ),
];
