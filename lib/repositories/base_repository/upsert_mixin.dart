import 'package:powersync/sqlite_async.dart';
import 'package:school_erp/models/base_model/base_model.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';
import './create_mixin.dart';
import './update_mixin.dart';

mixin UpsertMixin<M extends BaseModel>
    on BaseRepository<M>, CreateMixin<M>, UpdateMixin<M> {
  /// Create or update a record, simplified for the moment since ps doesnt support the conflict statment
  /// [model] The model to upsert
  /// [tx] Optional transaction to execute within
  /// Returns the created or updated model
  Future<M> upsert(M model, {SqliteWriteContext? tx}) async {
    if (model.id == null) {
      return await create(model, tx: tx);
    } else {
      return await update(model, tx: tx);
    }
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
    validateTableMapping(models.first);

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
}
