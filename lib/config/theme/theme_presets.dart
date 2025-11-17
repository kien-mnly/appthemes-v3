import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/dashboard_config.dart';
import 'package:appthemes_v3/models/enums/usage_type.dart';

class PresetWidgetConfig {
  final WidgetType type;
  final WidgetSize size;
  const PresetWidgetConfig(this.type, this.size);
}

class ThemePreset {
  final UsageType usageType;
  String get name => getUsageTypeTitle(usageType);

  final BackgroundTheme theme;
  final List<PresetWidgetConfig> widgets;

  const ThemePreset({
    required this.usageType,
    required this.theme,
    required this.widgets,
  });
}

class PresetList {
  static const List<ThemePreset> presets = [
    ThemePreset(
      usageType: UsageType.environmentalist,
      theme: BackgroundTheme.green,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.extraLarge),
        PresetWidgetConfig(WidgetType.environmental, WidgetSize.large),
        PresetWidgetConfig(WidgetType.energyUsage, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.energyBalance, WidgetSize.regular),
      ],
    ),
    ThemePreset(
      usageType: UsageType.techSavvy,
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
      usageType: UsageType.doomsday,
      theme: BackgroundTheme.turquoise,
      widgets: [
        PresetWidgetConfig(WidgetType.batteryBundle, WidgetSize.extraLarge),
        PresetWidgetConfig(WidgetType.duration, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.energyUsage, WidgetSize.regular),
        PresetWidgetConfig(WidgetType.savings, WidgetSize.large),
      ],
    ),
    ThemePreset(
      usageType: UsageType.financial,
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
    final dashboard = preset.widgets.map((widget) {
      return DashboardConfig(
        itemId: widget.type.widgetItem.id,
        size: widget.size,
        selectedIndex: widget.type.widgetItem.supportedSizes.indexOf(
          widget.size,
        ),
      );
    }).toList();
    DashboardStorage().save(dashboard);
    return dashboard;
  }
}
