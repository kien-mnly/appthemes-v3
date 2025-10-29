import 'package:flutter/material.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/widget_card.dart';
import 'package:appthemes_v3/models/widget_type.dart';

enum PickerType {
  batteryBundle,
  smartMode,
  energyUsage,
  environmental,
  savings,
  health,
  duration,
  balance,
}

extension PickerTypeExtension on PickerType {
  String get key {
    switch (this) {
      case PickerType.batteryBundle:
        return 'widget_picker.battery_bundle';
      case PickerType.smartMode:
        return 'widget_picker.smart_mode';
      case PickerType.energyUsage:
        return 'widget_picker.energy_usage';
      case PickerType.environmental:
        return 'widget_picker.environmental_impact';
      case PickerType.savings:
        return 'widget_picker.savings_meter';
      case PickerType.health:
        return 'widget_picker.battery_health';
      case PickerType.duration:
        return 'widget_picker.battery_duration';
      case PickerType.balance:
        return 'widget_picker.energy_balance';
    }
  }
}

extension PickerTypeData on PickerType {
  String get nameKey {
    switch (this) {
      case PickerType.batteryBundle:
        return 'ZinVolt Batterij';
      case PickerType.smartMode:
        return 'Slimme Modus';
      case PickerType.energyUsage:
        return 'Energieverbruik';
      case PickerType.environmental:
        return 'Milieu-impact';
      case PickerType.savings:
        return 'Spaarmeter';
      case PickerType.health:
        return 'Batterijgezondheid';
      case PickerType.duration:
        return 'Batterijduur';
      case PickerType.balance:
        return 'Energiebalans';
    }
  }

  String get svgAsset {
    switch (this) {
      case PickerType.batteryBundle:
        return AssetIcons.zinVoltLogo;
      case PickerType.smartMode:
        return AssetIcons.smartMode;
      case PickerType.energyUsage:
        return AssetIcons.lineChart;
      case PickerType.environmental:
        return AssetIcons.plant;
      case PickerType.savings:
        return AssetIcons.coins;
      case PickerType.health:
        return AssetIcons.batteryHealth;
      case PickerType.duration:
        return AssetIcons.batteryFull;
      case PickerType.balance:
        return AssetIcons.barChart;
    }
  }

  String? get subtitle {
    return null;
  }

  List<WidgetCard> get defaultCards {
    switch (this) {
      case PickerType.batteryBundle:
        return [];
      case PickerType.smartMode:
        return [];
      case PickerType.energyUsage:
        return [];
      case PickerType.environmental:
        return [];
      case PickerType.savings:
        return [];
      case PickerType.health:
        return [];
      case PickerType.duration:
        return [];
      case PickerType.balance:
        return [];
    }
  }

  PickerItem toPickerItem() {
    return PickerItem(
      id: nameKey,
      nameKey: nameKey,
      svgAsset: svgAsset,
      type: this,
      subtitle: subtitle,
      cards: defaultCards,
    );
  }
}
