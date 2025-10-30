import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/widgets/bundles/widget_bundle.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';

class BatteryBundleExtraLargePreview extends StatelessWidget {
  const BatteryBundleExtraLargePreview({
    super.key,
    required this.item,
    required this.size,
    this.gutter = 12.0,
  });

  final WidgetItem item;
  final WidgetSize size;
  final double gutter;

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    final topLargeH = WidgetSize.large.height;
    final bottomCompactH = WidgetSize.compact.height;
    final halfW = (width - gutter) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          SizedBox(
            height: topLargeH,
            width: width,
            child: WidgetBundle(item: item, width: width, height: topLargeH),
          ),
          SizedBox(height: gutter),
          SizedBox(
            height: bottomCompactH,
            width: width,
            child: Row(
              children: [
                SizedBox(
                  width: halfW,
                  child: WidgetBundle(
                    item: item,
                    width: halfW,
                    height: bottomCompactH,
                  ),
                ),
                SizedBox(width: gutter),
                SizedBox(
                  width: halfW,
                  child: WidgetBundle(
                    item: item,
                    width: halfW,
                    height: bottomCompactH,
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
