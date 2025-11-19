import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/widgets/custom_card.dart';

class Smartmode extends StatelessWidget {
  const Smartmode({super.key, required this.size});

  final WidgetSize size;

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case WidgetSize.regular:
        return _buildRegular(context);
      case WidgetSize.long:
        return _buildLong(context);
      case WidgetSize.large:
        return _buildLarge(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRegular(BuildContext context) {
    final cards = [
      {'icon': Icons.battery_charging_full_rounded, 'text': 'Snel laden'},
      {'icon': Icons.bolt_rounded, 'text': 'Dynamisch'},
    ];

    return Column(
      children: [
        // const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((data) {
            return GestureDetector(
              onTap: () {
                // TO DO
                // Set state for selected option
              },
              child: CustomCard(
                width: (WidgetSize.large.width(context) / 2) - 24,
                height: WidgetSize.large.height / 4,
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      data['icon'] as IconData,
                      color: CustomColors.green300,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(data['text'] as String),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLong(BuildContext context) => Row(
    children: [
      const SizedBox(width: 16),
      const Icon(
        Icons.battery_charging_full_rounded,
        color: CustomColors.green300,
        size: 16,
      ),
      const SizedBox(width: 8),
      Text('Snel laden'),
    ],
  );

  Widget _buildLarge(BuildContext context) {
    final cards = [
      {'icon': Icons.battery_charging_full_rounded, 'text': 'Snel laden'},
      {'icon': Icons.bolt_rounded, 'text': 'Dynamisch'},
      {'icon': Icons.cloud_rounded, 'text': 'Max. Uitvoer'},
      {'icon': Icons.ev_station_rounded, 'text': 'Aangepast'},
    ];

    return Column(
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((data) {
            return GestureDetector(
              child: CustomCard(
                width: (WidgetSize.large.width(context) / 2.5),
                height: WidgetSize.large.height / 4,
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      data['icon'] as IconData,
                      color: CustomColors.green300,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(data['text'] as String),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
