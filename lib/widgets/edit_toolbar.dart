import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/theme/custom_colors.dart';

class EditToolbar extends StatefulWidget {
  const EditToolbar({
    super.key,
    required this.onSave,
    required this.onAddWidget,
    required this.onOpenSettings,
  });

  final VoidCallback onSave;
  final VoidCallback onAddWidget;
  final VoidCallback onOpenSettings;

  @override
  State<EditToolbar> createState() => _EditToolbarState();
}

class _EditToolbarState extends State<EditToolbar> {
  @override
  Widget build(BuildContext context) {
    final items = [
      _ToolbarItem(
        icon: SvgPicture.asset(
          AssetIcons.save,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            CustomColors.light,
            BlendMode.srcIn,
          ),
        ),
        label: 'Opslaan',
        bgColor: CustomColors.dark700,
        iconColor: CustomColors.light,
        textColor: CustomColors.light,
        onPressed: widget.onSave,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      _ToolbarItem(
        icon: SvgPicture.asset(
          AssetIcons.addWidget,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            CustomColors.dark,
            BlendMode.srcIn,
          ),
        ),
        label: 'Voeg Widget toe',
        bgColor: CustomColors.green300,
        iconColor: CustomColors.dark,
        textColor: CustomColors.dark,
        onPressed: widget.onAddWidget,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
      _ToolbarItem(
        icon: SvgPicture.asset(
          AssetIcons.settings,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            CustomColors.light,
            BlendMode.srcIn,
          ),
        ),
        label: 'Instellingen',
        bgColor: CustomColors.dark700,
        iconColor: CustomColors.light,
        textColor: CustomColors.light,
        onPressed: widget.onOpenSettings,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
