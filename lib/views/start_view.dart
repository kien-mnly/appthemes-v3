import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/theme_settings_modal.dart';
import 'package:appthemes_v3/widgets/widget_list.dart';
import 'package:appthemes_v3/widgets/widget_modal.dart';
import 'package:appthemes_v3/widgets/edit_toolbar.dart';
import '../config/theme/custom_colors.dart';
import '../widgets/bottom_modal.dart';
import 'package:appthemes_v3/widgets/dashboard.dart';
import 'package:appthemes_v3/models/widget_config.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedThemeIndex = 2;

  final List<WidgetConfig> _dashboardItems = [];
  final DashboardStorage _storage = DashboardStorage();

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final stored = await _storage.load();
    if (!mounted) return;
    setState(() {
      _dashboardItems
        ..clear()
        ..addAll(stored.where((cfg) => resolveItem(cfg.itemId) != null));
    });
  }

  void _deleteDashboardItem(String itemId) async {
    setState(() {
      _dashboardItems.removeWhere((item) => item.itemId == itemId);
    });

    final storage = DashboardStorage();
    await storage.save(_dashboardItems);
  }

  WidgetItem? resolveItem(String itemId) {
    try {
      return WidgetType.values
          .firstWhere((t) => t.widgetItem.id == itemId)
          .widgetItem;
    } catch (_) {
      return null;
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _dashboardItems.removeAt(oldIndex);
      _dashboardItems.insert(newIndex, item);
    });
    _storage.save(_dashboardItems);
  }

  void onAddWidget(WidgetItem item, int selectedIndex) {
    final newConfig = WidgetConfig(
      id: UniqueKey().toString(),
      itemId: item.id,
      selectedIndex: selectedIndex,
      size: item.supportedSizes[selectedIndex],
    );
    setState(() => _dashboardItems.add(newConfig));
    _storage.save(_dashboardItems);
  }

  void _openAddWidget() {
    BottomDialog.showCustom(
      context: context,
      child: WidgetList(
        onPick: (WidgetItem item) {
          Navigator.pop(context); // close list
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: customBackgrounds[selectedThemeIndex],
      actions: [
        IconButton(
          icon: Icon(isEditMode ? Icons.close : Icons.edit),
          color: CustomColors.light,
          onPressed: () {
            setState(() => isEditMode = !isEditMode);
          },
        ),
      ],
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Dashboard(
                items: _dashboardItems,
                isEditMode: isEditMode,
                onDeleteItem: _deleteDashboardItem,
                onReorder: onReorder,
                resolveItem: resolveItem,
              ),
            ),
            if (isEditMode)
              SafeArea(
                bottom: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EditToolbar(
                    onSave: () {
                      _storage.save(_dashboardItems);
                      setState(() => isEditMode = false);
                    },
                    onCancel: () => setState(() => isEditMode = false),
                    onAddWidget: _openAddWidget,
                    onOpenSettings: () {
                      BottomDialog.showCustom(
                        context: context,
                        child: ThemeSettingsModal(
                          selectedThemeIndex: selectedThemeIndex,
                          onThemeChange: (index) {
                            setState(() => selectedThemeIndex = index);
                          },
                          onExit: () {},
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox.shrink(),
    );
  }
}
