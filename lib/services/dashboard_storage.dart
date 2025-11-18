import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/dashboard_widget.dart';

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
