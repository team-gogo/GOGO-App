import '../models/auth/additional_sign_in/google_login_response.dart';
import '../models/auth/google_oauth/token_dto.dart';

TokenDto toTokenDto(GoogleLoginResponse response) {
  return TokenDto(
    accessToken: response.accessToken,
    refreshToken: response.refreshToken,
  );
}