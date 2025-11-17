import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:flutter/cupertino.dart';
import '../config/theme/custom_colors.dart';
import '../models/enums/background_theme.dart';
import '../widgets/button.dart';
import '../config/theme/custom_painter.dart';
import 'package:appthemes_v3/services/background_service.dart';

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

  @override
  State<ThemeSettingsModal> createState() => _ThemeSettingsModalState();
}

class _ThemeSettingsModalState extends State<ThemeSettingsModal> {
  late int currentIndex;
  late final BackgroundService selectTheme = locator<BackgroundService>();

  @override
  void initState() {
    super.initState();
    currentIndex = selectTheme.preferredTheme.index;
  }

  @override
  Widget build(BuildContext context) {
    final accent = selectTheme.currentBackgroundTheme.accentColor;
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
            ...List.generate(BackgroundTheme.values.length - 1, (index) {
              final theme = BackgroundTheme.values[index];
              final isSelected = index == currentIndex;
              return GestureDetector(
                onTap: () {
                  if (currentIndex != index) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                  selectTheme.preferredTheme =
                      BackgroundTheme.values[currentIndex];
                },
                child: SizedBox(
                  width: 78,
                  height: 78,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? accent : CustomColors.light,
                        width: 1.25,
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
                                  theme.customBackground.backgroundColors,
                              elementColors:
                                  theme.customBackground.elementColors,
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
        const SizedBox(height: 16),
        Button(
          title: 'Huidige Dashboard Thema placeholder',
          onPressed: () {
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
          type: ButtonType.outline,
        ),
        const SizedBox(height: 16),
        Button(
          title: 'Opslaan',
          onPressed: () {
            selectTheme.preferredTheme = BackgroundTheme.values[currentIndex];
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 16),
        Button(
          title: 'Annuleren',
          onPressed: () {
            widget.onThemeChange(currentIndex);
            widget.onExit();
            Navigator.of(context).pop();
          },
          type: ButtonType.secondary,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
