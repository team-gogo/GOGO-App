import '../../models/auth/google_oauth/token_dto.dart';

abstract class TokenDataSource {
  Future<void> saveToken(TokenDto token);
  Future<void> deleteToken();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}