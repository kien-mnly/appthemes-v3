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
  BackgroundTheme get currentBackgroundTheme => _currentBackgroundTheme;

  set currentBackgroundTheme(BackgroundTheme theme) {
    if (_currentBackgroundTheme != theme) {
      _currentBackgroundTheme = theme;
      notifyListeners();
    }
  }

  // user preferred theme
  BackgroundTheme _preferredTheme = BackgroundTheme.turquoise;
  BackgroundTheme get preferredTheme => _preferredTheme;

  set preferredTheme(BackgroundTheme theme) {
    if (_preferredTheme == theme) return;
    _preferredTheme = theme;
    currentBackgroundTheme = theme;
    _savePreferredTheme(theme);
    notifyListeners();
  }

  Future<void> _savePreferredTheme(BackgroundTheme theme) {
    return _storage.write(key: _storageKey, value: theme.index.toString());
  }

  // stream for background changes
  Stream<CustomBackground> get stream => _controller.stream;
  CustomBackground get current => _currentBackgroundTheme.customBackground;

  final ValueNotifier<CustomBackground> _selected =
      ValueNotifier<CustomBackground>(
        BackgroundTheme.turquoise.customBackground,
      );
  ValueNotifier<CustomBackground> get selected => _selected;

  final StreamController<CustomBackground> _controller =
      StreamController<CustomBackground>.broadcast();

  Future<void> init() async {
    final String? storedValue = await _storage.read(key: _storageKey);
    final int? storedIndex = int.tryParse(storedValue ?? '');
    if (storedIndex != null &&
        storedIndex >= 0 &&
        storedIndex < BackgroundTheme.values.length) {
      _preferredTheme = BackgroundTheme.values[storedIndex];
    } else {
      _preferredTheme = _currentBackgroundTheme;
    }
    currentBackgroundTheme = _preferredTheme;
  }

  void errorTheme() {
    if (_currentBackgroundTheme == BackgroundTheme.error) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentBackgroundTheme == BackgroundTheme.error) return;
      currentBackgroundTheme = BackgroundTheme.error;
    });
  }

  Color get accentColor => current.accentColor;
}
