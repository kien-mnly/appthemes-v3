import 'package:flutter/material.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/extensions/widget_type.dart';

class WidgetPreviewModal extends StatelessWidget {
  final PickerItem item;
  final VoidCallback? onAdd;

  const WidgetPreviewModal({super.key, required this.item, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        SvgPicture.asset(
          item.svgAsset,
          width: 72,
          height: 72,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 16),
        Text(
          item.nameKey,
          style: CustomTheme(context).themeData.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Preview of the widget goes here. This area can be expanded to render a real preview.',
          style: CustomTheme(context).themeData.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onAdd ?? () => Navigator.pop(context),
                child: Text('Add widget'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
