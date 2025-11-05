import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/models/custom_background.dart';

enum BackgroundTheme { green, mutedGreen, turquoise, mutedTurquoise, error }

extension BackgroundThemeExtension on BackgroundTheme {
  CustomBackground get customBackground {
    switch (this) {
      case BackgroundTheme.green:
        return CustomBackground(
          id: 'bg0',
          name: 'Green',
          backgroundColors: [
            CustomColors.turqoise800.withValues(alpha: 0.75),
            CustomColors.turqoise800,
          ],
          background: CustomColors.green800,
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
          id: 'bg1',
          name: 'Dark-Green',
          backgroundColors: [
            CustomColors.dark800,
            CustomColors.dark800.withValues(alpha: 0.75),
          ],
          background: CustomColors.black,
          //requires 3 colors for better gradient effect
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
          id: 'bg2',
          name: 'Turqoise',
          backgroundColors: [
            CustomColors.turqoise800.withValues(alpha: 0.75),
            CustomColors.turqoise800,
          ],
          background: CustomColors.green800,
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
          id: 'bg3',
          name: 'Muted Turqoise',
          backgroundColors: [
            CustomColors.dark800.withValues(alpha: 0.75),
            CustomColors.dark800,
          ],
          background: CustomColors.black,
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
          id: 'bg4',
          name: 'Error',
          backgroundColors: [
            CustomColors.dark800,
            CustomColors.dark800.withValues(alpha: 0.75),
          ],
          background: CustomColors.black,
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
