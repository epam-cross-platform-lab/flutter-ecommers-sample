
import 'package:ecommers/core/app_services/category_service.dart';
import 'package:ecommers/core/app_services/index.dart';
import 'package:ecommers/core/cache/index.dart';
import 'package:ecommers/core/common/file_manager.dart';
import 'package:ecommers/core/services/api_service.dart';
import 'package:ecommers/core/services/membership_service.dart';
import 'package:ecommers/core/services/navigation/navigation_service.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/ui/pages/index.dart';
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
AppService get appService => GetIt.I.get<AppService>();
CategoryService get categoryService => GetIt.I.get<CategoryService>();
NoteService get noteService => GetIt.I.get<NoteService>();
PaymentMethodService get paymentMethodService => GetIt.I.get<PaymentMethodService>();
PaymentMethodRepository get paymentMethodRepository => GetIt.I.get<PaymentMethodRepository>();
CategoryDataRepository get categoryDataRepository => GetIt.I.get<CategoryDataRepository>();
CacheDatabase get cacheDatabase => GetIt.I.get<CacheDatabase>();
CartRepository get cartRepository => GetIt.I.get<CartRepository>();
Paginator get paginator => GetIt.I.get<Paginator>();
ShippingAddressService get shippingAddressService => GetIt.I.get<ShippingAddressService>();
ShippingAddressRepository get shippingAddressRepository => GetIt.I.get<ShippingAddressRepository>();

class DependencyService {
  static void registerDependencies() {
    final GetIt serviceLocator = GetIt.instance;

    serviceLocator
      ..registerFactory<Paginator>(() => Paginator())
      ..registerLazySingleton<NavigationService>(() => NavigationService())
      ..registerLazySingleton<FileManager>(() => FileManager())
      ..registerLazySingleton<AuthorizationService>(
          () => AuthorizationService())
      ..registerLazySingleton<ProductService>(() => ProductService())
      ..registerLazySingleton<AppService>(() => AppService())
      ..registerLazySingleton<CategoryService>(() => CategoryService())
      ..registerLazySingleton<PaymentMethodService>(() => PaymentMethodService())
      ..registerLazySingleton<ShippingAddressService>(() => ShippingAddressService())
      ..registerLazySingleton<NoteService>(() => NoteService())
      ..registerSingletonAsync<MembershipService>(
        () async {
          final membershipService = MembershipService();
          await membershipService.initialize();
          return membershipService;
        },
      )
      ..registerHttpClient()
      ..registerLazySingleton<CartRepository>(() => CartRepository())
      ..registerLazySingleton<PaymentMethodRepository>(() => PaymentMethodRepository()) 
      ..registerLazySingleton<ShippingAddressRepository>(() => ShippingAddressRepository())
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
