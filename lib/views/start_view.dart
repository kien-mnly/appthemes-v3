import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:appthemes_v3/widgets/theme_modal.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/theme_settings_modal.dart';
import 'package:appthemes_v3/widgets/widget_list.dart';
import 'package:appthemes_v3/widgets/widget_modal.dart';
import 'package:appthemes_v3/widgets/edit_toolbar.dart';
import '../config/theme/custom_colors.dart';
import '../widgets/bottom_modal.dart';
import 'package:appthemes_v3/widgets/dashboard.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:appthemes_v3/views/widgets/floating_bottom_bar.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedThemeIndex = 2;
  int selectedIndex = 1;

  void onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      selectedIndex = index;
    });
  }

  final List<DashboardWidget> _dashboardItems = [];
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

  WidgetContent? resolveItem(String itemId) {
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

  void onAddWidget(WidgetContent item, int selectedIndex) {
    final newItem = item.supportedSizes[selectedIndex];
    final existingItem = _dashboardItems.indexWhere(
      (current) => current.itemId == item.id,
    );
    if (existingItem == -1) {
      final newConfig = DashboardWidget(
        itemId: item.id,
        size: item.supportedSizes[selectedIndex],
      );
      setState(() => _dashboardItems.add(newConfig));
      _storage.save(_dashboardItems);
      return;
    }

    final existing = _dashboardItems[existingItem];

    final updatedConfig = DashboardWidget(
      itemId: existing.itemId,
      size: newItem,
    );

    setState(() {
      _dashboardItems[existingItem] = updatedConfig;
    });
    _storage.save(_dashboardItems);
  }

  void _openAddWidget() {
    BottomDialog.showCustom(
      context: context,
      child: WidgetList(
        onPick: (WidgetContent item) {
          Navigator.pop(context);
          BottomDialog.showCustom(
            context: context,
            child: WidgetModal(
              item: item,
              onAdd: (pickedItem, selectedIndex) {
                onAddWidget(item, selectedIndex);
              },
            ),
          );
        },
      ),
    );
  }

  String getPageNameByIndex() {
    switch (selectedIndex) {
      case 0:
        return 'statistics';
      case 1:
        return 'dashboard';
      case 2:
        return 'settings';
      default:
        return 'dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: Text(
        getPageNameByIndex(),
        style: CustomTheme(context).themeData.textTheme.headlineMedium,
      ),
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
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EditToolbar(
                    onSave: () {
                      BottomDialog.showCustom(
                        context: context,
                        child: ThemeModal(
                          selectedThemeIndex: selectedThemeIndex,
                          onThemeChange: (index) {
                            setState(() {
                              selectedThemeIndex = index;
                            });
                          },
                          onPresetDashboard: (configs) {
                            setState(() {
                              _dashboardItems
                                ..clear()
                                ..addAll(configs);
                              // Exit edit mode after applying preset dashboard
                              isEditMode = false;
                            });
                            _storage.save(_dashboardItems);
                          },
                        ),
                      );
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
            if (!isEditMode)
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingBottomBar(
                  selectedIndex: selectedIndex,
                  onItemTapped: onItemTapped,
                  items: [
                    FloatingBottomBarItem(
                      icon: AssetIcons.barChart,
                      label: 'analytics',
                    ),
                    FloatingBottomBarItem(
                      icon: AssetIcons.house,
                      label: 'dashboard',
                    ),
                    FloatingBottomBarItem(
                      icon: AssetIcons.settings,
                      label: 'settings',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
