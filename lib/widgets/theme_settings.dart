import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_background.dart';
import '../widgets/custom_safe_area.dart';

class ThemeSettings {
  static Future show({
    required BuildContext context,
    required int selectedThemeIndex,
    required Function(int) onThemeChange,
    required VoidCallback onExit,
    double height = 320,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => ClipPath(
        clipper: ShapeBorderClipper(
          shape: SmoothRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            smoothness: 0.6,
            side: const BorderSide(width: 1, color: CustomColors.dark800),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: height,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CustomSafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  Title(
                    color: CustomColors.light,
                    child: Text(
                      'Thema Instellingen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.light,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Verander het thema van je dashboard of pas de naam aan.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CustomColors.light,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(customBackgrounds.length, (index) {
                        final theme = customBackgrounds[index];
                        final isSelected = index == selectedThemeIndex;
                        return GestureDetector(
                          onTap: () => onThemeChange(index),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: theme.backgroundColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? CustomColors.green300
                                    : CustomColors.dark400,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
