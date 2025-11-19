import 'package:appthemes_v3/services/background_service.dart';
import 'package:appthemes_v3/services/dashboard_controller.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:appthemes_v3/services/dashboard_storage_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance; // <-- Global GetIt instance

/// Setup All Dependencies
void setupDependencies() {
  _setupServices();
  _setupBackground();
  _setupDashboards();
}

void _setupBackground() {
  // register service and run async init
  locator.registerLazySingleton<BackgroundService>(() => BackgroundService());
}

void _setupDashboards() {
  locator.registerLazySingleton<DashboardStorageList>(
    () => DashboardStorageList(),
  );
  locator.registerLazySingleton<DashboardStorage>(() => DashboardStorage());
  locator.registerLazySingleton<DashboardController>(
    () => DashboardController(
      storage: locator<DashboardStorage>(),
      storageList: locator<DashboardStorageList>(),
    ),
  );
}

/// Setup Service Dependencies
void _setupServices() {
  locator.registerLazySingleton<PageController>(() => PageController());
  locator.registerLazySingleton<RouteObserver<ModalRoute<void>>>(
    () => RouteObserver<ModalRoute<void>>(),
  );
}
