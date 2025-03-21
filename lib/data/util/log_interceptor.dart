import 'package:dio/dio.dart';
import 'dart:developer';
import 'dart:convert';

class GogoLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('--> ${options.method} ${options.uri}');
    log('Headers: ${options.headers}');
    if (options.data != null) {
      log('Data: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('<-- ${response.statusCode} ${response.requestOptions.uri}');
    log('Data: ${response.data}');
    return handler.next(response);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    log('!!! ERROR [${e.response?.statusCode}] ${e.requestOptions.uri}');
    log('Message: ${e.message}');
    return handler.next(e);
  }
}