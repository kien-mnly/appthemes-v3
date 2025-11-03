import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';

Widget batteryHeaderIcon(String asset, {double size = 18}) => SvgPicture.asset(
  asset,
  width: size,
  height: size,
  colorFilter: const ColorFilter.mode(CustomColors.light, BlendMode.srcIn),
);

// Central config you can edit in one place
class BatteryContentConfig {
  final String mainInputValue;
  final String mainInputLabel;
  final String mainChargingValue;
  final String mainChargingLabel;
  final String networkValue;
  final String networkLabel;
  final String homeValue;
  final String homeLabel;

  const BatteryContentConfig({
    required this.mainInputValue,
    required this.mainInputLabel,
    required this.mainChargingValue,
    required this.mainChargingLabel,
    required this.networkValue,
    required this.networkLabel,
    required this.homeValue,
    required this.homeLabel,
  });
}

const batteryContent = BatteryContentConfig(
  mainInputValue: '800 W',
  mainInputLabel: 'Invoer',
  mainChargingValue: '24 %',
  mainChargingLabel: 'Opgeladen',
  networkValue: '87 W',
  networkLabel: 'Terugleveren',
  homeValue: '937 W',
  homeLabel: 'Gebruik',
);

class NetworkCompactContent extends StatelessWidget {
  const NetworkCompactContent({super.key, this.config});
  final BatteryContentConfig? config;

  @override
  Widget build(BuildContext context) {
    final content = config ?? batteryContent;
    return CompactContent(
      value: content.networkValue,
      label: content.networkLabel,
    );
  }
}

class HomeCompactContent extends StatelessWidget {
  const HomeCompactContent({super.key, this.config});
  final BatteryContentConfig? config;

  @override
  Widget build(BuildContext context) {
    final content = config ?? batteryContent;
    return CompactContent(value: content.homeValue, label: content.homeLabel);
  }
}

class CompactContent extends StatelessWidget {
  const CompactContent({super.key, required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          value,
          style: textTheme.labelLarge?.copyWith(color: CustomColors.light),
        ),
        const SizedBox(width: 4),
        Text(
          '•',
          style: textTheme.labelLarge?.copyWith(color: CustomColors.light500),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: CustomColors.light500),
        ),
      ],
    );
  }
}

class BatteryMainContent extends StatelessWidget {
  const BatteryMainContent({super.key, this.config});
  final BatteryContentConfig? config;

  @override
  Widget build(BuildContext context) {
    final content = config ?? batteryContent;
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              content.mainInputValue,
              style: theme.labelLarge?.copyWith(color: CustomColors.light),
            ),
            const SizedBox(width: 4),
            Text(
              '•',
              style: theme.bodyMedium?.copyWith(color: CustomColors.light500),
            ),
            const SizedBox(width: 4),
            Text(
              content.mainInputLabel,
              style: theme.bodyMedium?.copyWith(color: CustomColors.light500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              content.mainChargingValue,
              style: theme.labelLarge?.copyWith(color: CustomColors.light),
            ),
            const SizedBox(width: 4),
            Text(
              '•',
              style: theme.bodyMedium?.copyWith(color: CustomColors.light500),
            ),
            const SizedBox(width: 4),
            Text(
              content.mainChargingLabel,
              style: theme.bodyMedium?.copyWith(color: CustomColors.light500),
            ),
          ],
        ),
      ],
    );
  }
}
