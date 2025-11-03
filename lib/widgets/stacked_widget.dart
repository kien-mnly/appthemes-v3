import 'package:flutter/material.dart';
import 'package:appthemes_v3/config/constants/widget_constants.dart';

class StackedWidget extends StatelessWidget {
  final List<Widget> items;

  const StackedWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: singleColumnWidth,
      height: doubleRowHeight,
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            SizedBox(height: singleRowHeight, child: items[i]),
            if (i < items.length - 1) SizedBox(height: gap),
          ],
        ],
      ),
    );
  }
}
