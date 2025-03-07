import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/data_sources/login/auth_data_source_impl.dart';
import 'package:gogo_app/data/get_it_module/setup_dio.dart';
import 'package:gogo_app/data/repositories/login/auth_repository.dart';
import 'package:gogo_app/data/repositories/login/auth_repository_impl.dart';

import '../api/auth_api.dart';
import '../data_sources/login/auth_data_source.dart';

final locator = GetIt.instance;

void setUpDio() {
  locator.registerLazySingleton<Dio>(() => setupDio());
}

void setupDataSourceLocator() {
  locator.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(locator<Dio>()));
}

void setupRepositoryLocator() {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator<AuthDatasource>()));
}

void setupApiLocator() {
  locator.registerLazySingleton<AuthApi>(() => AuthApi(locator<Dio>()));
}