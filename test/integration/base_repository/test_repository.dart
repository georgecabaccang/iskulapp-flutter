import 'package:powersync/powersync.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'test_model.dart';
import 'test_table.dart';

class TestModelRepository extends BaseCrudRepository<TestModel> {
  TestModelRepository({required PowerSyncDatabase database})
      : super(
            table: testModelsTable,
            database: database,
            fromRow: TestModel.fromRow);
}
