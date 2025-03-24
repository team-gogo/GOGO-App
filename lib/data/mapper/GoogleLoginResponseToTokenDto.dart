import '../models/auth/google_oauth/token_dto.dart';
import '../models/auth/sign_in/google_login_response.dart';

TokenDto toTokenDto(GogoLoginResponse response) {
  return TokenDto(
    accessToken: response.accessToken,
    refreshToken: response.refreshToken,
  );
}