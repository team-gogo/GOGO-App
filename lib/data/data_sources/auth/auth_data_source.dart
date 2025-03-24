import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/google_oauth/token_dto.dart';
import '../../models/auth/sign_in/google_login_response.dart';

abstract class AuthDatasource {
  Future<GogoLoginResponse> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  );

  Future<void> additionalSignUp(
    AdditionalSignUpRequest body,
  );

  Future<TokenDto> tokenRefresh(String token);
}
