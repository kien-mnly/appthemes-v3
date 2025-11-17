import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/models/custom_background.dart';

enum BackgroundTheme { green, mutedGreen, turquoise, mutedTurquoise, error }

extension BackgroundThemeExtension on BackgroundTheme {
  CustomBackground get customBackground {
    switch (this) {
      case BackgroundTheme.green:
        return CustomBackground(
          backgroundColor: CustomColors.turqoise800,
          elementColors: [
            CustomColors.turqoise800,
            CustomColors.turqoise800,
            CustomColors.green300,
          ],
          accentColor: CustomColors.green300,
          backgroundOpacity: 0.35,
        );
      case BackgroundTheme.mutedGreen:
        return CustomBackground(
          backgroundColor: CustomColors.dark800,
          elementColors: [
            CustomColors.dark800,
            CustomColors.dark800,
            CustomColors.green300,
          ],
          accentColor: CustomColors.green300,
          backgroundOpacity: 0.15,
        );
      case BackgroundTheme.turquoise:
        return CustomBackground(
          backgroundColor: CustomColors.turqoise800,
          elementColors: [
            CustomColors.turqoise800,
            CustomColors.turqoise800,
            CustomColors.turqoise500,
          ],
          accentColor: CustomColors.turqoise500,
          backgroundOpacity: 0.35,
        );
      case BackgroundTheme.mutedTurquoise:
        return CustomBackground(
          backgroundColor: CustomColors.dark800,
          elementColors: [
            CustomColors.dark800,
            CustomColors.dark800,
            CustomColors.turqoise500,
          ],
          accentColor: CustomColors.turqoise500,
          backgroundOpacity: 0.15,
        );
      case BackgroundTheme.error:
        return CustomBackground(
          backgroundColor: CustomColors.dark800,
          elementColors: [
            CustomColors.dark800,
            CustomColors.dark800,
            CustomColors.error,
          ],
          accentColor: CustomColors.error,
          backgroundOpacity: 0.15,
        );
    }
  }
}
