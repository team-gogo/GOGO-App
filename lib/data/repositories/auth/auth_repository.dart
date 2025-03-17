import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_response.dart';

import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';

abstract class AuthRepository {
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
      GoogleOAuthLoginRequest body);
  Future<void> additionalSignUp(AdditionalSignUpRequest body);
  Future<void> tokenRefresh(String refreshToken);
  Future<void> logOut();
}
