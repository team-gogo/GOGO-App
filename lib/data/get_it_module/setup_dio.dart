import 'package:dio/dio.dart';

Dio settingDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.baseURL.com',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );
  dio.interceptors.add(LogInterceptor());

  return dio;
}
