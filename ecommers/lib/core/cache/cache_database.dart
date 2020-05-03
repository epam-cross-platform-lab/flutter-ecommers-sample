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

  Future updateMap(String key, Map<String, dynamic> map) async {
    await _updateByFilter(key, map, null);
  }

  Future updateByEqualsFilter(
      String key, Map<String, dynamic> map, Map<String, dynamic> filter) async {
    final List<Filter> filters = [];
    filter.forEach((key, value) => filters.add(Filter.equals(key, value)));

    await _updateByFilter(key, map, Filter.and(filters));
  }

  Future<List<T>> getAll<T>(
      String key, T Function(Map<String, dynamic>) fromMap) async {
    final records = await _getByFilter(key, null);
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }

  Future<List<T>> getByEqualsFilter<T>(
      String key,
      T Function(Map<String, dynamic>) fromMap,
      Map<String, dynamic> filter) async {
    final List<Filter> filters = [];
    filter.forEach((key, value) => filters.add(Filter.equals(key, value)));

    final records = await _getByFilter(key, Filter.and(filters));
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }

  Future dropData(String key) async {
    final store = intMapStoreFactory.store(key);
    await store.drop(_database);
  }

  Future dropDataBase() async {
    final DatabaseFactory dbFactory = databaseFactoryIo;
    _database.close();
    dbFactory.deleteDatabase(await _getDbPath());
    _database = await dbFactory.openDatabase(await _getDbPath());
  }

  Future deleteDataByFilter(String key, Map<String, dynamic> filter) async {
    final store = intMapStoreFactory.store(key);

    final List<Filter> filters = [];
    filter.forEach((key, value) => filters.add(Filter.equals(key, value)));
    await store.delete(_database, finder: Finder(filter: Filter.and(filters)));
  }

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>> _getByFilter(
      String key, Filter filter) {
    final store = intMapStoreFactory.store(key);
    return store.find(_database, finder: Finder(filter: filter));
  }

  Future _updateByFilter(
      String key, Map<String, dynamic> map, Filter filter) async {
    final store = intMapStoreFactory.store(key);
    await store.update(_database, map, finder: Finder(filter: filter));
  }
}
