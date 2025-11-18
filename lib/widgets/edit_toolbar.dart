import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_it/watch_it.dart';
import 'package:appthemes_v3/services/background_service.dart';
import '../config/theme/custom_colors.dart';

class EditToolbar extends StatefulWidget with WatchItStatefulWidgetMixin {
  const EditToolbar({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.onAddWidget,
  });

  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onAddWidget;

  @override
  State<EditToolbar> createState() => _EditToolbarState();
}

class _EditToolbarState extends State<EditToolbar> {
  @override
  Widget build(BuildContext context) {
    final accent = watch(
      locator<BackgroundService>(),
    ).currentBackgroundTheme.accentColor;
    final items = [
      _ToolbarItem(
        icon: SvgPicture.asset(
          AssetIcons.addWidget,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            CustomColors.dark,
            BlendMode.srcIn,
          ),
        ),
        label: 'Voeg Widget toe',
        bgColor: accent,
        iconColor: CustomColors.dark,
        textColor: CustomColors.dark,
        onPressed: widget.onAddWidget,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.16,
          vertical: 12,
        ),
      ),
      _ToolbarItem(
        icon: SvgPicture.asset(
          AssetIcons.paintBoard,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            CustomColors.light,
            BlendMode.srcIn,
          ),
        ),
        label: 'Thema\'s',
        bgColor: CustomColors.dark700,
        iconColor: CustomColors.light,
        textColor: CustomColors.light,
        onPressed: widget.onSave,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.09,
          vertical: 12,
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }
}

class _ToolbarItem extends StatelessWidget {
  const _ToolbarItem({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.textColor,
    required this.onPressed,
    required this.padding,
  });

  final Widget icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: textColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
