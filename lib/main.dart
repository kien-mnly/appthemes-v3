import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:appthemes_v3/services/background_service.dart';

import 'app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  locator<BackgroundService>().init();

  runApp(const App());
}
