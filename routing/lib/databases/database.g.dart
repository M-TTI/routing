// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SkinsTable extends Skins with TableInfo<$SkinsTable, Skin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetsPathMeta = const VerificationMeta(
    'assetsPath',
  );
  @override
  late final GeneratedColumn<String> assetsPath = GeneratedColumn<String>(
    'assets_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<double> size = GeneratedColumn<double>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, author, assetsPath, size];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skins';
  @override
  VerificationContext validateIntegrity(
    Insertable<Skin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('assets_path')) {
      context.handle(
        _assetsPathMeta,
        assetsPath.isAcceptableOrUnknown(data['assets_path']!, _assetsPathMeta),
      );
    } else if (isInserting) {
      context.missing(_assetsPathMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Skin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Skin(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      assetsPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assets_path'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}size'],
      )!,
    );
  }

  @override
  $SkinsTable createAlias(String alias) {
    return $SkinsTable(attachedDatabase, alias);
  }
}

class Skin extends DataClass implements Insertable<Skin> {
  final int id;
  final String name;
  final String author;
  final String assetsPath;
  final double size;
  const Skin({
    required this.id,
    required this.name,
    required this.author,
    required this.assetsPath,
    required this.size,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['author'] = Variable<String>(author);
    map['assets_path'] = Variable<String>(assetsPath);
    map['size'] = Variable<double>(size);
    return map;
  }

  SkinsCompanion toCompanion(bool nullToAbsent) {
    return SkinsCompanion(
      id: Value(id),
      name: Value(name),
      author: Value(author),
      assetsPath: Value(assetsPath),
      size: Value(size),
    );
  }

  factory Skin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Skin(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      assetsPath: serializer.fromJson<String>(json['assetsPath']),
      size: serializer.fromJson<double>(json['size']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'assetsPath': serializer.toJson<String>(assetsPath),
      'size': serializer.toJson<double>(size),
    };
  }

  Skin copyWith({
    int? id,
    String? name,
    String? author,
    String? assetsPath,
    double? size,
  }) => Skin(
    id: id ?? this.id,
    name: name ?? this.name,
    author: author ?? this.author,
    assetsPath: assetsPath ?? this.assetsPath,
    size: size ?? this.size,
  );
  Skin copyWithCompanion(SkinsCompanion data) {
    return Skin(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      assetsPath: data.assetsPath.present
          ? data.assetsPath.value
          : this.assetsPath,
      size: data.size.present ? data.size.value : this.size,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Skin(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('assetsPath: $assetsPath, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, author, assetsPath, size);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Skin &&
          other.id == this.id &&
          other.name == this.name &&
          other.author == this.author &&
          other.assetsPath == this.assetsPath &&
          other.size == this.size);
}

class SkinsCompanion extends UpdateCompanion<Skin> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> author;
  final Value<String> assetsPath;
  final Value<double> size;
  const SkinsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.assetsPath = const Value.absent(),
    this.size = const Value.absent(),
  });
  SkinsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String author,
    required String assetsPath,
    required double size,
  }) : name = Value(name),
       author = Value(author),
       assetsPath = Value(assetsPath),
       size = Value(size);
  static Insertable<Skin> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? assetsPath,
    Expression<double>? size,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (assetsPath != null) 'assets_path': assetsPath,
      if (size != null) 'size': size,
    });
  }

  SkinsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? author,
    Value<String>? assetsPath,
    Value<double>? size,
  }) {
    return SkinsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      assetsPath: assetsPath ?? this.assetsPath,
      size: size ?? this.size,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (assetsPath.present) {
      map['assets_path'] = Variable<String>(assetsPath.value);
    }
    if (size.present) {
      map['size'] = Variable<double>(size.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkinsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('assetsPath: $assetsPath, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $SkinsTable skins = $SkinsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [skins];
}

typedef $$SkinsTableCreateCompanionBuilder =
    SkinsCompanion Function({
      Value<int> id,
      required String name,
      required String author,
      required String assetsPath,
      required double size,
    });
typedef $$SkinsTableUpdateCompanionBuilder =
    SkinsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> author,
      Value<String> assetsPath,
      Value<double> size,
    });

class $$SkinsTableFilterComposer extends Composer<_$AppDataBase, $SkinsTable> {
  $$SkinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetsPath => $composableBuilder(
    column: $table.assetsPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkinsTableOrderingComposer
    extends Composer<_$AppDataBase, $SkinsTable> {
  $$SkinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetsPath => $composableBuilder(
    column: $table.assetsPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkinsTableAnnotationComposer
    extends Composer<_$AppDataBase, $SkinsTable> {
  $$SkinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get assetsPath => $composableBuilder(
    column: $table.assetsPath,
    builder: (column) => column,
  );

  GeneratedColumn<double> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);
}

class $$SkinsTableTableManager
    extends
        RootTableManager<
          _$AppDataBase,
          $SkinsTable,
          Skin,
          $$SkinsTableFilterComposer,
          $$SkinsTableOrderingComposer,
          $$SkinsTableAnnotationComposer,
          $$SkinsTableCreateCompanionBuilder,
          $$SkinsTableUpdateCompanionBuilder,
          (Skin, BaseReferences<_$AppDataBase, $SkinsTable, Skin>),
          Skin,
          PrefetchHooks Function()
        > {
  $$SkinsTableTableManager(_$AppDataBase db, $SkinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> assetsPath = const Value.absent(),
                Value<double> size = const Value.absent(),
              }) => SkinsCompanion(
                id: id,
                name: name,
                author: author,
                assetsPath: assetsPath,
                size: size,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String author,
                required String assetsPath,
                required double size,
              }) => SkinsCompanion.insert(
                id: id,
                name: name,
                author: author,
                assetsPath: assetsPath,
                size: size,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDataBase,
      $SkinsTable,
      Skin,
      $$SkinsTableFilterComposer,
      $$SkinsTableOrderingComposer,
      $$SkinsTableAnnotationComposer,
      $$SkinsTableCreateCompanionBuilder,
      $$SkinsTableUpdateCompanionBuilder,
      (Skin, BaseReferences<_$AppDataBase, $SkinsTable, Skin>),
      Skin,
      PrefetchHooks Function()
    >;

class $AppDataBaseManager {
  final _$AppDataBase _db;
  $AppDataBaseManager(this._db);
  $$SkinsTableTableManager get skins =>
      $$SkinsTableTableManager(_db, _db.skins);
}
