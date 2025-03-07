import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_response.dart';

abstract class AuthRepository {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(GoogleOAuthLoginRequest body);
}