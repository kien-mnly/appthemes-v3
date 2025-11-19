import 'package:appthemes_v3/services/dashboard_storage_list.dart';
import 'package:flutter/foundation.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/custom_dashboard.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';
import 'package:appthemes_v3/models/theme_presets.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:appthemes_v3/utils/dashboard_utils.dart';

class DashboardController extends ChangeNotifier {
  DashboardController({
    required DashboardStorage storage,
    required DashboardStorageList storageList,
  }) : _storage = storage,
       _storageList = storageList;

  final DashboardStorage _storage;
  final DashboardStorageList _storageList;

  // --- State --- //

  final List<DashboardWidget> _dashboardItems = [];
  List<DashboardWidget> get dashboardItems =>
      List.unmodifiable(_dashboardItems);

  List<CustomDashboard> _customDashboards = [];
  List<CustomDashboard> get customDashboards =>
      List.unmodifiable(_customDashboards);

  String? _activeCustomDashboardName;
  String? get activeCustomDashboardName => _activeCustomDashboardName;

  /// Index of the currently selected preset theme.
  int _selectedThemeIndex = 2;
  int get selectedThemeIndex => _selectedThemeIndex;

  /// Whether the current dashboard exactly matches the selected preset.
  bool _isPreset = false;
  bool get isPreset => _isPreset;

  // --- Lifecycle --- //

  Future<void> load() async {
    final storedDashboard = await _storage.load();
    final storedCustomDashboards = await _storageList.loadAll();

    _dashboardItems
      ..clear()
      ..addAll(storedDashboard.where((cfg) => resolveItem(cfg.itemId) != null));
    _customDashboards = storedCustomDashboards;

    // Recompute preset flag after loading
    _isPreset = _isCurrentDashboardStillPreset();

    notifyListeners();
  }

  // --- Public mutations used by the view --- //

  void setSelectedThemeIndex(int index) {
    _selectedThemeIndex = index;
    // Changing theme alone may or may not affect preset-ness; recompute:
    _isPreset = _isCurrentDashboardStillPreset();
    notifyListeners();
  }

  void deleteItem(String itemId, {bool fromCustomDashboard = false}) {
    _dashboardItems.removeWhere((item) => item.itemId == itemId);
    _onDashboardChanged(fromCustomDashboard: fromCustomDashboard);
  }

  void reorder(int oldIndex, int newIndex, {bool fromCustomDashboard = false}) {
    final item = _dashboardItems.removeAt(oldIndex);
    _dashboardItems.insert(newIndex, item);
    _onDashboardChanged(fromCustomDashboard: fromCustomDashboard);
  }

  void addOrUpdateWidget(
    WidgetContent item,
    int selectedViewIndex, {
    bool fromCustomDashboard = false,
  }) {
    final newItemSize = item.supportedSizes[selectedViewIndex];

    final existingIndex = _dashboardItems.indexWhere(
      (current) => current.itemId == item.id,
    );

    if (existingIndex == -1) {
      final newConfig = DashboardWidget(itemId: item.id, size: newItemSize);
      _dashboardItems.add(newConfig);
    } else {
      final existing = _dashboardItems[existingIndex];
      final updatedConfig = DashboardWidget(
        itemId: existing.itemId,
        size: newItemSize,
      );
      _dashboardItems[existingIndex] = updatedConfig;
    }

    _onDashboardChanged(fromCustomDashboard: fromCustomDashboard);
  }

  /// Apply a preset dashboard layout for the current selectedThemeIndex.
  void applyCurrentPreset() {
    if (_selectedThemeIndex < 0 ||
        _selectedThemeIndex >= PresetList.presets.length) {
      return;
    }
    final preset = PresetList.presets[_selectedThemeIndex];
    final presetDashboard = PresetList.buildFromPreset(preset);
    _dashboardItems
      ..clear()
      ..addAll(presetDashboard);
    _isPreset = true;
    _activeCustomDashboardName = null;

    _saveDashboardOnly();
  }

  /// Called when a user picks an existing custom dashboard from the modal.
  void loadCustomDashboard(CustomDashboard dashboard) {
    _dashboardItems
      ..clear()
      ..addAll(dashboard.content);
    _isPreset = false;
    _activeCustomDashboardName = dashboard.name;

    _saveDashboardOnly();
  }

  Future<void> deleteCustomDashboard(CustomDashboard dashboard) async {
    await _storageList.delete(dashboard.name);
    final updatedDashboards = await _storageList.loadAll();
    _customDashboards = updatedDashboards;
    if (_activeCustomDashboardName == dashboard.name) {
      _activeCustomDashboardName = null;
    }
    notifyListeners();
  }

  /// Update the theme preset index and theme associated with the active custom dashboard.
  Future<void> updateActiveCustomDashboardTheme(int presetIndex) async {
    _selectedThemeIndex = presetIndex;

    if (_activeCustomDashboardName == null) {
      notifyListeners();
      return;
    }

    final idx = _customDashboards.indexWhere(
      (d) => d.name == _activeCustomDashboardName,
    );
    if (idx == -1) {
      notifyListeners();
      return;
    }

    final updated = CustomDashboard(
      name: _customDashboards[idx].name,
      content: _customDashboards[idx].content,
      theme: PresetList.presets[presetIndex].theme,
    );
    _customDashboards[idx] = updated;
    await _storageList.saveAll(_customDashboards);
    notifyListeners();
  }

  /// Rename the active custom dashboard.
  Future<void> renameActiveCustomDashboard(String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty || _activeCustomDashboardName == null) return;

    final idx = _customDashboards.indexWhere(
      (d) => d.name == _activeCustomDashboardName,
    );
    if (idx == -1) return;

    final updated = CustomDashboard(
      name: trimmed,
      content: _customDashboards[idx].content,
      theme: _customDashboards[idx].theme,
    );

    _customDashboards[idx] = updated;
    _activeCustomDashboardName = trimmed;
    await _storageList.saveAll(_customDashboards);
    notifyListeners();
  }

  /// Called when the user finalized naming a *new* custom dashboard.
  Future<void> saveNewCustomDashboard(String name) async {
    final customDashboard = CustomDashboard(
      name: name,
      content: List<DashboardWidget>.from(_dashboardItems),
      theme: PresetList.presets[_selectedThemeIndex].theme,
    );
    await _storageList.add(customDashboard);
    _customDashboards.add(customDashboard);
    _activeCustomDashboardName = name;
    _isPreset = false;
    notifyListeners();
  }

  // --- Helpers --- //

  WidgetContent? resolveItem(String itemId) {
    try {
      return WidgetType.values
          .firstWhere((t) => t.widgetItem.id == itemId)
          .widgetItem;
    } catch (_) {
      return null;
    }
  }

  bool _isCurrentDashboardStillPreset() {
    if (_selectedThemeIndex < 0 ||
        _selectedThemeIndex >= PresetList.presets.length) {
      return false;
    }
    final presetDashboard = PresetList.buildFromPreset(
      PresetList.presets[_selectedThemeIndex],
    );
    return dashboardEquals(_dashboardItems, presetDashboard);
  }

  Future<void> _onDashboardChanged({bool fromCustomDashboard = false}) async {
    await _storage.save(_dashboardItems);

    if (fromCustomDashboard && _activeCustomDashboardName != null) {
      final idx = _customDashboards.indexWhere(
        (d) => d.name == _activeCustomDashboardName,
      );
      if (idx != -1) {
        final updated = CustomDashboard(
          name: _customDashboards[idx].name,
          content: List<DashboardWidget>.from(_dashboardItems),
          theme: _customDashboards[idx].theme,
        );
        _customDashboards[idx] = updated;
        await _storageList.saveAll(_customDashboards);
      }
      _isPreset = false;
      notifyListeners();
      return;
    }

    if (_isCurrentDashboardStillPreset()) {
      _isPreset = true;
    } else {
      _isPreset = false;
    }

    notifyListeners();
  }

  Future<void> _saveDashboardOnly() async {
    await _storage.save(_dashboardItems);
    notifyListeners();
  }
}
