import 'package:dio/dio.dart';

import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_request.dart';
import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_response.dart';
import 'package:gogo_app/data/util/handle_dio_error.dart';

import 'auth_data_source.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio;

  AuthDatasourceImpl(this._dio);

  @override
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  ) async {
    try {
      final response = await _dio.post('auth/login', data: {body.toJson()});

      return GoogleOAuthLoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }
}
