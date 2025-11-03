import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomLineChartDataPoint {
  final FlSpot spot;
  final String? tooltip;

  CustomLineChartDataPoint({required this.spot, this.tooltip});
}

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({
    super.key,
    required this.data,
    this.unit = 'W',
    this.trailingText,
    this.minY,
    this.maxY,
    this.decimals = 0,
    this.dotData = const FlDotData(show: true),
    this.isCurved = true,
    this.smoothness = 0.5,
    this.barWidth = 2,
    this.isStepLineChart = false,
    this.drawZeroLine = false,
  });

  final List<CustomLineChartDataPoint> data;
  final String unit;
  final String? trailingText;
  final double? minY;
  final double? maxY;
  final int decimals;
  final FlDotData dotData;
  final bool isCurved;
  final double smoothness;
  final double barWidth;
  final bool isStepLineChart;
  final bool drawZeroLine;

  @override
  Widget build(BuildContext context) {
    int? lastTouchedIndex;

    double getMaxY() {
      return data.map((point) => point.spot.y).reduce((a, b) => a > b ? a : b);
    }

    double getMinY() {
      return data.map((point) => point.spot.y).reduce((a, b) => a < b ? a : b);
    }

    final lineBarsData = [
      LineChartBarData(
        dotData: dotData,
        spots: data.map((point) => point.spot).toList(),
        color: CustomColors.green300,
        barWidth: barWidth,
        isStepLineChart: isStepLineChart,
        isCurved: isCurved,
        curveSmoothness: smoothness,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              CustomColors.green300.withValues(alpha: 0.05),
              CustomColors.green300.withValues(alpha: 0.35),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AssetIcons.chevronDown,
                    colorFilter: ColorFilter.mode(
                      CustomColors.green300,
                      BlendMode.srcIn,
                    ),
                    height: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${getMaxY().toStringAsFixed(decimals)}$unit',
                    style: CustomTheme(context).themeData.textTheme.labelMedium
                        ?.copyWith(
                          color: CustomColors.dark400,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    AssetIcons.chevronDown,
                    colorFilter: ColorFilter.mode(
                      CustomColors.error,
                      BlendMode.srcIn,
                    ),
                    height: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${getMinY().toStringAsFixed(decimals)}$unit',
                    style: CustomTheme(context).themeData.textTheme.labelMedium
                        ?.copyWith(
                          color: CustomColors.dark400,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: LineChart(
            LineChartData(
              baselineX: 0,
              baselineY: 0,
              minY: minY ?? (getMinY() - getMaxY() ~/ 5).toDouble(),
              maxY: (getMaxY() == 0)
                  ? getMinY().abs() * 0.1
                  : (getMaxY() + getMaxY() ~/ 2.5).toDouble(),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(show: false),
              extraLinesData: drawZeroLine
                  ? ExtraLinesData(
                      extraLinesOnTop: false,
                      horizontalLines: [
                        HorizontalLine(
                          y: 0,
                          color: CustomColors.dark400,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                      ],
                    )
                  : null,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  getTooltipColor: (_) => CustomColors.dark850,
                  tooltipBorder: BorderSide(
                    color: CustomColors.dark700,
                    width: 1,
                  ),
                  tooltipBorderRadius: BorderRadius.circular(12),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        (data[spot.spotIndex].tooltip ?? spot.x.toString()),
                        TextStyle(
                          color: CustomColors.dark400,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.left,
                        children: [
                          TextSpan(
                            text: '\n${spot.y.toStringAsFixed(decimals)}',
                            style: TextStyle(
                              color: CustomColors.light200,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: ' $unit',
                                style: TextStyle(
                                  color: CustomColors.light700,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList();
                  },
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
                getTouchedSpotIndicator: (barData, spotIndexes) =>
                    spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(color: CustomColors.green800, strokeWidth: 2),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: CustomColors.light,
                            );
                          },
                        ),
                      );
                    }).toList(),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                      // Store last touched index in a static variable
                      final touchedSpot = response?.lineBarSpots?.firstOrNull;
                      final currentIndex = touchedSpot?.spotIndex;

                      if (event is FlLongPressMoveUpdate ||
                          event is FlPanUpdateEvent) {
                        if (currentIndex != null &&
                            currentIndex != lastTouchedIndex) {
                          // Play haptic feedback when scrubbing onto a new point
                          // HapticFeedback.selectionClick();
                          lastTouchedIndex = currentIndex;
                        }
                      }
                    },
              ),
              lineBarsData: lineBarsData,
            ),
          ),
        ),
      ],
    );
  }
}
