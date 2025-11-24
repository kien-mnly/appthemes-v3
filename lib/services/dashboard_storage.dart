import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/dashboard_widget.dart';

// Service to handle storage of dashboard widgets of one dashboard
class DashboardStorage {
  static const _key = 'dashboard_state';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<List<DashboardWidget>> load() async {
    final content = await _storage.read(key: _key);
    if (content == null) return [];
    try {
      final list = (jsonDecode(content) as List)
          .cast<Map<String, dynamic>>()
          .map(DashboardWidget.fromJson)
          .toList();
      return list;
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<DashboardWidget> dashboardItems) async {
    final json = dashboardItems.map((item) => item.toJson()).toList();
    await _storage.write(key: _key, value: jsonEncode(json));
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}

// Service to handle storage of active dashboard state (selected theme index and active custom dashboard name)
class ActiveDashboardStorage {
  static const _key = 'dashboard_state_meta';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<ActiveDashboard> load() async {
    final content = await _storage.read(key: _key);
    if (content == null) return ActiveDashboard.defaultState();
    try {
      final map = jsonDecode(content) as Map<String, dynamic>;
      return ActiveDashboard.fromJson(map);
    } catch (_) {
      return ActiveDashboard.defaultState();
    }
  }

  Future<void> save(ActiveDashboard state) async {
    final json = state.toJson();
    await _storage.write(key: _key, value: jsonEncode(json));
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}

class ActiveDashboard {
  final int selectedThemeIndex;
  final String? activeCustomDashboardName;

  ActiveDashboard({
    required this.selectedThemeIndex,
    this.activeCustomDashboardName,
  });

  factory ActiveDashboard.defaultState() =>
      ActiveDashboard(selectedThemeIndex: 2);

  factory ActiveDashboard.fromJson(Map<String, dynamic> json) {
    return ActiveDashboard(
      selectedThemeIndex: json['selectedThemeIndex'] ?? 2,
      activeCustomDashboardName: json['activeCustomDashboardName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedThemeIndex': selectedThemeIndex,
      'activeCustomDashboardName': activeCustomDashboardName,
    };
  }
}
