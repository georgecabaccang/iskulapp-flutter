import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';

mixin DeleteMixin<M extends BaseModel> on BaseRepository<M> {
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
    validateTableMapping(models.first);

    final executor = tx ?? database;
    final statement = _sqlDeleteStatement(ids.length);
    final results = await executor.execute(statement, ids);
    return results.map((result) => result['id'].toString()).toList();
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
}
