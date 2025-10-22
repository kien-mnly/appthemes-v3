import 'dart:ui';

import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:flutter/material.dart';
import 'custom_scaffold.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 1;
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
      body: IndexedStack(index: selectedIndex, children: [
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
