import 'package:appthemes_v3/widgets/animated_flow_bar.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/widget_bundle.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/battery_bundle_content.dart';

class BatteryBundleLarge extends StatelessWidget {
  const BatteryBundleLarge({super.key, required this.item, this.gap = 12.0});

  final WidgetContent item;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final width = WidgetSize.large.width(context);
    final height = WidgetSize.large.height;

    final compactW = width / 2 - gap * 2.35;
    final compactH = (WidgetSize.large.height - gap) / 2;
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          SizedBox(
            width: compactW,
            child: WidgetBundle(
              item: item,
              width: compactW,
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
            width: compactW,
            child: Column(
              children: [
                SizedBox(
                  height: compactH,
                  child: WidgetBundle(
                    item: item,
                    width: compactW,
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
                    width: compactW,
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
