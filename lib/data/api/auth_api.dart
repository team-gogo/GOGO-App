import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/auth/token_refresh/token_refresh_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/user/auth/login')
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    @Body() GoogleOAuthLoginRequest body,
  );

  @POST('/user/auth/signup')
  Future<AdditionalSignUpResponse> additionalSignUp();

  @POST('/user/auth/refresh')
  Future<TokenRefreshResponse> tokenRefresh();
}
