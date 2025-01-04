import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/models/base_model/base_model.dart';

abstract class BaseRepository<M extends BaseModel> {
  final PowerSyncDatabase database;
  final List<String> tableColumns;
  final String tableName;
  final M Function(sqlite.Row) fromRow;
  // where fromRow is a constructor of model M, constructors cannot be inherited thus is declared here

  static final _validatedTableMappings = <Type, bool>{};

  BaseRepository({
    required Table table,
    required this.fromRow,
    PowerSyncDatabase? database,
  })  : database = database ?? ps.db,
        tableColumns = _getColumns(table),
        tableName = table.name;

  static List<String> _getColumns(Table table) {
    return table.columns.map((column) => column.name).toList();
  }

  void validateTableMapping(M model) {
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
