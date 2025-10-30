import 'package:flutter/material.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'widget_container.dart';

class WidgetModal extends StatelessWidget {
  final WidgetItem item;
  final VoidCallback? onAdd;

  const WidgetModal({super.key, required this.item, this.onAdd});

  @override
  Widget build(BuildContext context) {
    // attempt to obtain a card preview from the first variant (if available)
    Widget? cardPreview;
    try {
      final cards = (item as dynamic).cards;
      if (cards != null && cards.isNotEmpty) {
        final previewBuilder = cards.first.previewBuilder;
        if (previewBuilder is WidgetBuilder) {
          cardPreview = previewBuilder(context);
        }
      }
    } catch (_) {
      cardPreview = null;
    }

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
          item.nameKey,
          style: CustomTheme(context).themeData.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        WidgetContainer(item: item, previewChild: cardPreview),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onAdd ?? () => Navigator.pop(context),
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
