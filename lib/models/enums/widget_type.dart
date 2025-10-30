import 'package:flutter/material.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/widget_card.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';

enum WidgetType {
  batteryBundle,
  smartMode,
  energyUsage,
  environmental,
  savings,
  health,
  duration,
  balance,
}

extension WidgetTypeData on WidgetType {
  WidgetItem get widgetItem {
    switch (this) {
      case WidgetType.batteryBundle:
        return WidgetItem(
          id: 'ZinVolt Batterij',
          nameKey: 'ZinVolt Batterij',
          svgAsset: AssetIcons.zinVoltLogo,
          type: this,
          cards: const [],
          supportedSizes: [WidgetSize.regular, WidgetSize.large],
          bundle: null,
        );
      case WidgetType.smartMode:
        return WidgetItem(
          id: 'Slimme Modus',
          nameKey: 'Slimme Modus',
          svgAsset: AssetIcons.smartMode,
          type: this,
          cards: const [],
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.energyUsage:
        return WidgetItem(
          id: 'Energieverbruik',
          nameKey: 'Energieverbruik',
          svgAsset: AssetIcons.lineChart,
          type: this,
          cards: const [],
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.large,
          ],
        );
      case WidgetType.environmental:
        return WidgetItem(
          id: 'Milieu-impact',
          nameKey: 'Milieu-impact',
          svgAsset: AssetIcons.plant,
          type: this,
          cards: const [],
          supportedSizes: [
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.savings:
        return WidgetItem(
          id: 'Spaarmeter',
          nameKey: 'Spaarmeter',
          svgAsset: AssetIcons.coins,
          type: this,
          cards: const [],
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.health:
        return WidgetItem(
          id: 'Batterijgezondheid',
          nameKey: 'Batterijgezondheid',
          svgAsset: AssetIcons.batteryHealth,
          type: this,
          cards: const [],
          supportedSizes: [WidgetSize.compact],
        );
      case WidgetType.duration:
        return WidgetItem(
          id: 'Batterijduur',
          nameKey: 'Batterijduur',
          svgAsset: AssetIcons.batteryFull,
          type: this,
          cards: const [],
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.balance:
        return WidgetItem(
          id: 'Energiebalans',
          nameKey: 'Energiebalans',
          svgAsset: AssetIcons.barChart,
          type: this,
          cards: const [],
          supportedSizes: [WidgetSize.regular, WidgetSize.large],
        );
    }
  }
}
