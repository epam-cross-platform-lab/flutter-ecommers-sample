
import 'package:ecommers/core/app_services/category_service.dart';
import 'package:ecommers/core/app_services/dialog/dialog_service.dart';
import 'package:ecommers/core/app_services/index.dart';
import 'package:ecommers/core/cache/index.dart';
import 'package:ecommers/core/common/file_manager.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/api_service.dart';
import 'package:ecommers/core/services/membership_service.dart';
import 'package:ecommers/core/services/navigation/navigation_service.dart';
import 'package:ecommers/core/repositories/index.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:ecommers/shared/i18n.dart';
import 'package:ecommers/shared/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'get_it_extension.dart';

final _ioc = GetIt.I;

NavigationService get navigationService => _ioc.get<NavigationService>();
FileManager get fileManager => _ioc.get<FileManager>();
ApiService get apiService => _ioc.get<ApiService>();
MembershipService get membershipService => _ioc.get<MembershipService>();
AuthorizationService get authorizationService =>
    _ioc.get<AuthorizationService>();
ProductService get productService => _ioc.get<ProductService>();
AppService get appService => _ioc.get<AppService>();
CategoryService get categoryService => _ioc.get<CategoryService>();
NoteService get noteService => _ioc.get<NoteService>();
CategoryDataRepository get categoryDataRepository =>
    _ioc.get<CategoryDataRepository>();
PaymentMethodService get paymentMethodService =>
    _ioc.get<PaymentMethodService>();
PaymentMethodRepository get paymentMethodRepository =>
    _ioc.get<PaymentMethodRepository>();
CacheDatabase get cacheDatabase => _ioc.get<CacheDatabase>();
CartRepository get cartRepository => _ioc.get<CartRepository>();
Paginator createPaginator() => _ioc.get<Paginator>();
DialogService get dialogService => _ioc.get<DialogService>();
ProfileService get profileService => _ioc.get<ProfileService>();
FirebaseAuthRepository get authRepository => _ioc.get<FirebaseAuthRepository>();
Logger get logger => _ioc.get<Logger>();
ShippingAddressService get shippingAddressService => _ioc.get<ShippingAddressService>();
ShippingAddressRepository get shippingAddressRepository => _ioc.get<ShippingAddressRepository>();
I18n get localization => I18n.of(Get.context);
TextTheme get textTheme => Theme.of(Get.context).textTheme;

class DependencyService {
  static void registerDependencies() {
    _ioc.reset();
    _ioc
      ..registerFactory(() => Paginator())
      ..registerLazySingleton(() => NavigationService())
      ..registerLazySingleton(() => FileManager())
      ..registerLazySingleton(() => DialogService())
      ..registerLazySingleton(() => AuthorizationService())
      ..registerLazySingleton(() => ProductService())
      ..registerLazySingleton(() => AppService())
      ..registerLazySingleton(() => Logger())
      ..registerLazySingleton(() => CategoryService())
      ..registerLazySingleton(() => PaymentMethodService())
      ..registerLazySingleton(() => ShippingAddressService())
      ..registerLazySingleton(() => NoteService())
      ..registerSingletonAsync(
        () async {
          final membershipService = MembershipService();
          await membershipService.initialize();
          return membershipService;
        },
      )
      ..registerHttpClient()
      ..registerLazySingleton(() => CartRepository())
      ..registerLazySingleton(() => FirebaseAuthRepository())
      ..registerLazySingleton(() => CategoryDataRepository())
      ..registerLazySingleton<PaymentMethodRepository>(
          () => PaymentMethodRepository())
      ..registerLazySingleton<ShippingAddressRepository>(
          () => ShippingAddressRepository())
      ..registerSingletonAsync<CacheDatabase>(
        () async {
          final cacheDatabase = CacheDatabase();
          await cacheDatabase.initializeDatabase();
          return cacheDatabase;
        },
      )
      ..registerSingletonAsync(
        () async {
          final profileService = ProfileService();
          await profileService.updateUserInfo();
          return profileService;
        },
      );
  }
}
