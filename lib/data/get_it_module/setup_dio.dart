import 'package:dio/dio.dart';

import '../util/auth_token_interceptor.dart';
import '../util/token_refresh_interceptor.dart';

Dio settingDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.baseURL.com',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );
  dio.interceptors.add(AuthTokenInterceptor());
  dio.interceptors.add(LogInterceptor());
  dio.interceptors.add(TokenRefreshInterceptor());

  return dio;
}
