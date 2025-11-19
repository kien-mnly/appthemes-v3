import 'package:flutter/material.dart';

import '../../config/constants/widget_constants.dart';

enum WidgetSize { compact, regular, long, large, extraLarge }

extension WidgetSizeExtension on WidgetSize {
  double width(BuildContext context) {
    switch (this) {
      case WidgetSize.compact:
        return singleColumnWidth(context);
      case WidgetSize.regular:
        return singleColumnWidth(context);
      case WidgetSize.long:
        return doubleColumnWidth(context);
      case WidgetSize.large:
        return doubleColumnWidth(context);
      case WidgetSize.extraLarge:
        return doubleColumnWidth(context);
    }
  }

  double get height {
    switch (this) {
      case WidgetSize.compact:
        return singleRowHeight;
      case WidgetSize.regular:
        return doubleRowHeight;
      case WidgetSize.long:
        return singleRowHeight;
      case WidgetSize.large:
        return doubleRowHeight;
      case WidgetSize.extraLarge:
        return doubleRowHeight + singleRowHeight + gap;
    }
  }
}
