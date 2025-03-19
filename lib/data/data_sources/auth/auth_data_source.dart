import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_response.dart';

import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/token_refresh/token_refresh_response.dart';

abstract class AuthDatasource {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  );

  Future<void> additionalSignUp(
    AdditionalSignUpRequest body,
  );

  Future<TokenRefreshResponse> tokenRefresh();
}
