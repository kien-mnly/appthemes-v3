import 'package:flutter/widgets.dart';

const double singleRowHeight = 80.0;
const double gap = 12.0;
const double doubleRowHeight = singleRowHeight * 2 + gap;

// const double singleColumnWidth = doubleRowHeight;
// const double doubleColumnWidth = doubleRowHeight * 2 + gap;

double doubleColumnWidth(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

double singleColumnWidth(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width / 2 - gap * 2.35;
}

const EdgeInsets widgetPadding = EdgeInsets.symmetric(
  horizontal: 16,
  vertical: 12,
);
