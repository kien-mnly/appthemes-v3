import 'package:appthemes_v3/config/theme/asset_icons.dart';
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
  energyBalance,
}

extension WidgetTypeData on WidgetType {
  WidgetItem get widgetItem {
    switch (this) {
      case WidgetType.batteryBundle:
        return WidgetItem(
          id: 'Batterij',
          svgAsset: AssetIcons.zinVoltLogo,
          type: this,
          supportedSizes: [WidgetSize.large, WidgetSize.extraLarge],
        );
      case WidgetType.smartMode:
        return WidgetItem(
          id: 'Slimme Modus',
          svgAsset: AssetIcons.smartMode,
          type: this,
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
          svgAsset: AssetIcons.lineChart,
          type: this,
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.large,
          ],
        );
      case WidgetType.environmental:
        return WidgetItem(
          id: 'Milieu-impact',
          svgAsset: AssetIcons.plant,
          type: this,
          supportedSizes: [
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.savings:
        return WidgetItem(
          id: 'Spaarmeter',
          svgAsset: AssetIcons.coins,
          type: this,
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
          svgAsset: AssetIcons.batteryHealth,
          type: this,
          supportedSizes: [WidgetSize.compact],
        );
      case WidgetType.duration:
        return WidgetItem(
          id: 'Batterijduur',
          svgAsset: AssetIcons.batteryFull,
          type: this,
          supportedSizes: [
            WidgetSize.compact,
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.energyBalance:
        return WidgetItem(
          id: 'Energiebalans',
          svgAsset: AssetIcons.barChart,
          type: this,
          supportedSizes: [WidgetSize.regular, WidgetSize.large],
        );
    }
  }
}
