import 'package:appthemes_v3/models/custom_dashboard.dart';
import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/theme_presets.dart';
import 'package:appthemes_v3/services/custom_dashboard_storage.dart';
import 'package:appthemes_v3/services/dashboard_storage.dart';
import 'package:appthemes_v3/utils/dashboard_utils.dart';

/// Encapsulates all non-UI dashboard logic: loading, saving, presets and customs.
class DashboardController {
  DashboardController({
    DashboardStorage? dashboardStorage,
    CustomDashboardStorage? customDashboardStorage,
  }) : _dashboardStorage = dashboardStorage ?? DashboardStorage(),
       _customDashboardStorage =
           customDashboardStorage ?? CustomDashboardStorage();

  final DashboardStorage _dashboardStorage;
  final CustomDashboardStorage _customDashboardStorage;

  final List<DashboardWidget> _items = [];
  final List<CustomDashboard> _customDashboards = [];

  /// Index of the currently selected preset theme.
  int selectedPresetIndex = 2;

  /// Name of the currently active custom dashboard, if any.
  String? activeCustomDashboardName;

  /// Whether the current dashboard layout still matches the selected preset.
  bool isPreset = false;

  List<DashboardWidget> get items => List.unmodifiable(_items);

  List<CustomDashboard> get customDashboards =>
      List.unmodifiable(_customDashboards);

  /// Loads the persisted dashboard and all custom dashboards.
  Future<void> loadInitial() async {
    final storedDashboard = await _dashboardStorage.load();
    final storedCustomDashboards = await _customDashboardStorage.loadAll();

    _items
      ..clear()
      ..addAll(storedDashboard);
    _customDashboards
      ..clear()
      ..addAll(storedCustomDashboards);

    // Determine if the loaded dashboard matches the current preset.
    isPreset = _isCurrentDashboardStillPreset();
  }

  /// Replaces the current items with [configs] and marks them as preset.
  Future<void> applyPresetDashboard(List<DashboardWidget> configs) async {
    _items
      ..clear()
      ..addAll(configs);
    isPreset = true;
    activeCustomDashboardName = null;
    await _dashboardStorage.save(_items);
  }

  /// Applies [configs] from an existing custom dashboard.
  Future<void> applyCustomDashboard({
    required String name,
    required List<DashboardWidget> configs,
  }) async {
    _items
      ..clear()
      ..addAll(configs);
    isPreset = false;
    activeCustomDashboardName = name;
    await _dashboardStorage.save(_items);
  }

  /// Persists the current dashboard items and updates the active custom
  /// dashboard if one is being edited.
  Future<void> persistDashboardChanges({
    bool fromCustomDashboard = false,
  }) async {
    await _dashboardStorage.save(_items);

    if (fromCustomDashboard && activeCustomDashboardName != null) {
      final index = _customDashboards.indexWhere(
        (dashboard) => dashboard.name == activeCustomDashboardName,
      );
      if (index != -1) {
        final updated = CustomDashboard(
          name: _customDashboards[index].name,
          dashboards: List<DashboardWidget>.from(_items),
          theme: _customDashboards[index].theme,
        );
        _customDashboards[index] = updated;
        await _customDashboardStorage.saveAll(_customDashboards);
      }
      return;
    }

    // When not editing an existing custom dashboard, callers can inspect
    // [isPreset] and decide whether to branch into preset->custom flow.
    isPreset = _isCurrentDashboardStillPreset();
  }

  /// Creates and stores a new custom dashboard with the current items and
  /// the theme of the currently selected preset.
  Future<CustomDashboard> createCustomDashboard(String name) async {
    final customDashboard = CustomDashboard(
      name: name,
      dashboards: List<DashboardWidget>.from(_items),
      theme: PresetList.presets[selectedPresetIndex].theme,
    );
    _customDashboards.add(customDashboard);
    activeCustomDashboardName = name;
    await _customDashboardStorage.add(customDashboard);
    return customDashboard;
  }

  /// Restores the current preset layout into [_items] and persists it.
  Future<void> restorePresetLayout() async {
    if (selectedPresetIndex < 0 ||
        selectedPresetIndex >= PresetList.presets.length) {
      return;
    }
    final preset = PresetList.presets[selectedPresetIndex];
    final presetDashboard = PresetList.buildFromPreset(preset);
    _items
      ..clear()
      ..addAll(presetDashboard);
    activeCustomDashboardName = null;
    isPreset = true;
    await _dashboardStorage.save(_items);
  }

  /// Deletes a custom dashboard and updates internal state.
  Future<void> deleteCustomDashboard(CustomDashboard dashboard) async {
    await _customDashboardStorage.delete(dashboard.name);
    final updatedDashboards = await _customDashboardStorage.loadAll();
    _customDashboards
      ..clear()
      ..addAll(updatedDashboards);
    if (activeCustomDashboardName == dashboard.name) {
      activeCustomDashboardName = null;
    }
  }

  /// Updates the theme of the active custom dashboard to the theme of the
  /// preset at [presetIndex].
  Future<void> updateActiveCustomDashboardTheme(int presetIndex) async {
    if (activeCustomDashboardName == null) return;
    final idx = _customDashboards.indexWhere(
      (dashboard) => dashboard.name == activeCustomDashboardName,
    );
    if (idx == -1) return;

    final updated = CustomDashboard(
      name: _customDashboards[idx].name,
      dashboards: _customDashboards[idx].dashboards,
      theme: PresetList.presets[presetIndex].theme,
    );
    _customDashboards[idx] = updated;
    await _customDashboardStorage.saveAll(_customDashboards);
  }

  /// Renames the active custom dashboard.
  Future<void> renameActiveCustomDashboard(String newName) async {
    final trimmed = newName.trim();
    if (trimmed.isEmpty || activeCustomDashboardName == null) {
      return;
    }

    final idx = _customDashboards.indexWhere(
      (dashboard) => dashboard.name == activeCustomDashboardName,
    );
    if (idx == -1) return;

    final updated = CustomDashboard(
      name: trimmed,
      dashboards: _customDashboards[idx].dashboards,
      theme: _customDashboards[idx].theme,
    );

    _customDashboards[idx] = updated;
    activeCustomDashboardName = trimmed;
    await _customDashboardStorage.saveAll(_customDashboards);
  }

  /// Sets the current items list. Intended to be used by the view when
  /// reordering or adding/removing widgets.
  void setItems(List<DashboardWidget> newItems) {
    _items
      ..clear()
      ..addAll(newItems);
  }

  bool _isCurrentDashboardStillPreset() {
    if (selectedPresetIndex < 0 ||
        selectedPresetIndex >= PresetList.presets.length) {
      return false;
    }
    final preset = PresetList.presets[selectedPresetIndex];
    final presetDashboard = PresetList.buildFromPreset(preset);
    return dashboardEquals(_items, presetDashboard);
  }
}
