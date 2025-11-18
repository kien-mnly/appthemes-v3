import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_content.dart';
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
    this.headerTitle,
    this.headerIcon,
    this.showChevron = true,
  });

  final WidgetContent item;
  final double width;
  final double height;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color background;
  final VoidCallback? onTap;

  final String? headerTitle;
  final Widget? headerIcon;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final leadingIcon =
        headerIcon ??
        SvgPicture.asset(
          item.svgAsset,
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            CustomColors.light,
            BlendMode.srcIn,
          ),
        );

    final header = Row(
      children: [
        leadingIcon,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            headerTitle ?? item.id,
            overflow: TextOverflow.ellipsis,
            style: CustomTheme(context).themeData.textTheme.labelLarge
                ?.copyWith(color: CustomColors.light),
          ),
        ),
        if (showChevron)
          const Icon(
            Icons.chevron_right,
            color: CustomColors.light600,
            size: 28,
          ),
      ],
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, child ?? const SizedBox.shrink()],
    );

    final card = CustomCard(
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      background: background,
      child: content,
    );

    if (onTap == null) return card;

    return GestureDetector(onTap: onTap, child: card);
  }
}
