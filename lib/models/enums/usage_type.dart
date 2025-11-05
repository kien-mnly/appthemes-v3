import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';

enum UsageType { techSavvy, financial, environmentalist, doomsday }

// get title based on usage type
String getUsageTypeTitle(UsageType usageType) {
  switch (usageType) {
    case UsageType.techSavvy:
      return 'Tech-savvy';
    case UsageType.financial:
      return 'Financieelbewust';
    case UsageType.environmentalist:
      return 'Milieu-bewust';
    case UsageType.doomsday:
      return 'Doomsday';
  }
}

// get description based on usage type
String getUsageTypeDescription(UsageType usageType) {
  switch (usageType) {
    case UsageType.techSavvy:
      return 'Slimme energiebeheer';
    case UsageType.financial:
      return 'Voordelige stroomopslag';
    case UsageType.environmentalist:
      return 'Groene energieoplossing';
    case UsageType.doomsday:
      return 'Backup stroomvoorziening';
  }
}

// get icon based on usage type
String getUsageTypeIcon(UsageType usageType) {
  switch (usageType) {
    case UsageType.techSavvy:
      return AssetIcons.house;
    case UsageType.financial:
      return AssetIcons.coins;
    case UsageType.environmentalist:
      return AssetIcons.plant;
    case UsageType.doomsday:
      return AssetIcons.eyeSlash;
  }
}

BackgroundTheme backgroundForUsageType(UsageType usageType) {
  switch (usageType) {
    case UsageType.techSavvy:
      return BackgroundTheme.mutedGreen;
    case UsageType.financial:
      return BackgroundTheme.mutedTurquoise;
    case UsageType.environmentalist:
      return BackgroundTheme.green;
    case UsageType.doomsday:
      return BackgroundTheme.turquoise;
  }
}
