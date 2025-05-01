import 'package:dio/dio.dart';
import 'package:gogo_app/data/api/auth/auth_api.dart';
import 'package:gogo_app/data/models/auth/student/student_response.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_request.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:gogo_app/data/util/execute_handle_api_call.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/google_oauth/token_dto.dart';
import '../../models/auth/sign_in/login_response.dart';
import 'auth_data_source.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final AuthApi _authApi;

  AuthDatasourceImpl(Dio dio) : _authApi = AuthApi(dio);

  @override
  Future<LoginResponse> googleOAuthLogin(GoogleOAuthLoginRequest body) async {
    return await executeHandleApiCall(() => _authApi.googleOAuthLogin(body));
  }

  @override
  Future<TokenDto> additionalSignUp(AdditionalSignUpRequest body) async {
    return await executeHandleApiCall(() => _authApi.additionalSignUp(body));
  }

  @override
  Future<TokenDto> tokenRefresh(String refreshToken) async {
    return await executeHandleApiCall(
        () => _authApi.tokenRefresh("Bearer $refreshToken"));
  }

  @override
  Future<StudentResponse> searchStudent(String name) async {
    return await executeHandleApiCall(() => _authApi.searchStudent(name));
  }

  @override
  Future<void> updateUserInfo(UserInfoRequest body) async {
    return await executeHandleApiCall(() => _authApi.updateUserInfo(body));
  }

  @override
  Future<UserInfoResponse> getUserInfo() async {
    return await executeHandleApiCall(() => _authApi.getUserInfo());
  }
}
