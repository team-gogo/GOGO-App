import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    @Body() GoogleOAuthLoginRequest body,
  );
}
