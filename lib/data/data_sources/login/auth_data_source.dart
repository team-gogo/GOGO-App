import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/login/google_oauth/google_oauth_login_response.dart';

abstract class AuthDatasource {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  );
}
