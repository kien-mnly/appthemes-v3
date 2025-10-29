import 'dart:async';

import './config/theme/custom_theme.dart';
import './views/start_view.dart';

import 'widgets/bottom_modal.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: MediaQuery.textScalerOf(
            context,
          ).clamp(minScaleFactor: 0.9, maxScaleFactor: 1.4),
        ),
        child: MaterialApp(
          title: 'Eva Power',
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: CustomTheme(context).themeData,
          home: Initializer(),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: child ?? Container(),
            );
          },
        ),
      ),
    );
  }
}

class Initializer extends StatefulWidget {
  const Initializer({super.key});

  @override
  State<Initializer> createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: StartView(),
    );
  }
}
