import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/dtos/dto.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;

abstract class BaseCrudRepository<C extends CreateDTO, U extends UpdateDTO> {
  final Table table;
  final PowerSyncDatabase database;

  BaseCrudRepository({required this.table, PowerSyncDatabase? database})
      : database = database ?? ps.db;

  /// Converts a DTO to a map of database column names to values.
  ///
  /// Parameters:
  /// - [dto]: The create data transfer object containing the source values
  ///
  /// Returns:
  /// - A [Map<String, dynamic>] where:
  ///   - Keys are database column names (e.g., 'first_name', 'email', 'status')
  ///   - Values are the corresponding data to be stored in those columns
  Map<String, dynamic> toCreateMap(C dto);
  Map<String, dynamic> toUpdateMap(U dto);

  /// Parameters:
  /// - [dto]: The data transfer object containing the values to be inserted
  /// - [tx]: Optional transaction context. If provided, the insert will be executed
  ///         within this transaction. If null, uses the default database connection.
  ///
  /// Returns:
  /// - A [Future<ResultSet>] representing the result of the database operation
  Future<ResultSet> create(C dto, [SqliteWriteContext? tx]) async {
    final map = toCreateMap(dto);
    final statement = await _sqlCreateStatement(map);
    final values = map.values.toList();

    final executor = tx ?? database;
    return executor.execute(statement, values);
  }

  /// update on a given id
  Future<ResultSet> update(U dto, [SqliteWriteContext? tx]) async {
    assert(dto.id != null);

    final map = toUpdateMap(dto);
    map.removeWhere((key, value) => value == null);
    final executor = tx ?? database;
    final statement = await _sqlUpdateStatement(map);
    return executor.execute(statement, [...map.values, dto.id]);
  }

  Future<ResultSet> delete(List<String> ids, [SqliteWriteContext? tx]) async {
    assert(ids.isNotEmpty);

    final executor = tx ?? database;
    final statement = await _sqlDeleteStatement(ids.length);
    return executor.execute(statement, ids);
  }

  Future<List<ResultSet>> bulkCreate(List<C> dtos,
      [SqliteWriteContext? tx]) async {
    if (dtos.isEmpty) return [];

    if (tx != null) {
      return Future.wait(dtos.map((dto) => create(dto, tx)));
    } else {
      final results = await database.writeTransaction((tx) async {
        return Future.wait(dtos.map((dto) => create(dto, tx)));
      });

      return results;
    }
  }

  Future<ResultSet> createOrUpdate(
    U dto,
    List<String> conditionFields, [
    SqliteWriteContext? tx,
  ]) async {
    assert(conditionFields.isNotEmpty);

    final map = toUpdateMap(dto);
    _validateMapKeys(map);

    /// id should be valid
    assert(
      conditionFields.every(
        (field) => field == 'id' || map.containsKey(field),
      ),
    );

    map.removeWhere((key, value) => value == null);

    final executor = tx ?? database;

    final whereClause =
        conditionFields.map((field) => '$field = ?').join(' AND ');

    final conditionValues = conditionFields.map((field) {
      if (field == 'id') {
        return dto.id;
      }
      return map[field];
    }).toList();

    final String queryExisting = """
      SELECT id FROM ${table.name} WHERE $whereClause
    """;

    final existing = await executor.execute(queryExisting, conditionValues);

    if (existing.rows.isEmpty) {
      // Create new record with all fields in the map
      final statement = await _sqlCreateStatement(map);
      final values = map.values.toList();
      return executor.execute(statement, values);
    } else {
      final setClause = map.keys.map((key) => '$key = ?').join(', ');
      final String queryUpdate = """
        UPDATE ${table.name}
        SET $setClause${table.columns.any((column) => column.name == 'updated_at') ? ', updated_at = datetime(\'now\')' : ''}
        WHERE $whereClause
        RETURNING *
      """;
      return executor.execute(
        queryUpdate,
        [...map.values, ...conditionValues],
      );
    }
  }

  Future<String> _sqlCreateStatement(Map<String, dynamic> map) async {
    _validateMapKeys(map);

    final columns = ['id', ...map.keys];
    final placeholders = ['uuid()', ...List.filled(map.length, '?')];
    _addCreatedAtUpdatedAt(columns, placeholders);

    if (table.columns.any((column) => column.name == 'updated_at')) {
      columns.add('updated_at');
      placeholders.add('datetime(\'now\')');
    }

    final queryString = """
      INSERT INTO ${table.name} (${columns.join(', ')})
      VALUES (${placeholders.join(', ')})
      RETURNING *
    """;

    return queryString;
  }

  Future<String> _sqlUpdateStatement(Map<String, dynamic> map) async {
    _validateMapKeys(map);

    final setClause = map.keys.map((key) => '$key = ?').join(', ');
    final queryString = """
      UPDATE ${table.name}
      SET $setClause
      WHERE id = ?
      RETURNING *
    """;

    return queryString;
  }

  Future<String> _sqlDeleteStatement(int count) async {
    final placeholders = List.filled(count, '?').join(', ');
    final queryString = """
    DELETE FROM ${table.name}
    WHERE id IN ($placeholders)
    RETURNING *
  """;
    return queryString;
  }

  /// verify if all declared table fields are valid in the mapping
  /// Parameters:
  void _validateMapKeys(Map<String, dynamic> map) {
    final validColumns = table.columns.map((column) => column.name).toSet();
    final invalidKeys =
        map.keys.where((key) => key != 'id' && !validColumns.contains(key));

    if (invalidKeys.isNotEmpty) {
      throw ArgumentError('Invalid column name(s): ${invalidKeys.join(', ')}');
    }
  }

  void _addCreatedAtUpdatedAt(
      List<String> columns, List<dynamic> placeholders) {
    if (table.columns.any((column) => column.name == 'created_at')) {
      columns.add('created_at');
      placeholders.add('datetime(\'now\')');
    }
    if (table.columns.any((column) => column.name == 'updated_at')) {
      columns.add('updated_at');
      placeholders.add('datetime(\'now\')');
    }
  }
}
