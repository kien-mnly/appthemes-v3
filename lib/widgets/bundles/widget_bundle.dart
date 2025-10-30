import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/widgets/custom_card.dart';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';

class WidgetBundle extends StatelessWidget {
  const WidgetBundle({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    this.child,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 18,
    this.background = CustomColors.dark700,
    this.onTap,
  });

  final WidgetItem item;
  final double width;
  final double height;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color background;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final header = Row(
      children: [
        SvgPicture.asset(
          item.svgAsset,
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
            item.id,
            overflow: TextOverflow.ellipsis,
            style: CustomTheme(context).themeData.textTheme.titleSmall
                ?.copyWith(color: CustomColors.light),
          ),
        ),
        const Icon(Icons.chevron_right, color: CustomColors.light600, size: 28),
      ],
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, const SizedBox(height: 8), if (child != null) child!],
    );

    final card = CustomCard(
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      useGlassEffect: false,
      background: background,
      child: content,
    );

    if (onTap == null) return card;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: card,
    );
  }
}
