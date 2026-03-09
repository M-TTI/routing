import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Skins extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get author => text()();
  TextColumn get assetsPath => text()();
  RealColumn get size => real()();
}

@DriftDatabase(tables: [Skins])
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertSkin(SkinsCompanion skin) async {
    return into(skins)
        .insert(skin);
  }

  Stream<List<Skin>> watchAllSkins() {
    return select(skins).watch();
  }

  Future<void> updateSkinAssetsPath(int id, String assetsPath) async {
    await (update(skins)..where((s) => s.id.equals(id)))
        .write(SkinsCompanion(assetsPath: Value(assetsPath)));
  }

  Future<void> deleteSkinById(int id) async {
    await (delete(skins)..where((s) => s.id.equals(id)))
      .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final supportDir = await getApplicationSupportDirectory();

    final dbFile = File(p.join(supportDir.path, 'app_database.sqlite'));

    return NativeDatabase(dbFile);
  });
}