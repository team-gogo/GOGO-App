import 'package:dio/dio.dart';

import 'handle_dio_error.dart';

Future<T> executeHandleApiCall<T>(Future<T> Function() apiCall) async {
  try {
    print("1234${await T}");
    return await apiCall();
  } on DioException catch (e) {
    throw handleDioError(e);
  } catch (e) {
    throw Exception('실패: $e');
  }
}
