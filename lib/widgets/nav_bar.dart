// import 'package:flutter/material.dart';
// import 'package:appthemes_v3/config/theme/custom_background.dart';
// import 'custom_scaffold.dart';

// class NavBar extends StatefulWidget {
//   const NavBar({super.key});

//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int selectedIndex = 1;
//   int selectedThemeIndex = 0;

//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       _NavItemData(icon: Icons.pie_chart, label: 'Statistieken'),
//       _NavItemData(icon: Icons.home_filled, label: 'Dashboard'),
//       _NavItemData(icon: Icons.settings, label: 'Instellingen'),
//     ];

//     return CustomScaffold(
//       background: customBackgrounds[selectedThemeIndex],
//       extendBodyBehindAppBar: true,
//       blurBehindAppBar: true,
//       minBottomPadding: 0,
//       body: IndexedStack(index: selectedIndex),
//       floatingNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.35),
//                 blurRadius: 32,
//                 offset: const Offset(0, 18),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
//             child: Row(
//               children: [
//                 for (var i = 0; i < items.length; i++)
//                   Expanded(
//                     child: _NavItem(
//                       data: items[i],
//                       isSelected: selectedIndex == i,
//                       onTap: () => onItemTapped(i),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NavItemData {
//   const _NavItemData({required this.icon, required this.label});

//   final IconData icon;
//   final String label;
// }

// class _NavItem extends StatelessWidget {
//   const _NavItem({
//     required this.data,
//     required this.isSelected,
//     required this.onTap,
//   });

//   final _NavItemData data;
//   final bool isSelected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     const selectedColor = Color(0xFF94FF1F);
//     final inactiveColor = Colors.white.withOpacity(0.55);

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(24),
//         child: AnimatedOpacity(
//           opacity: isSelected ? 1 : 0.6,
//           duration: const Duration(milliseconds: 200),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: const EdgeInsets.symmetric(vertical: 6),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? selectedColor.withOpacity(0.12)
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   data.icon,
//                   color: isSelected ? selectedColor : inactiveColor,
//                   size: 28,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   data.label,
//                   style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                     color: isSelected ? selectedColor : inactiveColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
