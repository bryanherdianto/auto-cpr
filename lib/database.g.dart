// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TestItemsTable extends TestItems
    with TableInfo<$TestItemsTable, TestItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, content, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TestItemsTable createAlias(String alias) {
    return $TestItemsTable(attachedDatabase, alias);
  }
}

class TestItem extends DataClass implements Insertable<TestItem> {
  final int id;
  final String content;
  final DateTime createdAt;
  const TestItem({
    required this.id,
    required this.content,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TestItemsCompanion toCompanion(bool nullToAbsent) {
    return TestItemsCompanion(
      id: Value(id),
      content: Value(content),
      createdAt: Value(createdAt),
    );
  }

  factory TestItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestItem(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TestItem copyWith({int? id, String? content, DateTime? createdAt}) =>
      TestItem(
        id: id ?? this.id,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );
  TestItem copyWithCompanion(TestItemsCompanion data) {
    return TestItem(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestItem(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestItem &&
          other.id == this.id &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class TestItemsCompanion extends UpdateCompanion<TestItem> {
  final Value<int> id;
  final Value<String> content;
  final Value<DateTime> createdAt;
  const TestItemsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TestItemsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.createdAt = const Value.absent(),
  }) : content = Value(content);
  static Insertable<TestItem> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TestItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<DateTime>? createdAt,
  }) {
    return TestItemsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestItemsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TestItemsTable testItems = $TestItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [testItems];
}

typedef $$TestItemsTableCreateCompanionBuilder =
    TestItemsCompanion Function({
      Value<int> id,
      required String content,
      Value<DateTime> createdAt,
    });
typedef $$TestItemsTableUpdateCompanionBuilder =
    TestItemsCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<DateTime> createdAt,
    });

class $$TestItemsTableFilterComposer
    extends Composer<_$AppDatabase, $TestItemsTable> {
  $$TestItemsTableFilterComposer({
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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TestItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TestItemsTable> {
  $$TestItemsTableOrderingComposer({
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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TestItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestItemsTable> {
  $$TestItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TestItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TestItemsTable,
          TestItem,
          $$TestItemsTableFilterComposer,
          $$TestItemsTableOrderingComposer,
          $$TestItemsTableAnnotationComposer,
          $$TestItemsTableCreateCompanionBuilder,
          $$TestItemsTableUpdateCompanionBuilder,
          (TestItem, BaseReferences<_$AppDatabase, $TestItemsTable, TestItem>),
          TestItem,
          PrefetchHooks Function()
        > {
  $$TestItemsTableTableManager(_$AppDatabase db, $TestItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TestItemsCompanion(
                id: id,
                content: content,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TestItemsCompanion.insert(
                id: id,
                content: content,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TestItemsTable, TestItem>(table),
                  BaseReferences<_$AppDatabase, $TestItemsTable, TestItem>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TestItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TestItemsTable,
      TestItem,
      $$TestItemsTableFilterComposer,
      $$TestItemsTableOrderingComposer,
      $$TestItemsTableAnnotationComposer,
      $$TestItemsTableCreateCompanionBuilder,
      $$TestItemsTableUpdateCompanionBuilder,
      (TestItem, BaseReferences<_$AppDatabase, $TestItemsTable, TestItem>),
      TestItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TestItemsTableTableManager get testItems =>
      $$TestItemsTableTableManager(_db, _db.testItems);
}
