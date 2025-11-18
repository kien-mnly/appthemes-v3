import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:flutter/cupertino.dart';
import '../config/theme/custom_colors.dart';
import '../models/enums/background_theme.dart';
import '../widgets/button.dart';
import '../config/theme/custom_painter.dart';
import 'package:appthemes_v3/services/background_service.dart';

class ThemeSettingsModal extends StatefulWidget {
  const ThemeSettingsModal({
    super.key,
    required this.selectedThemeIndex,
    required this.onThemeChange,
    required this.onExit,
    this.onSaveCustomDashboard,
  });

  final int selectedThemeIndex;
  final ValueChanged<int> onThemeChange;
  final VoidCallback onExit;
  final ValueChanged<String>? onSaveCustomDashboard;

  @override
  State<ThemeSettingsModal> createState() => _ThemeSettingsModalState();
}

class _ThemeSettingsModalState extends State<ThemeSettingsModal> {
  late int currentIndex;
  late int originalIndex;
  bool _saved = false;
  late final TextEditingController _nameController;
  late final BackgroundService selectTheme = locator<BackgroundService>();

  @override
  void initState() {
    super.initState();
    currentIndex = selectTheme.preferredTheme.index;
    originalIndex = currentIndex;
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = selectTheme.currentBackgroundTheme.accentColor;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!_saved) {
          // Revert any preview changes on dismiss/cancel
          selectTheme.restorePreferredTheme = true;
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 12),
          Title(
            color: CustomColors.light,
            child: Text(
              'Thema Instellingen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CustomColors.light,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Verander het thema van je dashboard of pas de naam aan.',
            style: TextStyle(
              fontSize: 14,
              color: CustomColors.light,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(BackgroundTheme.values.length - 1, (index) {
                final theme = BackgroundTheme.values[index];
                final isSelected = index == currentIndex;
                return GestureDetector(
                  onTap: () {
                    if (currentIndex != index) {
                      setState(() {
                        currentIndex = index;
                      });
                    }
                    // Preview only; do not persist yet
                    selectTheme.setPreviewTheme =
                        BackgroundTheme.values[currentIndex];
                  },
                  child: SizedBox(
                    width: 78,
                    height: 78,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? accent : CustomColors.light,
                          width: 1.25,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CustomPaint(
                              painter: ThemeSelector(
                                backgroundColors:
                                    theme.customBackground.backgroundColor,
                                elementColors:
                                    theme.customBackground.elementColors,
                                elementOpacity: 0.42,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            controller: _nameController,
            placeholder: 'Stel aangepaste dashboard naam in',
            placeholderStyle: const TextStyle(color: CustomColors.light),
            style: const TextStyle(color: CustomColors.light),
            decoration: BoxDecoration(
              color: CustomColors.dark.withValues(alpha: .6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: CustomColors.light.withValues(alpha: 0.4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Button(
            title: 'Opslaan',
            onPressed: () {
              _saved = true;
              selectTheme.preferredTheme = BackgroundTheme.values[currentIndex];
              widget.onThemeChange(currentIndex);
              // If a custom-dashboard save callback is provided, pass the name
              widget.onSaveCustomDashboard?.call(_nameController.text.trim());
              widget.onExit();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 16),
          Button(
            title: 'Annuleren',
            onPressed: () {
              // Revert preview and close without saving
              selectTheme.restorePreferredTheme = true;
              // Reset local selection to original for next open
              setState(() => currentIndex = originalIndex);
              widget.onExit();
              Navigator.of(context).pop();
            },
            type: ButtonType.secondary,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
