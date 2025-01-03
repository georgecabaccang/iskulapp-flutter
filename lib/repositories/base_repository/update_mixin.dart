import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';

mixin UpdateMixin<M extends BaseModel> on BaseRepository<M> {
  /// Update a record by id
  /// [model] The model to update (must have id)
  /// [tx] Optional transaction to execute within
  /// Returns the updated model
  Future<M> update(M model, {SqliteWriteContext? tx}) async {
    if (model.id == null) {
      throw ArgumentError.value(
          model, 'invalid model', 'model to be updated should have an id');
    }
    validateTableMapping(model);

    final tableData = model.tableData;
    final statement = _sqlUpdateStatement(tableData);

    final executor = tx ?? database;
    final results =
        await executor.execute(statement, [...tableData.values, model.id]);

    if (results.isEmpty) {
      throw StateError(
          'Failed to update ${model.runtimeType} with ID ${model.id}: record not found in database');
    }

    return fromRow(results.first);
  }

  /// Update multiple records by id in a transaction
  /// [models] List of models to update (must have ids)
  /// [tx] Optional transaction to execute within
  /// Returns list of updated models
  Future<List<M>> bulkUpdate(List<M> models, {SqliteWriteContext? tx}) async {
    if (models.isEmpty) {
      throw ArgumentError('model list cannot be empty');
    }
    validateTableMapping(models.first);

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
}
