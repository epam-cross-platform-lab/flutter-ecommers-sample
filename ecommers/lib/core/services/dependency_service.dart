import 'package:ecommers/core/common/file_manager.dart';
import 'package:ecommers/core/services/api_service.dart';
import 'package:ecommers/core/services/membership_service.dart';
import 'package:ecommers/core/services/navigation/navigation_service.dart';
import 'package:ecommers/web_server/request_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommers/core/services/extensions/get_it_extension.dart';

NavigationService get navigationService => GetIt.I.get<NavigationService>();
FileManager get fileManager => GetIt.I.get<FileManager>();
ApiService get apiService => GetIt.I.get<ApiService>();
MembershipService get membershipService => GetIt.I.get<MembershipService>();
RequestHandler get requestHandler => GetIt.I.get<RequestHandler>();

class DependencyService {
  static void registerDependencies() {
    final GetIt serviceLocator = GetIt.instance;

    serviceLocator
      ..registerLazySingleton<NavigationService>(() => NavigationService())
      ..registerLazySingleton<FileManager>(() => FileManager())
      ..registerLazySingleton<RequestHandler>(() => RequestHandler())
      ..registerLazySingleton<MembershipService>(
          () => MembershipService(const FlutterSecureStorage()))
      ..registerHttpClient();
  }
}
