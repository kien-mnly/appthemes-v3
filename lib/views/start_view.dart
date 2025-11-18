import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/models/custom_dashboard.dart';
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
import 'package:appthemes_v3/services/dashboard_controller.dart';
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
  int selectedViewIndex = 1;

  bool isPreset = false;

  void onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      selectedViewIndex = index;
    });
  }

  final List<DashboardWidget> _dashboardItems = [];

  List<CustomDashboard> _customDashboards = [];
  String? _activeCustomDashboardName;

  late final DashboardController _dashboardController;

  @override
  void initState() {
    super.initState();
    _dashboardController = DashboardController();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    await _dashboardController.loadInitial();

    if (!mounted) return;

    setState(() {
      _dashboardItems
        ..clear()
        ..addAll(
          _dashboardController.items.where(
            (cfg) => resolveItem(cfg.itemId) != null,
          ),
        );
      _customDashboards = _dashboardController.customDashboards;
      selectedThemeIndex = _dashboardController.selectedPresetIndex;
      isPreset = _dashboardController.isPreset;
      _activeCustomDashboardName =
          _dashboardController.activeCustomDashboardName;
    });
  }

  void _deleteDashboardItem(String itemId) async {
    setState(() {
      _dashboardItems.removeWhere((item) => item.itemId == itemId);
    });

    await onDashboardChanged(
      fromCustomDashboard: _activeCustomDashboardName != null,
    );
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
    onDashboardChanged(fromCustomDashboard: _activeCustomDashboardName != null);
  }

  void onAddWidget(WidgetContent item, int selectedViewIndex) {
    final newItem = item.supportedSizes[selectedViewIndex];
    final existingItem = _dashboardItems.indexWhere(
      (current) => current.itemId == item.id,
    );
    if (existingItem == -1) {
      final newConfig = DashboardWidget(itemId: item.id, size: newItem);
      setState(() => _dashboardItems.add(newConfig));
      onDashboardChanged(
        fromCustomDashboard: _activeCustomDashboardName != null,
      );
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
    onDashboardChanged(fromCustomDashboard: _activeCustomDashboardName != null);
  }

  Future<void> onDashboardChanged({bool fromCustomDashboard = false}) async {
    _dashboardController.setItems(_dashboardItems);
    await _dashboardController.persistDashboardChanges(
      fromCustomDashboard: fromCustomDashboard,
    );

    // Keep local flags in sync with controller
    isPreset = _dashboardController.isPreset;
    selectedThemeIndex = _dashboardController.selectedPresetIndex;
    _activeCustomDashboardName = _dashboardController.activeCustomDashboardName;
    _customDashboards = _dashboardController.customDashboards;
  }

  Future<String?> askForCustomDashboardName() async {
    String? name;

    await BottomDialog.showCustom(
      context: context,
      child: ThemeSettingsModal(
        selectedThemeIndex: selectedThemeIndex,
        onThemeChange: (index) {
          setState(() {
            selectedThemeIndex = index;
          });
        },
        onExit: () {},
        onSaveCustomDashboard: (value) {
          name = value;
        },
      ),
    );

    return name;
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
              onAdd: (pickedItem, selectedViewIndex) {
                onAddWidget(item, selectedViewIndex);
              },
            ),
          );
        },
      ),
    );
  }

  String getPageNameByIndex() {
    switch (selectedViewIndex) {
      case 0:
        return 'statistics';
      case 1:
        return 'Dashboard';
      case 2:
        return 'settings';
      default:
        return 'dashboard';
    }
  }

  void _showThemeModal() {
    BottomDialog.showCustom(
      context: context,
      child: ThemeModal(
        selectedThemeIndex: selectedThemeIndex,
        onThemeChange: (index) {
          setState(() {
            selectedThemeIndex = index;
            _activeCustomDashboardName = null;
          });
        },
        onPresetDashboard: (configs) {
          setState(() {
            _dashboardItems
              ..clear()
              ..addAll(configs);
            isPreset = true;
          });
          onDashboardChanged();
        },
        customDashboards: [..._customDashboards],
        onCustomDashboardSelected: (configs) {
          setState(() {
            _dashboardItems
              ..clear()
              ..addAll(configs);
            isPreset = false;
          });
          onDashboardChanged(fromCustomDashboard: true);
        },
        onDeleteCustomDashboard: (dashboard) async {
          await _dashboardController.deleteCustomDashboard(dashboard);
          if (!mounted) return;
          setState(() {
            _customDashboards = _dashboardController.customDashboards;
            _activeCustomDashboardName =
                _dashboardController.activeCustomDashboardName;
          });
        },
        activeCustomDashboardName: _activeCustomDashboardName,
        onCustomDashboardNameSelected: (name) {
          _activeCustomDashboardName = name;
          Navigator.of(context).pop();
          BottomDialog.showCustom(
            context: context,
            child: ThemeSettingsModal(
              selectedThemeIndex: selectedThemeIndex,
              onThemeChange: (index) async {
                // Update the global selected theme index
                setState(() => selectedThemeIndex = index);

                // Update stored theme for the active custom
                _dashboardController.selectedPresetIndex = index;
                await _dashboardController.updateActiveCustomDashboardTheme(
                  index,
                );
                if (!mounted) return;
                setState(() {
                  _customDashboards = _dashboardController.customDashboards;
                });
              },
              onSaveCustomDashboard: (newName) async {
                await _dashboardController.renameActiveCustomDashboard(newName);
                if (!mounted) return;
                setState(() {
                  _customDashboards = _dashboardController.customDashboards;
                  _activeCustomDashboardName =
                      _dashboardController.activeCustomDashboardName;
                });
              },
              onExit: () {},
            ),
          );
        },
      ),
    );
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
                    onSave: _showThemeModal,
                    onCancel: () => setState(() => isEditMode = false),
                    onAddWidget: _openAddWidget,
                  ),
                ),
              ),
            if (!isEditMode)
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingBottomBar(
                  selectedViewIndex: selectedViewIndex,
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
