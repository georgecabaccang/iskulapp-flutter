import 'package:powersync/powersync.dart';
import './test_table.dart';

late final PowerSyncDatabase testModelDB;
bool _dbInitialized = false;

Future<void> openTestDatabase() async {
  if (!_dbInitialized) {
    testModelDB = PowerSyncDatabase(
      schema: testSchema,
      path: 'test_base_repository.db',
      logger: attachedLogger,
    );
    await testModelDB.initialize();
  }
}
