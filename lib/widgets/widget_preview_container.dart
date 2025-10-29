import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_type.dart';
import '../config/theme/custom_theme.dart';
import 'custom_card.dart';

class WidgetPreviewContainer extends StatelessWidget {
  final PickerItem item;
  final Widget? previewChild;
  final double width;

  const WidgetPreviewContainer({
    super.key,
    required this.item,
    this.previewChild,
    this.width = 320,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: width,
      padding: const EdgeInsets.all(16),
      borderRadius: 24,
      borderSide: BorderSide(color: CustomColors.light600),
      background: CustomColors.dark,
      blurSigma: 10,
      useGlassEffect: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.nameKey,
                style: CustomTheme(context).themeData.textTheme.titleMedium
                    ?.copyWith(color: CustomColors.light),
              ),
              Icon(Icons.chevron_right, color: CustomColors.light600, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TO DO: replace with item icon if available
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
