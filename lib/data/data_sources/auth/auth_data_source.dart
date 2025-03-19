import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/google_oauth/token_dto.dart';

abstract class AuthDatasource {
  Future<TokenDto> googleOAuthLogin(
    GoogleOAuthLoginRequest body,
  );

  Future<void> additionalSignUp(
    AdditionalSignUpRequest body,
  );

  Future<TokenDto> tokenRefresh(String token);
}
