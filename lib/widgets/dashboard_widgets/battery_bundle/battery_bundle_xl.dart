import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/widget_bundle.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/battery_bundle_content.dart';
import 'package:appthemes_v3/widgets/animated_flow_bar.dart';

class BatteryBundleExtraLarge extends StatelessWidget {
  const BatteryBundleExtraLarge({
    super.key,
    required this.item,
    required this.size,
    this.gap = 12.0,
  });

  final WidgetContent item;
  final WidgetSize size;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    final largeWidgetHeight = WidgetSize.large.height;
    final compactWidgetHeight = WidgetSize.compact.height;
    final halfW = (width - gap) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          SizedBox(
            height: largeWidgetHeight,
            width: width,
            child: WidgetBundle(
              item: item,
              width: width,
              height: largeWidgetHeight,
              child: BatteryMainContent(),
            ),
          ),
          SizedBox(
            width: halfW,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: gap,
                child: AnimatedFlowBar(
                  direction: AnimationDirection.backward,
                  axis: Axis.vertical,
                ),
              ),
            ),
          ),
          SizedBox(
            height: compactWidgetHeight,
            width: width,
            child: Row(
              children: [
                WidgetBundle(
                  item: item,
                  width: halfW,
                  height: compactWidgetHeight,
                  headerTitle: 'Netwerk',
                  headerIcon: SvgPicture.asset(
                    AssetIcons.plug,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      CustomColors.light,
                      BlendMode.srcIn,
                    ),
                  ),
                  child: SizedBox(height: 24, child: NetworkCompactContent()),
                ),
                SizedBox(
                  width: gap,
                  child: AnimatedFlowBar(
                    direction: AnimationDirection.forward,
                    axis: Axis.horizontal,
                  ),
                ),
                WidgetBundle(
                  item: item,
                  width: halfW,
                  height: compactWidgetHeight,
                  headerTitle: 'Thuis',
                  headerIcon: SvgPicture.asset(
                    AssetIcons.house,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      CustomColors.light,
                      BlendMode.srcIn,
                    ),
                  ),
                  child: SizedBox(height: 24, child: HomeCompactContent()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
