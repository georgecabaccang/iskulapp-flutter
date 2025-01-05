import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';

mixin CreateMixin<M extends BaseModel> on BaseRepository<M> {
  /// Create a record
  /// [model] The model to create
  /// [tx] Optional transaction to execute within
  /// Returns the created model with generated id
  Future<M> create(M model, {SqliteWriteContext? tx}) async {
    if (model.id != null) {
      throw ArgumentError.value(
          model, 'invalid model', 'model to be created shouldnt have an id');
    }

    validateTableMapping(model);
    final tableData = model.tableData;
    final statement = _sqlCreateStatement(tableData);

    final values = tableData.entries
        .where((entry) => entry.key != 'id')
        .map((entry) => entry.value)
        .toList();

    final executor = tx ?? database;
    final results = await executor.execute(statement, values);

    if (results.isEmpty) {
      throw StateError(
        'Failed to create ${M.toString()}: No rows were inserted',
      );
    }

    return fromRow(results.first);
  }

  /// Create multiple records in a transaction
  /// [models] List of models to create
  /// [tx] Optional transaction to execute within
  /// Returns list of created models with generated ids
  Future<List<M>> bulkCreate(List<M> models, {SqliteWriteContext? tx}) async {
    if (models.isEmpty) {
      throw ArgumentError('model list cannot be empty');
    }
    validateTableMapping(models.first);

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

  String _sqlCreateStatement(Map<String, dynamic> tableData) {
    final columns = tableData.keys.toList();
    final placeholders =
        columns.map((column) => column == 'id' ? 'uuid()' : '?').toList();
    _addCreatedAt(columns, placeholders);
    _addUpdatedAt(columns, placeholders);

    return """
    INSERT INTO $tableName (${columns.join(', ')})
    VALUES (${placeholders.join(', ')})
    RETURNING *
    """;
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
}
