import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/widgets/custom_card.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/battery_bundle_large.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/battery_bundle/battery_bundle_xl.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/energy_usage.dart';
import 'package:appthemes_v3/widgets/dashboard_widgets/smartmode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetConfig extends StatelessWidget {
  final WidgetContent item;
  final WidgetSize size;
  final bool isEditMode;
  final VoidCallback? onDelete;

  const WidgetConfig({
    super.key,
    required this.item,
    required this.size,
    required this.isEditMode,
    this.onDelete,
  });

  bool get _isBatteryBundle => item.type == WidgetType.batteryBundle;

  @override
  Widget build(BuildContext context) {
    if (_isBatteryBundle) {
      return size == WidgetSize.extraLarge
          ? BatteryBundleExtraLarge(item: item)
          : BatteryBundleLarge(item: item);
    }

    final type = item.type;
    final compactTypes = {WidgetType.energyUsage, WidgetType.smartMode};
    final compactSizes = {
      WidgetSize.large,
      WidgetSize.long,
      WidgetSize.regular,
    };
    final useZeroPadding =
        compactTypes.contains(type) && compactSizes.contains(size);

    final hideIcon =
        type == WidgetType.smartMode ||
        type == WidgetType.energyUsage ||
        type == WidgetType.energyBalance;

    return CustomCard(
      width: size.width(context),
      height: size.height,
      padding: useZeroPadding ? EdgeInsets.zero : const EdgeInsets.all(12),
      child: Column(
        children: [
          Padding(
            padding: hideIcon
                ? const EdgeInsets.fromLTRB(10, 10, 12, 0)
                : const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                if (!hideIcon)
                  SvgPicture.asset(
                    item.svgAsset,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.id,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTheme(context).themeData.textTheme.labelLarge
                        ?.copyWith(color: CustomColors.light),
                  ),
                ),
                SizedBox(
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: isEditMode ? onDelete : null,
                    icon: Icon(
                      isEditMode ? Icons.delete : Icons.chevron_right,
                      color: isEditMode
                          ? CustomColors.error
                          : CustomColors.light600,
                      size: isEditMode ? 20 : 28,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          switch (type) {
            WidgetType.smartMode => Smartmode(size: size),
            WidgetType.energyUsage => EnergyUsage(size: size),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}
