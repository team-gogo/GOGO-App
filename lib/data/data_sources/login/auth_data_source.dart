import '../../models/login/googleOAuth/google_oauth_login_request.dart';
import '../../models/login/googleOAuth/google_oauth_login_response.dart';

abstract class AuthDatasource {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  );
}
