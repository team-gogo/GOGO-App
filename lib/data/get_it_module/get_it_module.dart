import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/api/auth/auth_api.dart';
import 'package:gogo_app/data/api/search_school/search_school_api.dart';
import 'package:gogo_app/data/data_sources/auth/auth_data_source.dart';
import 'package:gogo_app/data/data_sources/auth/auth_data_source_impl.dart';
import 'package:gogo_app/data/data_sources/mini_game/mini_game_data_source.dart';
import 'package:gogo_app/data/data_sources/mini_game/mini_game_data_source_impl.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source.dart';
import 'package:gogo_app/data/data_sources/search_school/search_school_data_source_impl.dart';
import 'package:gogo_app/data/data_sources/stage/stage_data_source.dart';
import 'package:gogo_app/data/data_sources/stage/stage_data_source_impl.dart';
import 'package:gogo_app/data/get_it_module/setup_dio.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository.dart';
import 'package:gogo_app/data/repositories/search_school/search_school_repository_impl.dart';
import 'package:gogo_app/data/api/stage/stage_api.dart';
import 'package:gogo_app/data/data_sources/ws/web_socket_data_source.dart';
import 'package:gogo_app/data/data_sources/ws/web_socket_data_sources_impl.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository.dart';
import 'package:gogo_app/data/repositories/stage/stage_repository_impl.dart';
import '../api/mini_game/mini_game_api.dart';
import '../data_sources/token_data_source/token_data_source.dart';
import '../data_sources/token_data_source/token_data_source_impl.dart';
import '../repositories/mini_game/mini_game_repository.dart';
import '../repositories/mini_game/mini_game_repository_impl.dart';

final locator = GetIt.instance;

void setUpDio() {
  locator.registerLazySingleton<Dio>(() => settingDio());
}

void setupDataSourceLocator() {
  locator.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(locator<Dio>()));
  locator.registerLazySingleton<StageDataSource>(
      () => StageDataSourceImpl(locator<Dio>()));
  locator.registerLazySingleton<MiniGameDataSource>(
      () => MiniGameDataSourceImpl(locator<Dio>()));
  locator.registerLazySingleton<SearchSchoolDataSource>(
      () => SearchSchoolDataSourceImpl(locator<Dio>()));
  locator.registerLazySingleton<TokenDataSource>(() => TokenDataSourceImpl());

  locator.registerFactory<WebSocketDataSource>(() => WebSocketDataSourceImpl());
}

void setupRepositoryLocator() {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      locator<AuthDatasource>(), locator<TokenDataSource>()));
  locator.registerLazySingleton<StageRepository>(
      () => StageRepositoryImpl(locator<StageDataSource>()));
  locator.registerLazySingleton<SearchSchoolRepository>(
      () => SearchSchoolRepositoryImpl(locator<SearchSchoolDataSource>()));
  locator.registerLazySingleton<MiniGameRepository>(
      () => MiniGameRepositoryImpl(locator<MiniGameDataSource>()));
}

void setupApiLocator() {
  locator.registerLazySingleton<AuthApi>(() => AuthApi(locator<Dio>()));
  locator.registerLazySingleton<StageApi>(() => StageApi(locator<Dio>()));
  locator.registerLazySingleton<MiniGameApi>(() => MiniGameApi(locator<Dio>()));
  locator.registerLazySingleton<SearchSchoolApi>(
      () => SearchSchoolApi(locator<Dio>()));
}
