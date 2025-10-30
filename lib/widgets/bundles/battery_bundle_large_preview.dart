import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/widgets/bundles/widget_bundle.dart';

class BatteryBundleLargePreview extends StatelessWidget {
  const BatteryBundleLargePreview({
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

    final leftW = (width - gutter) / 2;
    final rightW = (width - gutter) / 2;
    final compactH = (height - gutter) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          // Left: main regular-sized card area
          SizedBox(
            width: leftW,
            child: WidgetBundle(item: item, width: leftW, height: height),
          ),
          SizedBox(width: gutter),
          // Right: two compact cards stacked
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
                  ),
                ),
                SizedBox(height: gutter),
                SizedBox(
                  height: compactH,
                  child: WidgetBundle(
                    item: item,
                    width: rightW,
                    height: compactH,
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
