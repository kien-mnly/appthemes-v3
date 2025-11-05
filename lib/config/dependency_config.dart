import 'package:appthemes_v3/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance; // <-- Global GetIt instance

/// Setup All Dependencies
void setupDependencies() {
  _setupServices();
  _setupBackground();
}

void _setupBackground() {
  // register service and run async init
  locator.registerLazySingleton<BackgroundService>(() => BackgroundService());
}

/// Setup Service Dependencies
void _setupServices() {
  locator.registerLazySingleton<PageController>(() => PageController());
  locator.registerLazySingleton<RouteObserver<ModalRoute<void>>>(
    () => RouteObserver<ModalRoute<void>>(),
  );
}
