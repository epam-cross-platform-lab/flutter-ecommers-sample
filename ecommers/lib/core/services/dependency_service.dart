import 'package:ecommers/core/services/navigation/navigation_service.dart';
import 'package:get_it/get_it.dart';

NavigationService get navigationService => GetIt.I.get<NavigationService>();

class DependencyService {
  static void registerDependencies() {
    GetIt serviceLocator = GetIt.instance;

    serviceLocator
        .registerLazySingleton<NavigationService>(() => NavigationService());
  }
}
