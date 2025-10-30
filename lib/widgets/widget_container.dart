import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import '../config/theme/custom_theme.dart';
import 'custom_card.dart';
import 'bundles/battery_bundle_large_preview.dart';
import 'bundles/battery_bundle_extra_large_preview.dart';

class WidgetContainer extends StatefulWidget {
  final WidgetItem item;
  final Widget? previewChild;

  const WidgetContainer({super.key, required this.item, this.previewChild});
  @override
  State<WidgetContainer> createState() => _WidgetContainerState();
}

class _WidgetContainerState extends State<WidgetContainer> {
  late final PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = 280.0;
    final sizes = widget.item.supportedSizes;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: maxHeight,
          child: PageView.builder(
            itemCount: sizes.length,
            controller: _pageController,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              final size = sizes[index];

              final isBatteryBundle = widget.item.type.name == 'batteryBundle';
              final isLarge = size == WidgetSize.large;
              final isExtraLarge = size == WidgetSize.extraLarge;

              if (isBatteryBundle && isLarge) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BatteryBundleLargePreview(item: widget.item, size: size),
                    const SizedBox(height: 8),
                    Text(
                      size.name,
                      style: CustomTheme(
                        context,
                      ).themeData.textTheme.bodyMedium,
                    ),
                  ],
                );
              }

              if (isBatteryBundle && isExtraLarge) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BatteryBundleExtraLargePreview(
                      item: widget.item,
                      size: size,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      size.name,
                      style: CustomTheme(
                        context,
                      ).themeData.textTheme.bodyMedium,
                    ),
                  ],
                );
              }

              // default: single card preview
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCard(
                    width: size.width,
                    height: size.height,
                    borderRadius: 15,
                    padding: const EdgeInsets.all(12),
                    useGlassEffect: false,
                    background: CustomColors.dark700,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              widget.item.svgAsset,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                CustomColors.light,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.item.id,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTheme(context)
                                    .themeData
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: CustomColors.light),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: CustomColors.light600,
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // TO DO
                        // show the content of each card preview
                        // make a skeleton/future to load actual preview if available
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    size.name,
                    style: CustomTheme(context).themeData.textTheme.bodyMedium,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(sizes.length, (index) {
            final isActive = index == currentIndex;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? CustomColors.green300 : CustomColors.light600,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
