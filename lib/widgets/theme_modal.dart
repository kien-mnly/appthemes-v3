import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_painter.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:appthemes_v3/config/theme/theme_presets.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/services/background_service.dart';
import 'package:flutter/material.dart';

class ThemeModal extends StatefulWidget {
  const ThemeModal({
    super.key,
    required this.selectedThemeIndex,
    required this.onThemeChange,
    required this.onPresetDashboard,
  });

  final int selectedThemeIndex;
  final ValueChanged<int> onThemeChange;
  final ValueChanged<List<DashboardWidget>> onPresetDashboard;

  @override
  State<ThemeModal> createState() => _ThemeModalState();
}

class _ThemeModalState extends State<ThemeModal> {
  late int currentIndex;
  late int originalIndex;
  // bool _saved = false;
  late final BackgroundService selectTheme = locator<BackgroundService>();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedThemeIndex;
    originalIndex = widget.selectedThemeIndex;
  }

  @override
  Widget build(BuildContext context) {
    final presetList = PresetList.presets;
    final accent = presetList[currentIndex].theme.customBackground.accentColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(presetList.length, (index) {
          final preset = presetList[index];
          final theme = preset.theme;
          final isSelected = index == currentIndex;
          final themeLabel = preset.name;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (currentIndex != index) {
                    setState(() {
                      currentIndex = index;
                    });
                    final selectedPreset = presetList[index];
                    // Pass index for theme selection
                    widget.onThemeChange(index);

                    // Build dashboard from preset
                    widget.onPresetDashboard(
                      PresetList.buildFromPreset(selectedPreset),
                    );
                  }
                  // Preview selected preset's background theme
                  selectTheme.preferredTheme = presetList[currentIndex].theme;
                },
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        themeLabel,
                        style: CustomTheme(context)
                            .themeData
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              color: isSelected ? accent : CustomColors.light,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
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
                                      theme.customBackground.backgroundColor,
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
                    const SizedBox(width: 18),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        }),
      ],
    );
  }
}
