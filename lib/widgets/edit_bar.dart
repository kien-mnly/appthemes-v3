import 'package:flutter/material.dart';
import '../config/theme/custom_background.dart';

class EditToolbar extends StatelessWidget {
  final VoidCallback onExit;
  final Function(int) onThemeChange;
  final int selectedThemeIndex;

  const EditToolbar({
    super.key,
    required this.onExit,
    required this.onThemeChange,
    required this.selectedThemeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onExit,
          ),
          ...List.generate(customBackgrounds.length, (index) {
            final theme = customBackgrounds[index];
            final isSelected = index == selectedThemeIndex;
            return GestureDetector(
              onTap: () => onThemeChange(index),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: theme.backgroundColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.grey,
                    width: isSelected ? 3 : 2,
                  ),
                ),
              ),
            );
          }),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Open settings dialog
            },
          ),
        ],
      ),
    );
  }
}
