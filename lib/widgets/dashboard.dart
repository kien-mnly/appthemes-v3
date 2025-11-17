import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:appthemes_v3/config/constants/widget_constants.dart';
import 'package:appthemes_v3/models/dashboard_config.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/widgets/widget_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.items,
    required this.isEditMode,
    required this.onReorder,
    required this.resolveItem,
    required this.onDeleteItem,
  });

  final bool isEditMode;
  final void Function(int oldIndex, int newIndex) onReorder;
  final WidgetItem? Function(String itemId) resolveItem;
  final List<DashboardConfig> items;
  final void Function(String itemId) onDeleteItem;

  @override
  Widget build(BuildContext context) {
    final children = items.map((dashboardItem) {
      final item = resolveItem(dashboardItem.itemId);
      return SizedBox(
        key: ValueKey(dashboardItem.id),
        child: WidgetContainer(
          item: item!,
          preview: false,
          fixedSize: dashboardItem.size,
          initialIndex: dashboardItem.selectedIndex,
          isEditMode: isEditMode,
          onDelete: () => onDeleteItem(dashboardItem.itemId),
        ),
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          isEditMode
              ? ReorderableWrap(
                  spacing: gap,
                  runSpacing: gap,
                  needsLongPressDraggable: true,
                  onReorder: onReorder,
                  buildDraggableFeedback: (context, constraints, child) {
                    return Material(
                      elevation: 6.0,
                      type: MaterialType.transparency,
                      child: child,
                    );
                  },
                  children: children,
                )
              : Wrap(spacing: gap, runSpacing: gap, children: children),
          SizedBox(height: 125),
        ],
      ),
    );
  }
}
