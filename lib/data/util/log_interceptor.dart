import 'package:dio/dio.dart';
import 'dart:developer';
import 'dart:convert';

class GogoLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('--> ${options.method} ${options.uri}');
    log('Headers: ${options.headers}');
    if (options.data != null) {
      log('Request Data: ${jsonEncode(options.data)}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('<-- ${response.statusCode} ${response.requestOptions.uri}');
    log('Response Data: ${jsonEncode(response.data)}');
    return handler.next(response);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    log('!!! ERROR [${e.response?.statusCode ?? "No Response"}] ${e.requestOptions.uri}');
    log('DioError Type: ${e.type}');
    log('DioError Message: ${e.message}');

    if (e.response != null) {
      log('Response Status Code: ${e.response?.statusCode}');
      log('Response Headers: ${e.response?.headers}');
      if (e.response?.data != null) {
        log('Response Data: ${jsonEncode(e.response?.data)}');
      }
    } else {
      log('No Response from Server');
      if(e.error != null){
        log('Error: ${e.error}');
      }
    }

    log('StackTrace: ${e.stackTrace}');

    return handler.next(e);
  }
}