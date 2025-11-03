import 'package:flutter/material.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'widget_container.dart';
import 'dashboard.dart';

class WidgetModal extends StatelessWidget {
  final WidgetItem item;
  final VoidCallback? onAdd;

  const WidgetModal({super.key, required this.item, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        SvgPicture.asset(
          item.svgAsset,
          width: 32,
          height: 32,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 16),
        Text(
          item.id,
          style: CustomTheme(context).themeData.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        WidgetContainer(item: item),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop<WidgetItem>(item),
                child: const Text('Add widget'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
