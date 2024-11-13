import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/models/base_model/base_model.dart';

abstract class BaseCrudRepository<M extends BaseModel> {
  final PowerSyncDatabase database;
  final List<String> tableColumns;
  final String tableName;
  final M Function(sqlite.Row) fromRow;
  // where fromRow is a constructor of model M, constructors cannot be inherited thus is declared here

  static final _validatedTableMappings = <Type, bool>{};

  BaseCrudRepository({
    required Table table,
    required this.fromRow,
    PowerSyncDatabase? database,
  })  : database = database ?? ps.db,
        tableColumns = _getColumns(table),
        tableName = table.name;

  /// Create a record
  /// [model] The model to create
  /// [tx] Optional transaction to execute within
  /// Returns the created model with generated id
  Future<M> create(M model, {SqliteWriteContext? tx}) async {
    if (model.id != null) {
      throw ArgumentError.value(
          model, 'invalid model', 'model to be created shouldnt have an id');
    }

    _validateTableMapping(model);
    final tableData = model.tableData;
    final statement = _sqlCreateStatement(tableData);

    // Extract values excluding 'id' field since it uses uuid() in the create statement
    final values = tableData.entries
        .where((entry) => entry.key != 'id')
        .map((entry) => entry.value)
        .toList();

    final executor = tx ?? database;
    final results = await executor.execute(statement, values);
    return fromRow(results.first);
  }

  /// Update a record by id
  /// [model] The model to update (must have id)
  /// [tx] Optional transaction to execute within
  /// Returns the updated model
  Future<M> update(M model, {SqliteWriteContext? tx}) async {
    if (model.id == null) {
      throw ArgumentError.value(
          model, 'invalid model', 'model to be updated should have an id');
    }
    _validateTableMapping(model);

    final tableData = model.tableData;
    final statement = _sqlUpdateStatement(tableData);

    final executor = tx ?? database;
    final results =
        await executor.execute(statement, [...tableData.values, model.id]);
    return fromRow(results.first);
  }

  /// Delete records by ids
  /// [models] List of models to delete (must have id)
  /// [tx] Optional transaction to execute within
  /// Returns list of deleted record ids
  Future<List<String>> delete(List<M> models, {SqliteWriteContext? tx}) async {
    final ids = models
        .map((model) => model.id)
        .where(
          (id) => (id != null),
        )
        .toList();

    if (ids.isEmpty) {
      throw ArgumentError(
          'No valid models to delete: either empty list or all null models');
    }
    _validateTableMapping(models.first);

    final executor = tx ?? database;
    final statement = _sqlDeleteStatement(ids.length);
    final results = await executor.execute(statement, ids);
    return results.map((result) => result['id'].toString()).toList();
  }

  /// Create or update a record, simplified for the moment since ps doesnt support the conflict statment
  /// [model] The model to upsert
  /// [tx] Optional transaction to execute within
  /// Returns the created or updated model
  Future<M> upsert(M model, {SqliteWriteContext? tx}) async {
    if (model.id == null) {
      return await create(model, tx: tx);
    }
    return await update(model, tx: tx);
  }

  /// Create multiple records in a transaction
  /// [models] List of models to create
  /// [tx] Optional transaction to execute within
  /// Returns list of created models with generated ids
  Future<List<M>> bulkCreate(List<M> models, {SqliteWriteContext? tx}) async {
    if (models.isEmpty) {
      throw ArgumentError('model list cannot be empty');
    }
    _validateTableMapping(models.first);

    var results = <M>[];
    if (tx == null) {
      results = await database.writeTransaction((tx) async {
        return Future.wait(
          models.map(
            (model) => create(model, tx: tx),
          ),
        );
      });
    } else {
      results = await Future.wait(
        models.map(
          (model) => create(model, tx: tx),
        ),
      );
    }
    return results;
  }

  /// Update multiple records by id in a transaction
  /// [models] List of models to update (must have ids)
  /// [tx] Optional transaction to execute within
  /// Returns list of updated models
  Future<List<M>> bulkUpdate(List<M> models, {SqliteWriteContext? tx}) async {
    if (models.isEmpty) {
      throw ArgumentError('model list cannot be empty');
    }
    _validateTableMapping(models.first);

    var results = <M>[];
    if (tx == null) {
      results = await database.writeTransaction((tx) async {
        return Future.wait(
          models.map(
            (model) => update(model, tx: tx),
          ),
        );
      });
    } else {
      results = await Future.wait(
        models.map(
          (model) => update(model, tx: tx),
        ),
      );
    }
    return results;
  }

  /// Create or update multiple records in a transaction
  /// [models] List of models to upsert
  /// [uniqueBy] Column names to determine uniqueness, defaults to id
  /// [update] Column names to update on conflict
  /// [tx] Optional transaction to execute within
  /// Returns list of created or updated models
  Future<List<M>> bulkUpsert(List<M> models, {SqliteWriteContext? tx}) async {
    if (models.isEmpty) {
      throw ArgumentError('model list cannot be empty');
    }
    _validateTableMapping(models.first);

    var results = <M>[];
    if (tx == null) {
      results = await database.writeTransaction((tx) async {
        return Future.wait(
          models.map(
            (model) => upsert(model, tx: tx),
          ),
        );
      });
    } else {
      results = await Future.wait(
        models.map(
          (model) => upsert(model, tx: tx),
        ),
      );
    }

    return results;
  }

  String _sqlCreateStatement(Map<String, dynamic> tableData) {
    final columns = tableData.keys.toList();
    final placeholders =
        columns.map((column) => column == 'id' ? 'uuid()' : '?').toList();
    _addCreatedAt(columns, placeholders);
    _addUpdatedAt(columns, placeholders);

    final queryString = """
    INSERT INTO $tableName (${columns.join(', ')})
    VALUES (${placeholders.join(', ')})
    RETURNING *
    """;

    return queryString;
  }

  String _sqlUpdateStatement(Map<String, dynamic> tableData) {
    final setColumns = [...tableData.keys];
    var setClause = '';

    // add updated_at field if is present in table columns
    if (tableColumns.contains('updated_at')) {
      setColumns.add('updated_at');
    }

    for (var key in setColumns) {
      setClause +=
          key == 'updated_at' ? 'updated_at = datetime(\'now\')' : '$key = ?';
      if (key != setColumns.last) {
        setClause += ', ';
      }
    }

    final queryString = """
    UPDATE $tableName
    SET $setClause
    WHERE id = ?
    RETURNING *
    """;

    return queryString;
  }

  String _sqlDeleteStatement(int count) {
    final placeholders = List.filled(count, '?').join(', ');
    final queryString = """
    DELETE FROM $tableName
    WHERE id IN ($placeholders)
    RETURNING *
    """;
    return queryString;
  }

  String _sqlUpsertStatement(
    Map<String, dynamic> tableData,
    String? id, {
    List<String>? uniqueBy,
    List<String>? update,
  }) {
    // variables for insert statement
    print('this are the table keys');
    print(tableData.keys);
    final columns = tableData.keys.toList();
    final placeholders =
        columns.map((column) => column == 'id' ? 'uuid()' : '?').toList();

    _addCreatedAt(columns, placeholders);
    _addUpdatedAt(columns, placeholders);

    // variables for update statement
    final conflictColumns = uniqueBy ?? ['id'];
    final updateColumns = update ?? tableData.keys.toList();

    var updateClause =
        updateColumns.map((col) => '$col = EXCLUDED.$col').join(', ');

    if (tableColumns.contains('updated_at')) {
      updateClause += updateClause.isEmpty
          ? 'updated_at = datetime(\'now\')'
          : ', updated_at = datetime(\'now\')';
    }

    return """
    INSERT INTO $tableName (${columns.join(', ')})
    VALUES (${placeholders.join(', ')})
    ON CONFLICT (${conflictColumns.join(', ')})
    DO 
      UPDATE SET $updateClause
    RETURNING *
    """;
  }

  static List<String> _getColumns(Table table) {
    return table.columns.map((column) => column.name).toList();
  }

  void _addCreatedAt(List<String> columns, List<dynamic> placeholders) {
    if (tableColumns.contains('created_at')) {
      columns.add('created_at');
      placeholders.add('datetime(\'now\')');
    }
  }

  void _addUpdatedAt(List<String> columns, List<dynamic> placeholders) {
    if (tableColumns.contains('updated_at')) {
      columns.add('updated_at');
      placeholders.add('datetime(\'now\')');
    }
  }

  void _validateTableMapping(M model) {
    if (_validatedTableMappings[M] == true) {
      return;
    }

    var tableData = model.tableData;
    var tableFields = tableData.keys.toList();

    // check for duplicates
    if (tableFields.length != Set.of(tableFields).length) {
      throw StateError(
          'Duplicate field names found in table mapping for ${M.toString()}');
    }

    // check all fields exist in column names
    var invalidFields = tableFields
        .where((field) =>
            !tableColumns.contains(field) &&
            field != 'id') // powersync already has default id in column fields
        .toList();
    if (invalidFields.isNotEmpty) {
      throw StateError(
          'Invalid fields found in table mapping for ${M.toString()}: ${invalidFields.join(", ")}.\n'
          'Valid columns are: ${tableColumns.join(", ")}');
    }

    // cache validation result for this model type
    _validatedTableMappings[M] = true;
  }
}
