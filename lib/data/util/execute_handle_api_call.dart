 import 'package:dio/dio.dart';

import 'handle_dio_error.dart';

Future<T> executeHandleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }