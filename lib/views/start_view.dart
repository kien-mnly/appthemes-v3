import 'dart:ui';

import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/theme_settings_modal.dart';
import 'package:appthemes_v3/widgets/widget_picker_modal.dart';
import 'package:appthemes_v3/widgets/edit_toolbar.dart';
import '../config/theme/custom_colors.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedThemeIndex = 2;

  void toggleThemeSettings() {
    ThemeSettings.show(
      context: context,
      selectedThemeIndex: selectedThemeIndex,
      onThemeChange: (index) => setState(() => selectedThemeIndex = index),
      onExit: () {},
    );
  }

  void showWidgetPicker() {
    WidgetPickerModal.show(context: context, onExit: () {});
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
              setState(() {
                isEditMode = true;
              });
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.transparent,
                builder: (_) => EditToolbar(
                  onSave: () {
                    // Implement save functionality
                  },
                  onAddWidget: showWidgetPicker,
                  onOpenSettings: toggleThemeSettings,
                ),
              );
              if (!mounted) return;
              setState(() {
                isEditMode = false;
              });
            } else {
              setState(() {
                isEditMode = false;
              });
            }
          },
        ),
      ],
      body: const SizedBox.expand(),
      bottomNavigationBar: const SizedBox.shrink(),
    );
  }
}
