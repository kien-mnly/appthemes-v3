import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/theme_settings_modal.dart';
import 'package:appthemes_v3/widgets/widget_list.dart';
import 'package:appthemes_v3/widgets/edit_toolbar.dart';
import '../config/theme/custom_colors.dart';
import '../widgets/bottom_modal.dart';
import 'package:appthemes_v3/widgets/dashboard.dart';
import 'package:appthemes_v3/models/widget_config.dart';
import 'package:appthemes_v3/models/widget_item.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/widgets/widget_modal.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedThemeIndex = 2;

  final List<WidgetConfig> _dashboardItems = [];

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
  }

  void onAddWidget(WidgetItem item, int selectedIndex) {
    final newConfig = WidgetConfig(
      id: UniqueKey().toString(),
      itemId: item.id,
      selectedIndex: selectedIndex,
      size: item.supportedSizes[selectedIndex],
      meta: {},
    );
    setState(() => _dashboardItems.add(newConfig));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: customBackgrounds[selectedThemeIndex],
      actions: [
        IconButton(
          icon: Icon(isEditMode ? Icons.close : Icons.edit),
          color: CustomColors.light,
          onPressed: () async {
            if (!isEditMode) {
              setState(() => isEditMode = true);

              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.transparent,
                builder: (_) => EditToolbar(
                  onSave: () {
                    // Implement save functionality
                  },
                  onAddWidget: () {
                    BottomDialog.showCustom(
                      context: context,
                      child: WidgetList(
                        onPick: (WidgetItem item) {
                          Navigator.pop(context);
                          BottomDialog.showCustom(
                            context: context,
                            child: WidgetModal(
                              item: item,
                              onAdd: (item, selectedIndex) {
                                onAddWidget(item, selectedIndex);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  onOpenSettings: () {
                    BottomDialog.showCustom(
                      context: context,
                      child: ThemeSettingsModal(
                        selectedThemeIndex: selectedThemeIndex,
                        onThemeChange: (index) {
                          setState(() {
                            selectedThemeIndex = index;
                          });
                        },
                        onExit: () {},
                      ),
                    );
                  },
                ),
              );

              if (!mounted) return;
              setState(() => isEditMode = false);
            } else {
              setState(() => isEditMode = false);
            }
          },
        ),
      ],

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Dashboard(
            items: _dashboardItems,
            isEditMode: isEditMode,
            onReorder: onReorder,
            resolveItem: resolveItem,
          ),
        ),
      ),

      bottomNavigationBar: const SizedBox.shrink(),
    );
  }
}
