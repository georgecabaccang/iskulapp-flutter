import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';
import 'package:school_erp/repositories/base_repository/create_mixin.dart';
import 'package:school_erp/repositories/base_repository/delete_mixin.dart';
import 'package:school_erp/repositories/base_repository/update_mixin.dart';
import 'package:school_erp/repositories/base_repository/upsert_mixin.dart';

class BaseCrudRepository<M extends BaseModel> extends BaseRepository<M>
    with CreateMixin<M>, UpdateMixin<M>, DeleteMixin<M>, UpsertMixin<M> {
  BaseCrudRepository({
    required super.table,
    required super.fromRow,
    super.database,
  });
}
