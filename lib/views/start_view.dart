import 'dart:developer' as Console;

import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:appthemes_v3/widgets/theme_modal.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/theme_settings_modal.dart';
import 'package:appthemes_v3/widgets/widget_list.dart';
import 'package:appthemes_v3/widgets/widget_modal.dart';
import 'package:appthemes_v3/widgets/edit_toolbar.dart';
import 'package:watch_it/watch_it.dart';
import '../config/theme/custom_colors.dart';
import '../widgets/bottom_modal.dart';
import 'package:appthemes_v3/widgets/dashboard.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/views/widgets/floating_bottom_bar.dart';
import 'package:appthemes_v3/config/theme/asset_icons.dart';
import 'package:appthemes_v3/services/dashboard_controller.dart';
import 'package:appthemes_v3/models/custom_dashboard.dart';

class StartView extends StatefulWidget with WatchItStatefulWidgetMixin {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedViewIndex = 1;

  bool isPreset = false;

  void onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      selectedViewIndex = index;
    });
  }

  late final DashboardController _controller = locator<DashboardController>();

  @override
  void initState() {
    super.initState();
    _controller.load();
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
                _controller.addOrUpdateWidget(
                  item,
                  selectedViewIndex,
                  fromCustomDashboard:
                      _controller.activeCustomDashboardName != null,
                );
              },
            ),
          );
        },
      ),
    );
  }

  openThemeSettings() {
    if (_controller.isPreset) {
      BottomDialog.showCustom(
        context: context,
        child: ThemeSettingsModal(
          onThemeChange: (index) async {
            await _controller.updateActiveCustomDashboardTheme(index);
          },
          onSaveCustomDashboard: (name) async {
            await _controller.saveNewCustomDashboard(name);
          },
          onExit: () {
            _controller.applyCurrentPreset();
          },
        ),
      );
    }
  }

  void _openThemeModal() {
    BottomDialog.showCustom(
      context: context,
      child: ThemeModal(
        selectedThemeIndex: _controller.selectedThemeIndex,
        activeCustomDashboardName: _controller.activeCustomDashboardName,

        onThemeChange: (index) {
          setState(() {
            _controller.setSelectedThemeIndex = index;
          });
        },
        customDashboards: [..._controller.customDashboards],
        onPresetDashboard: (configs) {
          _controller.applyCurrentPreset();
          Console.log('Selected dashboard: ${_controller.customDashboards}');
        },
        onDeleteCustomDashboard: (configs) {
          _controller.deleteCustomDashboard(configs);
        },
        onCustomDashboardSelected: (dashboard) {
          _controller.loadCustomDashboard(dashboard);
          _controller.setSelectedThemeIndex = -1;
        },
        onCustomDashboardEditor: (name) {
          CustomDashboard? customDashboard;
          try {
            customDashboard = _controller.customDashboards.firstWhere(
              (d) => d.name == name,
            );
          } catch (_) {
            customDashboard = null;
          }
          if (customDashboard != null) {
            _controller.loadCustomDashboard(customDashboard);
            openThemeSettings();
          }
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

  @override
  Widget build(BuildContext context) {
    final controller = watch(locator<DashboardController>());
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
                items: controller.dashboardItems,
                isEditMode: isEditMode,
                onDeleteItem: (itemId) {
                  controller.deleteItem(
                    itemId,
                    fromCustomDashboard:
                        controller.activeCustomDashboardName != null,
                  );
                  openThemeSettings();
                },
                onReorder: (newItem, oldItem) {
                  controller.reorder(
                    newItem,
                    oldItem,
                    fromCustomDashboard:
                        controller.activeCustomDashboardName != null,
                  );
                  openThemeSettings();
                },
                resolveItem: controller.resolveItem,
              ),
            ),
            if (isEditMode)
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EditToolbar(
                    onThemeChange: _openThemeModal,
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
