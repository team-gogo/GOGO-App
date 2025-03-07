import 'package:dio/dio.dart';

Dio setupDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.baseURL.com',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Request: ${options.method} ${options.uri}');
      print('Request Headers: ${options.headers}');
      print('Request Data: ${options.data}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Response: ${response.statusCode} ${response.requestOptions.uri}');
      print('Response Data: ${response.data}');
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      print('Error: ${e.response?.statusCode} ${e.requestOptions.uri}');
      print('Error Message: ${e.message}');
      return handler.next(e);
    },
  ));

  return dio;
}
