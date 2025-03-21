import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gogo_app/data/util/log_interceptor.dart';

import '../util/auth_token_interceptor.dart';
import '../util/token_refresh_interceptor.dart';

Dio settingDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  // 여러 인터셉터를 Dio에 추가
  dio.interceptors.add(AuthTokenInterceptor());
  dio.interceptors.add(GogoLogInterceptor());
  dio.interceptors.add(TokenRefreshInterceptor());

  return dio;
}
