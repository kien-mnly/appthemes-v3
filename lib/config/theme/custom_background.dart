import 'package:flutter/material.dart';
import 'custom_colors.dart';

class CustomBackground {
  final String id;
  final String name;
  final List<Color> backgroundColors;
  final Color accentColor;

  CustomBackground({
    required this.id,
    required this.name,
    required this.backgroundColors,
    required this.accentColor,
  });
}

final List<CustomBackground> customBackgrounds = [
  CustomBackground(
    id: 'bg0',
    name: 'Tech-Savvy',
    backgroundColors: [CustomColors.green800, CustomColors.green700],
    accentColor: CustomColors.green300,
  ),
  CustomBackground(
    id: 'bg1',
    name: 'Finance',
    backgroundColors: [CustomColors.turqoise800, CustomColors.turqoise500],
    accentColor: CustomColors.turqoise500,
  ),
  CustomBackground(
    id: 'bg2',
    name: 'Environment',
    backgroundColors: [CustomColors.green800, CustomColors.green300],
    accentColor: CustomColors.green300,
  ),
  CustomBackground(
    id: 'bg3',
    name: 'Doomsday',
    backgroundColors: [CustomColors.turqoise800, CustomColors.turqoise500],
    accentColor: CustomColors.turqoise500,
  ),
];
