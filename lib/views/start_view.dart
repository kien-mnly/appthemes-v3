import 'package:appthemes_v3/config/theme/custom_background.dart';
import 'package:appthemes_v3/widgets/dashboard_background.dart';
import 'package:flutter/material.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isEditMode = false;

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start View')),
      body: Stack(
        children: [DashboardBackground(background: customBackgrounds[1])],
      ),
    );
  }
}
