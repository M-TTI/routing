import 'package:flutter/material.dart';
import 'package:routing/services/settings_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._settings) {
    _themeMode = _settings.themeMode;
  }

  final SettingsService _settings;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  String? get osuPath => _settings.osuPath;
  bool get osuPathConfigured => osuPath != null && osuPath!.isNotEmpty;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _settings.setThemeMode(mode);
    notifyListeners();
  }

  Future<void> setOsuPath(String path) async {
    await _settings.setOsuPath(path);
    notifyListeners();
  }
}