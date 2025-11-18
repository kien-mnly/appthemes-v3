import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/widget_content.dart';
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
  WidgetContent get widgetItem {
    switch (this) {
      case WidgetType.batteryBundle:
        return WidgetContent(
          id: 'Batterij',
          svgAsset: AssetIcons.zinVoltLogo,
          type: this,
          supportedSizes: [WidgetSize.large, WidgetSize.extraLarge],
        );
      case WidgetType.smartMode:
        return WidgetContent(
          id: 'Slimme Modus',
          svgAsset: AssetIcons.smartMode,
          type: this,
          supportedSizes: [
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.energyUsage:
        return WidgetContent(
          id: 'Energieverbruik',
          svgAsset: AssetIcons.lineChart,
          type: this,
          supportedSizes: [
            WidgetSize.long,
            WidgetSize.regular,
            WidgetSize.large,
          ],
        );
      case WidgetType.environmental:
        return WidgetContent(
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
        return WidgetContent(
          id: 'Spaarmeter',
          svgAsset: AssetIcons.coins,
          type: this,
          supportedSizes: [
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.health:
        return WidgetContent(
          id: 'Batterijgezondheid',
          svgAsset: AssetIcons.batteryHealth,
          type: this,
          supportedSizes: [WidgetSize.compact],
        );
      case WidgetType.duration:
        return WidgetContent(
          id: 'Batterijduur',
          svgAsset: AssetIcons.batteryFull,
          type: this,
          supportedSizes: [
            WidgetSize.regular,
            WidgetSize.long,
            WidgetSize.large,
          ],
        );
      case WidgetType.energyBalance:
        return WidgetContent(
          id: 'Energiebalans',
          svgAsset: AssetIcons.barChart,
          type: this,
          supportedSizes: [WidgetSize.regular, WidgetSize.large],
        );
    }
  }
}
