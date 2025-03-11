import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/api/search_school/search_school_api.dart';
import 'package:gogo_app/data/api/auth_api.dart';
import 'package:gogo_app/data/data_sources/auth/auth_data_source.dart';
import 'package:gogo_app/data/data_sources/auth/auth_data_source_impl.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source_impl.dart';
import 'package:gogo_app/data/data_sources/stage/stage_data_source.dart';
import 'package:gogo_app/data/data_sources/stage/stage_data_source_impl.dart';
import 'package:gogo_app/data/get_it_module/setup_dio.dart';
import 'package:gogo_app/data/api/auth/auth_api.dart';
import 'package:gogo_app/data/data_sources/auth/auth_data_source.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository_impl.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_bloc.dart';

import '../api/mini_game_api.dart';
import '../api/stage_api.dart';
import '../data_sources/ws/web_socket_data_source.dart';
import '../data_sources/ws/web_socket_data_sources_impl.dart';
import '../api/stage/stage_api.dart';
import '../repositories/stage/stage_repository.dart';
import '../repositories/stage/stage_repository_impl.dart';

final locator = GetIt.instance;

void setUpDio() {
  locator.registerLazySingleton<Dio>(() => setupDio());
}

void setupDataSourceLocator() {
  locator.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(locator<Dio>()));
  locator.registerLazySingleton<StageDataSource>(
      () => StageDataSourceImpl(locator<Dio>()));

  locator.registerFactory<WebSocketDataSource>(() => WebSocketDataSourceImpl());
}

void setupRepositoryLocator() {
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator<AuthDatasource>()));
  locator.registerLazySingleton<StageRepository>(
      () => StageRepositoryImpl(locator<StageDataSource>()));
  locator.registerLazySingleton<SearchSchoolRepository>(
      () => SearchSchoolRepositoryImpl(locator<SearchSchoolDataSource>()));
  locator.registerLazySingleton<SearchSchoolDataSource>(
      () => SearchSchoolDataSourceImpl(locator<Dio>()));
}

void setupApiLocator() {
  locator.registerLazySingleton<AuthApi>(() => AuthApi(locator<Dio>()));
  locator.registerLazySingleton<StageApi>(() => StageApi(locator<Dio>()));
  locator.registerLazySingleton<MiniGameApi>(() => MiniGameApi(locator<Dio>()));
  locator.registerLazySingleton<SearchSchoolApi>(
      () => SearchSchoolApi(locator<Dio>()));
}
