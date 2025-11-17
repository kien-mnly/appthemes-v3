import 'dart:ui';

import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/config/theme/size_setter.dart';
import 'package:appthemes_v3/models/enums/horizontal_screen_padding.dart';
import 'package:appthemes_v3/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:watch_it/watch_it.dart';

class FloatingBottomBarItem {
  const FloatingBottomBarItem({required this.icon, required this.label});

  final String icon;
  final String label;
}

class FloatingBottomBar extends StatefulWidget with WatchItStatefulWidgetMixin {
  const FloatingBottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onItemTapped;
  final List<FloatingBottomBarItem> items;

  double calculateIndicatorPosition(screenSize) {
    final padding = SizeSetter.getHorizontalScreenPadding(
      size: HorizontalScreenPadding.small,
    );
    final itemWidth = (screenSize - padding * 2) / items.length;

    if (selectedIndex == 0) {
      return itemWidth / 2 - padding - 30;
    }
    if (selectedIndex == 1) {
      return itemWidth * 1.5 - padding - 40;
    }
    if (selectedIndex == 2) {
      return itemWidth * 2.5 - padding - 50;
    }

    return 0;
  }

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  @override
  Widget build(BuildContext context) {
    final padding =
        SizeSetter.getHorizontalScreenPadding(
          size: HorizontalScreenPadding.small,
        ) +
        15;
    final itemWidth =
        (MediaQuery.of(context).size.width - padding * 2) / widget.items.length;
    final accent = watch(
      locator<BackgroundService>(),
    ).currentBackgroundTheme.accentColor;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeSetter.getHorizontalScreenPadding(
          size: HorizontalScreenPadding.small,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 75,
            width: double.infinity,
            decoration: ShapeDecoration(
              color: CustomColors.dark.withValues(alpha: 0.35),
              shape: SmoothRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                smoothness: 0.6,
                side: BorderSide(color: CustomColors.dark600, width: 1),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 75),
                  top: 0,
                  left: widget.calculateIndicatorPosition(
                    MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              accent.withValues(alpha: 0),
                              accent,
                              accent,
                              accent.withValues(alpha: 0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.none,
                        height: 60,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          gradient: RadialGradient(
                            colors: [
                              accent.withValues(alpha: 0.20),
                              accent.withValues(alpha: 0),
                            ],
                            center: Alignment.topCenter,
                            radius: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => widget.onItemTapped(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              item.icon,
                              height: 25,
                              colorFilter: ColorFilter.mode(
                                widget.selectedIndex == index
                                    ? accent
                                    : CustomColors.light700,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              item.label,
                              style: CustomTheme(context)
                                  .themeData
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: widget.selectedIndex == index
                                        ? accent
                                        : CustomColors.light700,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
