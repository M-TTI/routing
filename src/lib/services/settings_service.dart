import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService._(this._preferences);
  
  final  SharedPreferences _preferences;

  static Future<SettingsService> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return SettingsService._(preferences);
  }

  // Osu executable path setting
  String? get osuPath => _preferences.getString('osu_path');
  Future<void> setOsuPath(String path) async {
    _preferences.setString('osu_path', path);
  }

  // Preferred Theme Mode that is stored as int: 0=system, 1=light, 2=dark
  ThemeMode get themeMode {
    final int index = _preferences.getInt('theme_mode') ?? 0;
    return ThemeMode.values[index];
  }
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _preferences.setInt('theme_mode', themeMode.index);
  }
}