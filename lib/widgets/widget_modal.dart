import 'package:appthemes_v3/widgets/button.dart';
import 'package:flutter/material.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'widget_container.dart';

class WidgetModal extends StatefulWidget {
  final WidgetContent item;
  final void Function(WidgetContent item, int selectedIndex)? onAdd;

  const WidgetModal({super.key, required this.item, this.onAdd});

  @override
  State<WidgetModal> createState() => _WidgetModalState();
}

class _WidgetModalState extends State<WidgetModal> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        SvgPicture.asset(
          widget.item.svgAsset,
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 16),
        Text(
          widget.item.id,
          style: CustomTheme(context).themeData.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        WidgetContainer(
          item: widget.item,
          initialIndex: _selectedIndex,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),

        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Button(
                title: 'Add Widget',
                onPressed: () {
                  widget.onAdd!(widget.item, _selectedIndex);
                  Navigator.of(context).pop();
                },
                type: ButtonType.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
