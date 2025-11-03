import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:appthemes_v3/widgets/charts/custom_line_chart.dart';

class EnergyUsage extends StatelessWidget {
  const EnergyUsage({super.key, required this.size});

  final WidgetSize size;

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case WidgetSize.compact:
        return _buildCompact(context);
      case WidgetSize.regular:
        return _buildRegular(context);
      case WidgetSize.large:
        return _buildLarge(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCompact(BuildContext context) => Row(
    children: [
      const SizedBox(width: 8),
      const Icon(
        Icons.battery_charging_full_rounded,
        color: CustomColors.green300,
        size: 16,
      ),
      const SizedBox(width: 8),
      Text('Snel laden'),
    ],
  );

  Widget _buildRegular(BuildContext context) {
    return Expanded(
      child: CustomLineChart(
        data: EnergyUsageMock.data
            .map(
              (e) => CustomLineChartDataPoint(
                spot: FlSpot(
                  e.timestamp.millisecondsSinceEpoch.toDouble(),
                  e.value,
                ),
                tooltip: EnergyUsageMock.format(e.timestamp),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLarge(BuildContext context) {
    return Expanded(
      child: CustomLineChart(
        data: EnergyUsageMock.data
            .map(
              (e) => CustomLineChartDataPoint(
                spot: FlSpot(
                  e.timestamp.millisecondsSinceEpoch.toDouble(),
                  e.value,
                ),
                tooltip: EnergyUsageMock.format(e.timestamp),
              ),
            )
            .toList(),
      ),
    );
  }
}

// Mock data for energy usage chart
class EnergyUsageSample {
  final DateTime timestamp;
  final double value;
  const EnergyUsageSample({required this.timestamp, required this.value});
}

class EnergyUsageMock {
  static final List<EnergyUsageSample> data = List.generate(12, (i) {
    final now = DateTime.now();
    final ts = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    ).subtract(Duration(hours: 11 - i));
    final value = 60 + ((i * 9) % 35).toDouble();
    return EnergyUsageSample(timestamp: ts, value: value);
  });

  static String format(DateTime dt) {
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}
