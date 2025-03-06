import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_request.dart';
import 'package:gogo_app/data/models/login/googleOAuth/google_oAuth_login_response.dart';

abstract class AuthRepository {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(GoogleOAuthLoginRequest body);
}