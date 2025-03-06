import 'package:dio/dio.dart';

import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_request.dart';
import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_response.dart';
import 'package:gogo_app/data/util/handle_dio_error.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

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
