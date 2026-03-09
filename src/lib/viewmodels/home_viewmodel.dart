import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routing/databases/database.dart';
import 'package:routing/services/settings_service.dart';
import 'package:routing/services/skin_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required AppDataBase db, required SettingsService settingsService}) {
    _skinService = SkinService(db: db);
    _settingsService = settingsService;
    _db = db;

    _skinsSubscription = _db.watchAllSkins().listen((skins) => _skinList = skins);
  }

  late final SkinService _skinService;
  late final SettingsService _settingsService;
  late final AppDataBase _db;
  late final StreamSubscription<List<Skin>> _skinsSubscription;

  bool _menuOpen = false;
  List<Skin> _skinList = [];

  bool get menuOpen => _menuOpen;
  Stream<List<Skin>> get skins => _db.watchAllSkins();

  void toggleMenu() {
    _menuOpen = !_menuOpen;
    notifyListeners();
  }

  void closeMenu() {
    _menuOpen = false;
    notifyListeners();
  }

  Future<void> importFiles() => _skinService.importFiles();
  Future<void> openWithOsu(List<Skin> skins) => _skinService.openWithOsu(skins, _settingsService.osuPath!);
  Future<void> openAllWithOsu() => _skinService.openWithOsu(_skinList, _settingsService.osuPath!);
  Future<void> deleteSkin(Skin skin) => _skinService.deleteSkin(skin);
  Future<void> downloadSkin(Skin skin) => _skinService.downloadSkin(skin);

  @override
  void dispose() {
    _skinsSubscription.cancel();
    super.dispose();
  }
}
