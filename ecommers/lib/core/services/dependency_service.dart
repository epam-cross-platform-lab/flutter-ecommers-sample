import 'package:ecommers/core/repositories/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../app_services/index.dart';
import '../cache/index.dart';
import '../common/index.dart';
import '../services/extensions/get_it_extension.dart';
import '../services/index.dart';
import '../services/navigation/navigation_service.dart';


NavigationService get navigationService => GetIt.I.get<NavigationService>();
FileManager get fileManager => GetIt.I.get<FileManager>();
ApiService get apiService => GetIt.I.get<ApiService>();
MembershipService get membershipService => GetIt.I.get<MembershipService>();
AuthorizationService get authorizationService =>
    GetIt.I.get<AuthorizationService>();
ProductService get productService => GetIt.I.get<ProductService>();
CategoryService get categoryService => GetIt.I.get<CategoryService>();
NoteService get noteService => GetIt.I.get<NoteService>();
ProductDataRepository get productDataRepository => GetIt.I.get<ProductDataRepository>();
CategoryDataRepository get categoryDataRepository => GetIt.I.get<CategoryDataRepository>();
CacheDatabase get cacheDatabase => GetIt.I.get<CacheDatabase>();

class DependencyService {
  static void registerDependencies() {
    final GetIt serviceLocator = GetIt.instance;

    serviceLocator
      ..registerLazySingleton<NavigationService>(() => NavigationService())
      ..registerLazySingleton<FileManager>(() => FileManager())
      ..registerLazySingleton<AuthorizationService>(
          () => AuthorizationService())
      ..registerLazySingleton<ProductService>(() => ProductService())
      ..registerLazySingleton<CategoryService>(() => CategoryService())
      ..registerLazySingleton<NoteService>(() => NoteService())
      ..registerLazySingleton<MembershipService>(
          () => MembershipService(const FlutterSecureStorage()))
      ..registerHttpClient()
      ..registerLazySingleton<ProductDataRepository>(() => ProductDataRepository())
      ..registerLazySingleton<CategoryDataRepository>(() => CategoryDataRepository())
      ..registerSingletonAsync<CacheDatabase>(
        () async {
          final cacheDatabase = CacheDatabase();
          await cacheDatabase.initializeDatabase();
          return cacheDatabase;
        },
      );
  }
}
