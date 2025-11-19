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

class StartView extends StatefulWidget with WatchItStatefulWidgetMixin {
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

  late final DashboardController _controller = locator<DashboardController>();

  @override
  void initState() {
    super.initState();
    _controller.load();
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
                _controller.addOrUpdateWidget(item, selectedViewIndex);
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
                onDeleteItem: controller.deleteItem,
                onReorder: controller.reorder,
                resolveItem: controller.resolveItem,
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
                          customDashboards: [...controller.customDashboards],
                          onPresetDashboard: (configs) {
                            controller.applyCurrentPreset();
                            Console.log(
                              'Selected dashboard: ${controller.customDashboards}',
                            );
                          },
                          onDeleteCustomDashboard: (configs) {
                            controller.deleteCustomDashboard(configs);
                          },
                          onCustomDashboardSelected: (configs) {
                            // controller.loadCustomDashboard(configs.name);
                          },
                          onCustomDashboardNameSelected: (name) {
                            // controller.loadCustomDashboard(name);
                          },
                        ),
                      );
                    },
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
