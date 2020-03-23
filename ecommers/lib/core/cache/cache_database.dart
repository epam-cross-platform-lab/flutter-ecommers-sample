import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class CacheDatabase {
  Completer<Database> _dbCompleter;

  Future<Database> get _db async {
    if (_dbCompleter == null) {
      _dbCompleter = Completer();

      await initializeDatabase();
    }

    return _dbCompleter.future;
  }

  Future initializeDatabase() async {
    final DatabaseFactory dbFactory = databaseFactoryIo;

    final database = await dbFactory.openDatabase(await _getDbPath());

    _dbCompleter.complete(database);
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
    await store.add(await _db, map);
  }

  Future<List<T>> getAll<T>(
      String key, T Function(Map<String, dynamic>) fromMap) async {
    final store = intMapStoreFactory.store(key);
    final records = await store.find(await _db);

    return records.map((snapshot) {
      return fromMap(snapshot.value);
    }).toList();
  }
}
