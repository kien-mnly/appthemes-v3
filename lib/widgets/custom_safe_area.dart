import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    super.key,
    required this.child,
    this.minBottomPadding = 15,
    this.minTopPadding = 0,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });

  final Widget child;
  final double minBottomPadding;
  final double minTopPadding;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: minBottomPadding, top: minTopPadding),
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}
