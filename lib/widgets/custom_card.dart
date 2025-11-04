import 'dart:ui';

import '../config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.background = CustomColors.dark,
    this.borderSide = const BorderSide(color: CustomColors.dark600),
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    this.borderRadius = 25,
    this.shadows = const [],
    this.width,
    this.height,
    this.onTap,
    this.clipBehavior = Clip.none,

    this.useGlassEffect = true,
    this.blurSigma = 10,
    this.splashColor,
    this.highlightColor,
    super.key,
  });

  final Widget child;
  final Color background;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final List<BoxShadow> shadows;
  final double? width;
  final double? height;
  final Function()? onTap;
  final Clip clipBehavior;

  final bool useGlassEffect;
  final double blurSigma;
  final Color? splashColor;
  final Color? highlightColor;

  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    final shape = SmoothRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      smoothness: 0.6,
    );

    Widget content = Material(
      color: useGlassEffect ? Colors.black.withValues(alpha: 0.25) : background,
      shape: shape,
      child: InkWell(
        customBorder: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          smoothness: 0.6,
        ),
        splashColor: splashColor ?? CustomColors.dark800,
        highlightColor: highlightColor ?? CustomColors.dark700,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              smoothness: 0.6,
              side: borderSide,
            ),
          ),
          child: child,
        ),
      ),
    );

    return Container(
      clipBehavior: clipBehavior,
      decoration: ShapeDecoration(shape: shape, shadows: shadows),
      child: useGlassEffect
          ? ClipPath(
              clipper: ShapeBorderClipper(shape: shape),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: content,
              ),
            )
          : content,
    );
  }
}
