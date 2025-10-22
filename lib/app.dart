import 'package:flutter/material.dart';
import 'views/start_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Template',
      debugShowCheckedModeBanner: false,
      home: StartView(),
    );
  }
}
