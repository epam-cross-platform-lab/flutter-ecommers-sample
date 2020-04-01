import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class CacheDatabase {
  Database _database;

  Future initializeDatabase() async {
    final DatabaseFactory dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(await _getDbPath());
  }

  Future<String> _getDbPath() async {
    const _dbName = 'cache_database.db';

    final dbDirectory = await getApplicationDocumentsDirectory();
    if (!dbDirectory.existsSync()) {
      await dbDirectory.create(recursive: true);
    }

    return join(dbDirectory.path, _dbName);
  }

  Future saveMap(String key, Map<String, dynamic> map) async {
    final store = intMapStoreFactory.store(key);
    await store.add(_database, map);
  }

  Future<List<T>> getAll<T>(
      String key, T Function(Map<String, dynamic>) fromMap) async {
    final records = await _getByFilter(key, null);
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }

  Future<List<T>> getByEqualsFilter<T>(
      String key,
      T Function(Map<String, dynamic>) fromMap,
      String filterField,
      String filterValue) async {
    final records =
        await _getByFilter(key, Filter.equals(filterField, filterValue));
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>> _getByFilter(
      String key, Filter filter) {
    final store = intMapStoreFactory.store(key);

    return store.find(_database, finder: Finder(filter: filter));
  }
}
