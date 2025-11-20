import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_painter.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/models/custom_dashboard.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:appthemes_v3/models/theme_presets.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/services/background_service.dart';
import 'package:appthemes_v3/services/dashboard_controller.dart';
import 'package:flutter/material.dart';

class ThemeModal extends StatefulWidget {
  const ThemeModal({
    super.key,
    required this.selectedThemeIndex,
    required this.onThemeChange,
    required this.onPresetDashboard,
    required this.customDashboards,
    required this.onCustomDashboardSelected,
    required this.onDeleteCustomDashboard,
    this.activeCustomDashboardName,
    this.onCustomDashboardEditor,
  });

  final int selectedThemeIndex;
  final ValueChanged<int> onThemeChange;
  final ValueChanged<List<DashboardWidget>> onPresetDashboard;
  final List<CustomDashboard> customDashboards;
  final ValueChanged<CustomDashboard> onCustomDashboardSelected;
  final ValueChanged<CustomDashboard> onDeleteCustomDashboard;
  final String? activeCustomDashboardName;
  final ValueChanged<String>? onCustomDashboardEditor;

  @override
  State<ThemeModal> createState() => _ThemeModalState();
}

class _ThemeModalState extends State<ThemeModal> {
  late final DashboardController controller = locator<DashboardController>();
  late final BackgroundService selectTheme = locator<BackgroundService>();
  String? selectedDashboardType;
  int? selectedDashboardIndex;

  @override
  void initState() {
    super.initState();

    if (controller.activeCustomDashboardName != null) {
      final index = controller.customDashboards.indexWhere(
        (d) => d.name == controller.activeCustomDashboardName,
      );
      if (index != -1) {
        selectedDashboardType = 'custom';
        selectedDashboardIndex = index;
        return;
      }
    }
    selectedDashboardType = 'preset';
    selectedDashboardIndex = controller.selectedThemeIndex;
  }

  @override
  Widget build(BuildContext context) {
    final presetList = PresetList.presets;
    final accent = selectTheme.currentBackgroundTheme.accentColor;
    final maxHeight = MediaQuery.of(context).size.height * 0.6;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Preset dashboards',
              style: CustomTheme(context).themeData.textTheme.titleSmall
                  ?.copyWith(color: CustomColors.light),
            ),
            const SizedBox(height: 8),
            ...List.generate(presetList.length, (index) {
              final preset = presetList[index];
              final theme = preset.theme;
              final isSelected =
                  selectedDashboardIndex == index &&
                  selectedDashboardType == 'preset';
              final themeLabel = preset.name;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (selectedDashboardIndex != index ||
                          selectedDashboardType != 'preset') {
                        setState(() {
                          selectedDashboardIndex = index;
                          selectedDashboardType = 'preset';
                        });
                        final selectedPreset = presetList[index];
                        // Pass index for theme selection
                        widget.onThemeChange(index);
                        // Build dashboard from preset
                        widget.onPresetDashboard(
                          PresetList.buildFromPreset(selectedPreset),
                        );
                        selectTheme.preferredTheme =
                            presetList[selectedDashboardIndex!].theme;
                        Navigator.of(context).pop();
                      }
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
                                  color: isSelected
                                      ? accent
                                      : CustomColors.light,
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
                                      backgroundColors: theme
                                          .customBackground
                                          .backgroundColor,
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

            if (controller.customDashboards.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Custom dashboards',
                style: CustomTheme(context).themeData.textTheme.titleSmall
                    ?.copyWith(color: CustomColors.light),
              ),
              const SizedBox(height: 8),
              ...List.generate(controller.customDashboards.length, (index) {
                final custom = controller.customDashboards[index];
                final isSelected =
                    selectedDashboardType == 'custom' &&
                    index == selectedDashboardIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 18,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.setSelectedThemeIndex = -1;
                            selectTheme.preferredTheme = custom.theme;
                            setState(() {
                              if (selectedDashboardType != 'custom' ||
                                  selectedDashboardIndex != index) {
                                selectedDashboardIndex = index;
                                selectedDashboardType = 'custom';
                              }
                            });
                            widget.onCustomDashboardSelected(custom);
                            widget.onCustomDashboardEditor?.call(custom.name);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            custom.name,
                            style: CustomTheme(context)
                                .themeData
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: isSelected
                                      ? accent
                                      : CustomColors.light,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          widget.onCustomDashboardEditor?.call(custom.name);
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: CustomColors.light.withValues(alpha: .8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () async {
                          final wasActive =
                              controller.activeCustomDashboardName ==
                              custom.name;
                          widget.onDeleteCustomDashboard(custom);
                          await controller.deleteCustomDashboard(custom);
                          setState(() {
                            if (selectedDashboardIndex == index) {
                              selectedDashboardIndex = null;
                            } else if (selectedDashboardIndex != null &&
                                selectedDashboardIndex! > index) {
                              selectedDashboardIndex =
                                  selectedDashboardIndex! - 1;
                            }
                          });
                          if (wasActive) {
                            controller.setSelectedThemeIndex = 0;
                            widget.onThemeChange(0);
                            widget.onPresetDashboard(
                              PresetList.buildFromPreset(PresetList.presets[0]),
                            );
                            selectTheme.preferredTheme =
                                PresetList.presets[0].theme;
                          }
                        },
                        child: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: CustomColors.error.withValues(alpha: .8),
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
                                    backgroundColors: custom
                                        .theme
                                        .customBackground
                                        .backgroundColor,
                                    elementColors: custom
                                        .theme
                                        .customBackground
                                        .elementColors,
                                    elementOpacity: 0.42,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
