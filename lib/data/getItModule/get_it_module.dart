import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/data_sources/login/auth_repository_impl.dart';

import '../data_sources/login/auth_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.baseURL.com',
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    ),
  );

  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator<Dio>()));
}
