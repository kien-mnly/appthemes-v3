import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:appthemes_v3/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:appthemes_v3/widgets/edit_bar.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;
  int selectedThemeIndex = 1; // Default to Ocean Breeze

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void changeTheme(int index) {
    setState(() {
      selectedThemeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: customBackgrounds[selectedThemeIndex],
      body: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: ElevatedButton(
            onPressed: toggleEditMode,
            child: Text(isEditMode ? 'Exit Edit Mode' : 'Enter Edit Mode'),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isEditMode
            ? EditToolbar(
                onExit: toggleEditMode,
                onThemeChange: changeTheme,
                selectedThemeIndex: selectedThemeIndex,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
