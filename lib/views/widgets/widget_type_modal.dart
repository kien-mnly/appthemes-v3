import 'package:appthemes_v3/models/dashboard_config.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:appthemes_v3/widgets/bottom_modal.dart';
import 'package:appthemes_v3/widgets/widget_list.dart';
import 'package:appthemes_v3/widgets/widget_modal.dart';
import 'package:flutter/widgets.dart';

class WidgetTypeModal extends StatefulWidget {
  const WidgetTypeModal({super.key});

  @override
  State<WidgetTypeModal> createState() => _WidgetTypeModalState();
}

class _WidgetTypeModalState extends State<WidgetTypeModal> {
  final List<DashboardConfig> _dashboardItems = [];
  final DashboardStorage _storage = DashboardStorage();

  void onAddWidget(WidgetItem item, int selectedIndex) {
    final newItem = item.supportedSizes[selectedIndex];
    final existingItem = _dashboardItems.indexWhere(
      (current) => current.itemId == item.id,
    );
    if (existingItem == -1) {
      final newConfig = DashboardConfig(
        id: UniqueKey().toString(),
        itemId: item.id,
        selectedIndex: selectedIndex,
        size: item.supportedSizes[selectedIndex],
      );
      setState(() => _dashboardItems.add(newConfig));
      _storage.save(_dashboardItems);
      return;
    }

    final existing = _dashboardItems[existingItem];

    final updatedConfig = DashboardConfig(
      id: existing.id,
      itemId: existing.itemId,
      selectedIndex: selectedIndex,
      size: newItem,
    );

    setState(() {
      _dashboardItems[existingItem] = updatedConfig;
    });
    _storage.save(_dashboardItems);
  }

  @override
  Widget build(BuildContext context) {
    return WidgetList(
      onPick: (WidgetItem item) {
        Navigator.pop(context);
        BottomDialog.showCustom(
          context: context,
          child: WidgetModal(
            item: item,
            onAdd: (pickedItem, selectedIndex) {
              onAddWidget(pickedItem, selectedIndex);
            },
          ),
        );
      },
    );
  }
}
