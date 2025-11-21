import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/services/dashboard_controller.dart';
import 'package:appthemes_v3/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class WidgetSettingsModal extends StatefulWidget
    with WatchItStatefulWidgetMixin {
  const WidgetSettingsModal({super.key, required this.item});

  final WidgetContent item;

  @override
  State<WidgetSettingsModal> createState() => _WidgetSettingsModalState();
}

class _WidgetSettingsModalState extends State<WidgetSettingsModal> {
  final controller = locator<DashboardController>();
  @override
  Widget build(BuildContext context) {
    final sizes = widget.item.supportedSizes;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text('Widget Settings', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        Row(
          spacing: 16,
          children: List.generate(sizes.length, (index) {
            final size = sizes[index];
            return Button(
              size: ButtonSize.sm,
              title: size.name,
              type: ButtonType.outline,
              onPressed: () {
                controller.updateWidgetSize(widget.item.id, size);
                Navigator.of(context).pop();
              },
            );
          }),
        ),
        const SizedBox(height: 24),
        Button(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: 'Close',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
