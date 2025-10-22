import 'package:flutter/material.dart';
import 'custom_colors.dart';

class CustomBackground {
  final String id;
  final String name;
  final List<Color> backgroundColors;
  final List<Color> elementColors;
  final Color accentColor;
  final double backgroundOpacity;

  CustomBackground({
    required this.id,
    required this.name,
    required this.backgroundColors,
    required this.elementColors,
    required this.accentColor,
    required this.backgroundOpacity,
  });
}

final List<CustomBackground> customBackgrounds = [
  CustomBackground(
    id: 'bg0',
    name: 'Tech-Savvy',
    backgroundColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800.withValues(alpha: 0.75),
    ],
    //requires 3 colors for better gradient effect
    elementColors: [
      CustomColors.turqoise950,
      CustomColors.turqoise950,
      CustomColors.green300,
    ],
    accentColor: CustomColors.green300,
    backgroundOpacity: 0.35,
  ),
  CustomBackground(
    id: 'bg1',
    name: 'Finance',
    backgroundColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.turqoise950,
      CustomColors.turqoise950,
      CustomColors.turqoise500,
    ],
    accentColor: CustomColors.turqoise500,
    backgroundOpacity: 0.35,
  ),
  CustomBackground(
    id: 'bg2',
    name: 'Environment',
    backgroundColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.turqoise950,
      CustomColors.turqoise950,
      CustomColors.green300,
    ],
    accentColor: CustomColors.green300,
    backgroundOpacity: 0.65,
  ),
  CustomBackground(
    id: 'bg3',
    name: 'Doomsday',
    backgroundColors: [
      CustomColors.turqoise800,
      CustomColors.turqoise800.withValues(alpha: 0.75),
    ],
    elementColors: [
      CustomColors.turqoise950,
      CustomColors.turqoise950,
      CustomColors.turqoise500,
    ],
    accentColor: CustomColors.turqoise500,
    backgroundOpacity: 0.65,
  ),
];
