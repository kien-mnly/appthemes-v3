import 'dart:ui';

import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:flutter/material.dart';
import 'custom_scaffold.dart';
import 'edit_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 1;
  int selectedThemeIndex = 0;
  bool dropdownOpen = false;

  @override
  void initState() {
    super.initState();
  }

  void onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      selectedIndex = index;
    });
  }

  void _toggleDropdown(bool isOpen) {
    if (!mounted) return;
    setState(() {
      dropdownOpen = isOpen;
    });
  }

  void _openEditToolbar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          top: false,
          child: EditToolbar(
            onExit: () => Navigator.of(context).pop(),
            onThemeChange: (i) {
              if (!mounted) return;
              setState(() {
                selectedThemeIndex = i;
              });
            },
            selectedThemeIndex: selectedThemeIndex,
          ),
        );
      },
    );
  }

  String getPageNameByIndex() {
    switch (selectedIndex) {
      case 0:
        return 'statistics.title';
      case 1:
        return 'dashboard.title';
      case 2:
        return 'settings.title';
      default:
        return 'dashboard.title';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: customBackgrounds[1],
      bottom: false,
      minBottomPadding: 0,
      extendBodyBehindAppBar: true,
      blurBehindAppBar: true,
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: [
              // ...existing pages go here...
            ],
          ),
          // Floating button to open edit toolbar without resizing scaffold
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _openEditToolbar,
              backgroundColor: Colors.black87,
              child: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      floatingNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'app_bar.statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'app_bar.dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'app_bar.settings',
          ),
        ],
      ),
    );
  }
}
