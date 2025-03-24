import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/auth/auth_api.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import '../../models/auth/additional_sign_in/google_login_response.dart';
import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/google_oauth/token_dto.dart';
import 'auth_data_source.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final AuthApi _authApi;

  AuthDatasourceImpl(Dio dio) : _authApi = AuthApi(dio);

  @override
  Future<GoogleLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  ) async {
    return await executeHandleApiCall(() => _authApi.googleOAuthLogin(body));
  }

  @override
  Future<void> additionalSignUp(
    AdditionalSignUpRequest body,
  ) async {
    return await executeHandleApiCall(() => _authApi.additionalSignUp(body));
  }

  @override
  Future<TokenDto> tokenRefresh(String refreshToken) async {
    return await executeHandleApiCall(() => _authApi.tokenRefresh("Bearer $refreshToken"));
  }
}
