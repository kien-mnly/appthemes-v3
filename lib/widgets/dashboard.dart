import 'package:appthemes_v3/widgets/widget_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:appthemes_v3/config/constants/widget_constants.dart';
import 'package:appthemes_v3/models/widget_config.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/widgets/widget_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.items,
    required this.isEditMode,
    required this.onReorder,
    required this.resolveItem,
  });

  final bool isEditMode;
  final void Function(int oldIndex, int newIndex) onReorder;
  final WidgetItem? Function(String itemId) resolveItem;
  final List<WidgetConfig> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ReorderableWrap(
        spacing: gap,
        runSpacing: gap,
        // needsLongPressDraggable: isEditMode,
        onReorder: (oldIndex, newIndex) => {
          if (isEditMode) onReorder(oldIndex, newIndex),
        },
        children: items.map((cfg) {
          final item = resolveItem(cfg.itemId);
          return SizedBox(
            key: ValueKey(cfg.id),
            child: WidgetContainer(item: item!),
          );
        }).toList(),
      ),
    );
  }
}
