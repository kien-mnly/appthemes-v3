import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/energy_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import '../config/theme/custom_theme.dart';
import 'custom_card.dart';
import 'dashboard_widgets/battery_bundle/battery_bundle_large.dart';
import 'dashboard_widgets/battery_bundle/battery_bundle_xl.dart';
import 'dashboard_widgets/smartmode.dart';

class WidgetContainer extends StatefulWidget {
  final WidgetItem item;
  final Widget? previewChild;
  final int initialIndex;
  final ValueChanged<int>? onPageChanged;

  final bool preview;
  final WidgetSize? fixedSize;

  const WidgetContainer({
    super.key,
    required this.item,
    this.previewChild,
    this.initialIndex = 0,
    this.onPageChanged,
    this.preview = true,
    this.fixedSize,
  });
  @override
  State<WidgetContainer> createState() => _WidgetContainerState();
}

class _WidgetContainerState extends State<WidgetContainer> {
  late final PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = 300.0;
    final sizes = widget.item.supportedSizes;

    if (!widget.preview) {
      final WidgetSize size =
          widget.fixedSize ??
          sizes[(widget.initialIndex).clamp(0, sizes.length - 1)];
      return containerContent(size);
    }

    return Column(
      children: [
        SizedBox(
          height: maxHeight,
          child: PageView.builder(
            itemCount: sizes.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) {
              final size = sizes[index];
              final content = containerContent(size);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  content,
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

  Widget containerContent(WidgetSize size) {
    final isBatteryBundle = widget.item.type.name == 'batteryBundle';
    if (isBatteryBundle) {
      return size == WidgetSize.extraLarge
          ? BatteryBundleExtraLarge(item: widget.item, size: size)
          : BatteryBundleLarge(item: widget.item, size: size);
    }

    final isEnergyUsage = widget.item.type.name == 'energyUsage';
    final isRegular = size == WidgetSize.regular;

    return CustomCard(
      width: size.width,
      height: size.height,
      borderRadius: 24,
      padding: (isEnergyUsage && size == WidgetSize.large) || isRegular
          ? EdgeInsets.zero
          : const EdgeInsets.all(12),
      useGlassEffect: true,
      background: CustomColors.dark700,
      child: Column(
        children: [
          Padding(
            padding: isEnergyUsage ? const EdgeInsets.all(12) : EdgeInsets.zero,
            child: Row(
              children: [
                if (widget.item.type.name != 'smartMode' &&
                    widget.item.type.name != 'energyUsage' &&
                    widget.item.type.name != 'energyBalance')
                  SvgPicture.asset(
                    widget.item.svgAsset,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.item.id,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTheme(context).themeData.textTheme.labelLarge
                        ?.copyWith(color: CustomColors.light),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: CustomColors.light600,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (widget.item.type.name == 'smartMode') Smartmode(size: size),
          if (isEnergyUsage) EnergyUsage(size: size),
        ],
      ),
    );
  }
}
