import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_background.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/button.dart';
import '../config/theme/custom_painter.dart';
import '../config/theme/size_setter.dart';

class ThemeSettings {
  static Future show({
    required BuildContext context,
    required int selectedThemeIndex,
    required Function(int) onThemeChange,
    required VoidCallback onExit,
    double height = 480,
    double opacity = 0.5,
    double blurSigma = 12,
  }) {
    int currentIndex = selectedThemeIndex;
    return showCupertinoModalPopup(
      context: context,
      barrierColor: CustomColors.dark.withValues(alpha: opacity),
      filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setModalState) => ClipPath(
          clipper: ShapeBorderClipper(
            shape: SmoothRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              smoothness: 0.6,
              side: const BorderSide(width: 2, color: CustomColors.dark800),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              height: height,
              color: CustomColors.dark.withValues(alpha: opacity),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeSetter.getHorizontalScreenPadding(),
                  vertical: 15,
                ),
                child: CustomSafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      Title(
                        color: CustomColors.light,
                        child: Text(
                          'Thema Instellingen',
                          style: TextStyle(
                            fontSize: 24,
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
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...List.generate(customBackgrounds.length, (index) {
                            final theme = customBackgrounds[index];
                            final isSelected = index == currentIndex;
                            return GestureDetector(
                              onTap: () {
                                if (currentIndex != index) {
                                  setModalState(() => currentIndex = index);
                                }
                                onThemeChange(index);
                              },
                              child: SizedBox(
                                width: 78,
                                height: 78,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: isSelected
                                          ? CustomColors.green300
                                          : CustomColors.light,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CustomPaint(
                                          painter: ThemeSelector(
                                            backgroundColors:
                                                theme.backgroundColors,
                                            elementColors: theme.elementColors,
                                            elementOpacity: 0.42,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Button(
                        title: 'Huidige Dashboard Thema placeholder',
                        onPressed: () {
                          onThemeChange(currentIndex);
                          onExit();
                          Navigator.of(context).pop();
                        },
                        type: ButtonType.outline,
                      ),
                      const SizedBox(height: 12),
                      Button(
                        title: 'Opslaan',
                        onPressed: () {
                          onThemeChange(currentIndex);
                          onExit();
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 12),
                      Button(
                        title: 'Annuleren',
                        onPressed: () {
                          onThemeChange(currentIndex);
                          onExit();
                          Navigator.of(context).pop();
                        },
                        type: ButtonType.secondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
