import '../../models/login/google_oauth/google_oauth_login_request.dart';
import '../../models/login/google_oauth/google_oauth_login_response.dart';

abstract class AuthRepository {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(GoogleOAuthLoginRequest body);
}