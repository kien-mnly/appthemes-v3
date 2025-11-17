import 'package:appthemes_v3/widgets/animated_flow_bar.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/widget_bundle.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/battery_bundle_content.dart';

class BatteryBundleLarge extends StatelessWidget {
  const BatteryBundleLarge({
    super.key,
    required this.item,
    required this.size,
    this.gap = 12.0,
  });

  final WidgetItem item;
  final WidgetSize size;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    final leftW = (width - gap) / 2;
    final rightW = (width - gap) / 2;
    final compactH = (height - gap) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          SizedBox(
            width: leftW,
            child: WidgetBundle(
              item: item,
              width: leftW,
              height: height,
              showChevron: false,
              child: BatteryMainContent(),
            ),
          ),
          SizedBox(
            width: gap,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: compactH,
                child: AnimatedFlowBar(
                  direction: AnimationDirection.forward,
                  axis: Axis.horizontal,
                ),
              ),
            ),
          ),
          // Right: two compact cards stacked (Netwerk, Thuis)
          SizedBox(
            width: rightW,
            child: Column(
              children: [
                SizedBox(
                  height: compactH,
                  child: WidgetBundle(
                    item: item,
                    width: rightW,
                    height: compactH,
                    headerTitle: 'Netwerk',
                    headerIcon: batteryHeaderIcon(AssetIcons.plug, size: 18),
                    child: SizedBox(height: 24, child: NetworkCompactContent()),
                  ),
                ),
                SizedBox(
                  height: gap,
                  child: AnimatedFlowBar(
                    direction: AnimationDirection.backward,
                    axis: Axis.vertical,
                  ),
                ),
                SizedBox(
                  height: compactH,
                  child: WidgetBundle(
                    item: item,
                    width: rightW,
                    height: compactH,
                    headerTitle: 'Thuis',
                    headerIcon: batteryHeaderIcon(AssetIcons.house, size: 18),
                    child: SizedBox(height: 24, child: HomeCompactContent()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
