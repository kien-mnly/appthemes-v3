import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_painter.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/models/custom_dashboard.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:appthemes_v3/models/theme_presets.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/services/background_service.dart';
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
    this.onCustomDashboardNameSelected,
  });

  final int selectedThemeIndex;
  final ValueChanged<int> onThemeChange;
  final ValueChanged<List<DashboardWidget>> onPresetDashboard;
  final List<CustomDashboard> customDashboards;
  final ValueChanged<List<DashboardWidget>> onCustomDashboardSelected;
  final ValueChanged<CustomDashboard> onDeleteCustomDashboard;
  final String? activeCustomDashboardName;
  final ValueChanged<String>? onCustomDashboardNameSelected;

  @override
  State<ThemeModal> createState() => _ThemeModalState();
}

class _ThemeModalState extends State<ThemeModal> {
  late int currentPresetIndex;
  late List<CustomDashboard> _customDashboards;
  int? _selectedCustomDashboardIndex;
  late final BackgroundService selectTheme = locator<BackgroundService>();

  @override
  void initState() {
    super.initState();
    currentPresetIndex = widget.selectedThemeIndex;
    _customDashboards = List<CustomDashboard>.from(widget.customDashboards);

    // If an active custom dashboard name is provided, prefer selecting that
    if (widget.activeCustomDashboardName != null) {
      final index = _customDashboards.indexWhere(
        (d) => d.name == widget.activeCustomDashboardName,
      );
      if (index != -1) {
        _selectedCustomDashboardIndex = index;
        currentPresetIndex = -1;
      }
    }
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
              final isSelected = index == currentPresetIndex;
              final themeLabel = preset.name;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentPresetIndex != index) {
                        setState(() {
                          currentPresetIndex = index;
                          // Clear any selected custom dashboard when a preset is chosen
                          _selectedCustomDashboardIndex = null;
                        });
                        final selectedPreset = presetList[index];
                        // Pass index for theme selection
                        widget.onThemeChange(index);

                        // Build dashboard from preset
                        widget.onPresetDashboard(
                          PresetList.buildFromPreset(selectedPreset),
                        );
                        Navigator.of(context).pop();
                      }
                      selectTheme.preferredTheme =
                          presetList[currentPresetIndex].theme;
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

            if (_customDashboards.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Custom dashboards',
                style: CustomTheme(context).themeData.textTheme.titleSmall
                    ?.copyWith(color: CustomColors.light),
              ),
              const SizedBox(height: 8),
              ...List.generate(_customDashboards.length, (index) {
                final custom = _customDashboards[index];
                final isSelected = index == _selectedCustomDashboardIndex;
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
                            setState(() {
                              _selectedCustomDashboardIndex = index;
                              // Clear any preset selection when a custom dashboard is chosen
                              currentPresetIndex = -1;
                            });
                            widget.onCustomDashboardSelected(custom.content);
                            widget.onCustomDashboardNameSelected?.call(
                              custom.name,
                            );
                            selectTheme.preferredTheme = custom.theme;
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
                          widget.onCustomDashboardNameSelected?.call(
                            custom.name,
                          );
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: CustomColors.light.withValues(alpha: .8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          // First notify parent so it can update storage
                          widget.onDeleteCustomDashboard(custom);

                          setState(() {
                            _customDashboards.removeAt(index);
                            if (_selectedCustomDashboardIndex == index) {
                              _selectedCustomDashboardIndex = null;
                            } else if (_selectedCustomDashboardIndex != null &&
                                _selectedCustomDashboardIndex! > index) {
                              _selectedCustomDashboardIndex =
                                  _selectedCustomDashboardIndex! - 1;
                            }
                          });
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
