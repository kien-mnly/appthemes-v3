import 'dart:convert';
import 'package:appthemes_v3/models/custom_dashboard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomDashboardStorage {
  static const _key = 'custom_dashboards';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<CustomDashboard>> loadAll() async {
    final content = await _storage.read(key: _key);
    if (content == null) return [];
    try {
      final list = (jsonDecode(content) as List)
          .cast<Map<String, dynamic>>()
          .map(CustomDashboard.fromJson)
          .toList();
      return list;
    } catch (_) {
      return [];
    }
  }

  Future<void> saveAll(List<CustomDashboard> dashboards) async {
    final json = dashboards.map((e) => e.toJson()).toList();
    await _storage.write(key: _key, value: jsonEncode(json));
  }

  Future<void> add(CustomDashboard dashboard) async {
    final current = await loadAll();
    final updated = [...current, dashboard];
    await saveAll(updated);
  }

  Future<void> delete(String id) async {
    final current = await loadAll();
    final updated = current.where((dashboard) => dashboard.name != id).toList();
    await saveAll(updated);
  }
}
