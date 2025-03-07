import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/auth_api.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_response.dart';
import 'auth_data_source.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final AuthApi _authApi;

  AuthDatasourceImpl(Dio dio) : _authApi = AuthApi(dio);

  @override
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  ) async {
    return await executeHandleApiCall(() => _authApi.googleOAuthLogin(body));
  }
}
