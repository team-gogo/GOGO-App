import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_response.dart';
import 'package:gogo_app/data/api/auth_api.dart';
import 'auth_data_source.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final AuthApi _authApi;

  AuthDatasourceImpl(Dio dio) : _authApi = AuthApi(dio);

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
