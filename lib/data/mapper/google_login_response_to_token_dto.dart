import '../models/auth/google_oauth/token_dto.dart';
import '../models/auth/sign_in/login_response.dart';

TokenDto toTokenDto(LoginResponse response) {
  return TokenDto(
    accessToken: response.accessToken,
    refreshToken: response.refreshToken,
    authority: response.authority.toString(),
  );
}
