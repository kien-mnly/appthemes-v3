import 'dart:io';

import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

enum AnimationDirection { forward, backward }

class AnimatedFlowBar extends StatefulWidget with WatchItStatefulWidgetMixin {
  final AnimationDirection direction;
  final Axis axis;

  const AnimatedFlowBar({
    super.key,
    this.direction = AnimationDirection.forward,
    this.axis = Axis.vertical,
  });

  @override
  State<AnimatedFlowBar> createState() => _AnimatedFlowBarState();
}

class _AnimatedFlowBarState extends State<AnimatedFlowBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  static const double barLength = 10;
  static const double barThickness = 3;
  static const double dotSize = 6;

  bool isTesting = Platform.environment.containsKey('FLUTTER_TEST');

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (!isTesting) {
      _controller.repeat();
    }

    _initAnimation();
  }

  void _initAnimation() {
    _positionAnimation = Tween<double>(
      begin: widget.direction == AnimationDirection.forward ? 0.0 : 1.0,
      end: widget.direction == AnimationDirection.forward ? 1.0 : 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void didUpdateWidget(covariant AnimatedFlowBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.direction != widget.direction ||
        oldWidget.axis != widget.axis) {
      _initAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.axis == Axis.vertical
        ? Size(dotSize, barLength)
        : Size(barLength, dotSize);
    final accent = watch(
      locator<BackgroundService>(),
    ).currentBackgroundTheme.accentColor;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The bar
          Align(
            alignment: Alignment.center,
            child: Container(
              height: widget.axis == Axis.vertical ? barLength : barThickness,
              width: widget.axis == Axis.vertical ? barThickness : barLength,
              color: accent,
            ),
          ),
          // The animated dot
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              double offset =
                  -dotSize +
                  _positionAnimation.value *
                      (barLength +
                          dotSize); // add the size of the dot to the offset for better visual flow

              return Positioned(
                bottom: widget.axis == Axis.vertical ? offset : null,
                left: widget.axis == Axis.horizontal ? offset : null,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
