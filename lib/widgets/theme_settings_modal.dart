import 'dart:ui';
import 'package:appthemes_v3/widgets/bottom_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_background.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/button.dart';
import '../config/theme/custom_painter.dart';
import '../config/theme/size_setter.dart';

class ThemeSettingsModal extends StatefulWidget {
  const ThemeSettingsModal({
    super.key,
    required this.selectedThemeIndex,
    required this.onThemeChange,
    required this.onExit,
  });

  final int selectedThemeIndex;
  final ValueChanged<int> onThemeChange;
  final VoidCallback onExit;

  static Future<void> show({
    required BuildContext context,
    required int selectedThemeIndex,
    required Function(int) onThemeChange,
    required VoidCallback onExit,
  }) async {
    await BottomDialog.showCustom(
      context: context,
      child: ThemeSettingsModal(
        selectedThemeIndex: selectedThemeIndex,
        onThemeChange: onThemeChange,
        onExit: onExit,
      ),
    );
  }

  @override
  State<ThemeSettingsModal> createState() => _ThemeSettingsModalState();
}

class _ThemeSettingsModalState extends State<ThemeSettingsModal> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedThemeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(customBackgrounds.length, (index) {
              final theme = customBackgrounds[index];
              final isSelected = index == currentIndex;
              return GestureDetector(
                onTap: () {
                  if (currentIndex != index) {
                    setState(() {
                      currentIndex = index;
                    });
                    (() => currentIndex = index);
                  }
                  widget.onThemeChange(index);
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
                              backgroundColors: theme.backgroundColors,
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
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
          type: ButtonType.outline,
        ),
        const SizedBox(height: 12),
        Button(
          title: 'Opslaan',
          onPressed: () {
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 12),
        Button(
          title: 'Annuleren',
          onPressed: () {
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
          type: ButtonType.secondary,
        ),
      ],
    );
  }
}
