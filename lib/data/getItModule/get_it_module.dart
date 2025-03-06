import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/data_sources/login/auth_data_source_impl.dart';
import 'package:gogo_app/data/repositories/login/auth_repository.dart';
import 'package:gogo_app/data/repositories/login/auth_repository_impl.dart';

import '../data_sources/login/auth_data_source.dart';

final locator = GetIt.instance;

void setupDataSourceLocator() {
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.baseURL.com',
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    ),
  );

  locator.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(locator<Dio>()));
}

void setupRepositoryLocator() {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator<AuthDatasource>()));
}
