import 'dart:async';
import 'package:appthemes_v3/models/custom_background.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BackgroundService extends ChangeNotifier {
  static const String _storageKey = 'preferred_background_theme';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // current shown theme
  BackgroundTheme _currentBackgroundTheme = BackgroundTheme.green;
  CustomBackground get currentBackgroundTheme =>
      _currentBackgroundTheme.customBackground;

  // user preferred theme
  BackgroundTheme _preferredTheme = BackgroundTheme.turquoise;
  BackgroundTheme get preferredTheme => _preferredTheme;

  set preferredTheme(BackgroundTheme theme) {
    if (_preferredTheme == theme) return;
    _preferredTheme = theme;
    _currentBackgroundTheme = theme;
    _savePreferredTheme(theme);
    notifyListeners();
  }

  set restorePreferredTheme(bool value) {
    _currentBackgroundTheme = _preferredTheme;
    notifyListeners();
  }

  Future<void> _savePreferredTheme(BackgroundTheme theme) {
    return _storage.write(key: _storageKey, value: theme.index.toString());
  }

  // load preferred theme on startup
  Future<void> init() async {
    final String? storedValue = await _storage.read(key: _storageKey);
    final int? storedIndex = int.tryParse(storedValue ?? '');
    if (storedIndex != null) {
      _preferredTheme = BackgroundTheme.values[storedIndex];
    }
    _currentBackgroundTheme = _preferredTheme;
  }

  // miscellaneous
  void setErrorTheme() {
    _currentBackgroundTheme = BackgroundTheme.error;
    notifyListeners();
  }
}
