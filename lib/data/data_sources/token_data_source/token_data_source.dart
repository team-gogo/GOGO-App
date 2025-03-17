import '../../models/auth/google_oauth/google_oauth_login_response.dart';

abstract class TokenDataSource {
  Future<void> saveToken(GoogleOAuthLoginResponse token);
  Future<void> deleteToken();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}