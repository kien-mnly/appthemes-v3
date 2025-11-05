import 'package:appthemes_v3/config/dependency_config.dart';

import 'app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  runApp(const App());
}
