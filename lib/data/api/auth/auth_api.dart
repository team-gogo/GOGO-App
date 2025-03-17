import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../models/auth/google_oauth/token_dto.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/user/auth/login')
  Future<TokenDto> googleOAuthLogin(
    @Body() GoogleOAuthLoginRequest body,
  );

  @POST('/user/auth/signup')
  Future<void> additionalSignUp(@Body() AdditionalSignUpRequest body);

  @POST('/user/auth/refresh')
  Future<TokenDto> tokenRefresh(
    @Header('Refresh-Token') String refreshToken,
  );
}
