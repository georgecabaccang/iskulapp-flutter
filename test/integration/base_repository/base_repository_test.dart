import 'package:flutter_test/flutter_test.dart';
import 'test_model.dart';
import 'test_repository.dart';
import './test_base_repository_db.dart';
import './test_model_fixtures.dart' as fixtures;

//TODO tests for unhappy paths
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await openTestDatabase();
  var testModelRepository = TestModelRepository(database: testModelDB);

  setUp(() async {
    await testModelDB.execute('DELETE from test_models');
  });

  group('creating an item', () {
    test('successfully creates an item', () async {
      var initModel = fixtures.initialModel.copyWith();
      var createdModel = await testModelRepository.create(initModel);

      expect(createdModel, isNotNull);
      expect(createdModel.authorId, initModel.authorId);
      expect(createdModel.title, initModel.title);
      expect(createdModel.pages, createdModel.pages);

      // verify in database
      final fetchedSavedModel = await testModelDB.execute(
        'SELECT * FROM test_models WHERE id = ?',
        [createdModel.id],
      );

      expect(fetchedSavedModel.rows.length, equals(1));
      expect(fetchedSavedModel.first['created_at'], isNotNull);
      expect(fetchedSavedModel.first['updated_at'], isNotNull);
    });
  });

  group('updating an item', () {
    late TestModel createdModel;

    setUp(() async {
      var initModel = fixtures.initialModel.copyWith();
      createdModel = await testModelRepository.create(initModel);
      // insert delay to check if updated_at field gets updated
      await Future.delayed(const Duration(seconds: 1));
    });

    test('successfully updates an item', () async {
      var toBeUpdatedModel = createdModel.copyWith(
          title: 'updated title', authorId: '2', pages: 999);

      var updatedModel = await testModelRepository.update(toBeUpdatedModel);

      expect(updatedModel.id, createdModel.id);
      expect(updatedModel.authorId, toBeUpdatedModel.authorId);
      expect(updatedModel.title, toBeUpdatedModel.title);
      expect(updatedModel.pages, toBeUpdatedModel.pages);

      // verify in database
      final fetchedUpdatedModel = await testModelDB.execute(
        'SELECT * FROM test_models WHERE id = ?',
        [updatedModel.id],
      );

      expect(fetchedUpdatedModel.rows.length, equals(1));

      // verify updated at has been updated
      final updatedAt = DateTime.parse(fetchedUpdatedModel.first['updated_at']);
      final createdAt = DateTime.parse(fetchedUpdatedModel.first['created_at']);
      expect(updatedAt.isAfter(createdAt), isTrue);
    });
  });

  group('bulk create items', () {
    test('successfully create multiple items', () async {
      var item1 = fixtures.initialModel.copyWith();
      var item2 = item1.copyWith();
      var item3 = item1.copyWith();

      final createdModels =
          await testModelRepository.bulkCreate([item1, item2, item3]);

      for (final createdModel in createdModels) {
        expect(createdModel.id, isNotNull);
        expect(createdModel.authorId, fixtures.initialModel.authorId);
        expect(createdModel.title, fixtures.initialModel.title);
        expect(createdModel.pages, fixtures.initialModel.pages);
      }
    });
  });

  group('bulk update items', () {
    late List<TestModel> createdModels;

    setUp(() async {
      var item1 = fixtures.initialModel.copyWith();
      var item2 = item1.copyWith();
      var item3 = item1.copyWith();
      createdModels =
          await testModelRepository.bulkCreate([item1, item2, item3]);
      // insert delay to check if updated_at field gets updated
      await Future.delayed(const Duration(seconds: 1));
    });

    test('successfully update multiple items', () async {
      var toBeUpdatedModelUno = createdModels[0].copyWith(title: 'title 1');
      var toBeUpdatedModelDos = createdModels[1].copyWith(title: 'title 2');
      var toBeUpdatedModelTres = createdModels[2].copyWith(title: 'title 3');

      final updatedModels = await testModelRepository.bulkUpdate(
          [toBeUpdatedModelUno, toBeUpdatedModelDos, toBeUpdatedModelTres]);

      expect(updatedModels.length, equals(3));

      // Verify each updated model
      for (var i = 0; i < updatedModels.length; i++) {
        expect(updatedModels[i].id, createdModels[i].id);
        expect(updatedModels[i].title, 'title ${i + 1}');

        // Verify in database
        final fetchedModel = await testModelDB.execute(
            'SELECT * FROM test_models WHERE id = ?', [updatedModels[i].id]);
        expect(fetchedModel.rows.length, equals(1));
        expect(fetchedModel.first['title'], 'title ${i + 1}');

        // Verify updated_at is after created_at
        final updatedAt = DateTime.parse(fetchedModel.first['updated_at']);
        final createdAt = DateTime.parse(fetchedModel.first['created_at']);
        expect(updatedAt.isAfter(createdAt), isTrue);
      }
    });
  });

  group('deleting an item', () {
    late List<TestModel> createdModels;

    setUp(() async {
      var item1 = fixtures.initialModel.copyWith();
      var item2 = item1.copyWith();
      var item3 = item1.copyWith();

      createdModels =
          await testModelRepository.bulkCreate([item1, item2, item3]);
    });

    test('successfully delete multiple items', () async {
      var deletedIds = await testModelRepository.delete(createdModels);

      expect(deletedIds.length, createdModels.length);
      expect(createdModels.map((m) => (m.id)).toSet(), containsAll(deletedIds));

      final result = await testModelDB.execute("SELECT * FROM test_models");

      expect(result.length, 0);
    });
  });

  group('upsert an item', () {
    test('successfully inserts new item when it does not exist', () async {
      var initModel = fixtures.initialModel.copyWith();
      var upsertedModel = await testModelRepository.upsert(initModel);

      expect(upsertedModel, isNotNull);
      expect(upsertedModel.authorId, initModel.authorId);
      expect(upsertedModel.title, initModel.title);
      expect(upsertedModel.pages, initModel.pages);

      // verify in database
      final fetchedModel = await testModelDB.execute(
        'SELECT * FROM test_models WHERE id = ?',
        [upsertedModel.id],
      );

      expect(fetchedModel.rows.length, equals(1));
      expect(fetchedModel.first['created_at'], isNotNull);
      expect(fetchedModel.first['updated_at'], isNotNull);
    });

    test('successfully updates existing item', () async {
      // create an item
      var initModel = fixtures.initialModel.copyWith();
      var createdModel = await testModelRepository.create(initModel);

      await Future.delayed(const Duration(seconds: 1));

      // upsert with modified data
      var modifiedModel =
          createdModel.copyWith(title: 'updated via upsert', pages: 999);

      var upsertedModel = await testModelRepository.upsert(modifiedModel);

      expect(upsertedModel.id, createdModel.id);
      expect(upsertedModel.title, 'updated via upsert');
      expect(upsertedModel.pages, 999);

      // verify in database
      final fetchedModel = await testModelDB.execute(
        'SELECT * FROM test_models WHERE id = ?',
        [upsertedModel.id],
      );

      expect(fetchedModel.rows.length, equals(1));

      // verify updated_at has been updated
      final updatedAt = DateTime.parse(fetchedModel.first['updated_at']);
      final createdAt = DateTime.parse(fetchedModel.first['created_at']);
      expect(updatedAt.isAfter(createdAt), isTrue);
    });
  });

  group('bulk upsert items', () {
    test('successfully inserts multiple new items', () async {
      var item1 = fixtures.initialModel.copyWith(title: 'bulk item 1');
      var item2 = fixtures.initialModel.copyWith(title: 'bulk item 2');
      var item3 = fixtures.initialModel.copyWith(title: 'bulk item 3');

      final upsertedModels =
          await testModelRepository.bulkUpsert([item1, item2, item3]);

      expect(upsertedModels.length, equals(3));

      for (var i = 0; i < upsertedModels.length; i++) {
        expect(upsertedModels[i].id, isNotNull);
        expect(upsertedModels[i].title, 'bulk item ${i + 1}');

        // verify in database
        final fetchedModel = await testModelDB.execute(
          'SELECT * FROM test_models WHERE id = ?',
          [upsertedModels[i].id],
        );
        expect(fetchedModel.rows.length, equals(1));
      }
    });

    test('successfully updates existing items and inserts new ones', () async {
      // create some initial items
      var existingItem1 = fixtures.initialModel.copyWith(title: 'existing 1');
      var existingItem2 = fixtures.initialModel.copyWith(title: 'existing 2');

      final existingModels =
          await testModelRepository.bulkCreate([existingItem1, existingItem2]);

      await Future.delayed(const Duration(seconds: 1));

      // prepare modified versions of existing items and a new item
      var modifiedItem1 =
          existingModels[0].copyWith(title: 'modified 1', pages: 111);
      var modifiedItem2 =
          existingModels[1].copyWith(title: 'modified 2', pages: 222);
      var newItem = fixtures.initialModel.copyWith(title: 'new item');

      final upsertedModels = await testModelRepository
          .bulkUpsert([modifiedItem1, modifiedItem2, newItem]);

      expect(upsertedModels.length, equals(3));

      // verify modified items retained their IDs and got updated
      expect(upsertedModels[0].id, existingModels[0].id);
      expect(upsertedModels[0].title, 'modified 1');
      expect(upsertedModels[0].pages, 111);

      expect(upsertedModels[1].id, existingModels[1].id);
      expect(upsertedModels[1].title, 'modified 2');
      expect(upsertedModels[1].pages, 222);

      // verify new item was created
      expect(upsertedModels[2].title, 'new item');
      expect(upsertedModels[2].id, isNotNull);
      expect(upsertedModels[2].id, isNot(equals(existingModels[0].id)));
      expect(upsertedModels[2].id, isNot(equals(existingModels[1].id)));

      // verify in db
      for (final model in upsertedModels) {
        final fetchedModel = await testModelDB.execute(
          'SELECT * FROM test_models WHERE id = ?',
          [model.id],
        );
        expect(fetchedModel.rows.length, equals(1));

        if (model.id == existingModels[0].id ||
            model.id == existingModels[1].id) {
          // For updated records, verify updated_at is after created_at
          final updatedAt = DateTime.parse(fetchedModel.first['updated_at']);
          final createdAt = DateTime.parse(fetchedModel.first['created_at']);
          expect(updatedAt.isAfter(createdAt), isTrue);
        }
      }
    });
  });
}
