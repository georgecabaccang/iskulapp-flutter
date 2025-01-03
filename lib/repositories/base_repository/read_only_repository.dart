import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/features/powersync/db.dart' as ps;

abstract class ReadOnlyRepository<M> {
  final PowerSyncDatabase database;
  final String tableName;
  final M Function(sqlite.Row) fromRow;

  ReadOnlyRepository({
    required Table table,
    required this.fromRow,
    PowerSyncDatabase? database,
  })  : database = database ?? ps.db,
        tableName = table.name;
}
