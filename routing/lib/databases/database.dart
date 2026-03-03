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

  Future<List<Skin>> findAllSkins() async {
    return select(skins)
        .get();
  }

  Future<Skin?> findSkinById(int id) async {
    return (select(skins)..where((s) => s.id.equals(id)))
        .getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docFolder = await getApplicationDocumentsDirectory();
    final dbFolder = await Directory(p.join(docFolder.path, 'routing')).create();

    final dbFile = File(p.join(dbFolder.path, 'app_database.sqlite'));

    return NativeDatabase(dbFile);
  });
}