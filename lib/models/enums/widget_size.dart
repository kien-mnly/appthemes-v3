import '../../config/constants/widget_constants.dart';

enum WidgetSize { compact, regular, long, large, extraLarge }

extension WidgetSizeExtension on WidgetSize {
  double get width {
    switch (this) {
      case WidgetSize.compact:
        return singleColumnWidth;
      case WidgetSize.regular:
        return singleColumnWidth;
      case WidgetSize.long:
        return doubleColumnWidth;
      case WidgetSize.large:
        return doubleColumnWidth;
      case WidgetSize.extraLarge:
        return doubleColumnWidth;
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
