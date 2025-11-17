import 'package:flutter/widgets.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/dashboard_config.dart';

class PresetWidgetConfig {
  final WidgetType type;
  final WidgetSize size;
  const PresetWidgetConfig(this.type, this.size);
}

class ThemePreset {
  final String name;
  final BackgroundTheme theme;
  final List<PresetWidgetConfig> widgets;

  const ThemePreset({
    required this.name,
    required this.theme,
    required this.widgets,
  });
}

class PresetList {
  static const List<ThemePreset> presets = [
    ThemePreset(
      name: 'Milieubewust',
      theme: BackgroundTheme.green,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.extraLarge),
        PresetWidgetConfig(WidgetType.environmental, WidgetSize.large),
        PresetWidgetConfig(WidgetType.energyUsage, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.energyBalance, WidgetSize.regular),
      ],
    ),
    ThemePreset(
      name: 'Tech-savvy',
      theme: BackgroundTheme.mutedGreen,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.large),
        PresetWidgetConfig(WidgetType.smartMode, WidgetSize.large),
        PresetWidgetConfig(WidgetType.savings, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.duration, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.health, WidgetSize.long),
      ],
    ),
    ThemePreset(
      name: 'Off-Grid',
      theme: BackgroundTheme.turquoise,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.extraLarge),
        PresetWidgetConfig(WidgetType.duration, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.energyUsage, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.savings, WidgetSize.large),
      ],
    ),
    ThemePreset(
      name: 'Financieel bewust',
      theme: BackgroundTheme.mutedTurquoise,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.large),
        PresetWidgetConfig(WidgetType.smartMode, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.savings, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.energyBalance, WidgetSize.long),
        PresetWidgetConfig(WidgetType.energyUsage, WidgetSize.large),
      ],
    ),
  ];

  /// Build dashboard configs from a preset instance.
  static List<DashboardConfig> buildFromPreset(ThemePreset preset) {
    return preset.widgets.map((widget) {
      return DashboardConfig(
        id: UniqueKey().toString(),
        itemId: widget.type.widgetItem.id,
        size: widget.size,
        selectedIndex: widget.type.widgetItem.supportedSizes.indexOf(
          widget.size,
        ),
      );
    }).toList();
  }
}
