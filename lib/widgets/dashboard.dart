import 'package:appthemes_v3/widgets/widget_config.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:appthemes_v3/config/constants/widget_constants.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/widget_content.dart';

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
  final WidgetContent? Function(String itemId) resolveItem;
  final List<DashboardWidget> items;
  final void Function(String itemId) onDeleteItem;

  @override
  Widget build(BuildContext context) {
    final children = items.map((dashboardItem) {
      final item = resolveItem(dashboardItem.itemId);
      return SizedBox(
        child: WidgetConfig(
          item: item!,
          size: dashboardItem.size,
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
