import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/data_sources/token_data_source/token_data_source.dart';
import 'package:gogo_app/data/models/auth/google_oauth/token_dto.dart';

class TokenDataSourceImpl implements TokenDataSource {
  final FlutterSecureStorage _storage =
      GetIt.instance.get<FlutterSecureStorage>();

  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static final String _authority = 'authority';

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    print("🔄 delete token");
  }

  @override
  Future<String?> getAccessToken() async {
    final String? accessToken = await _storage.read(key: _accessTokenKey);
    print("🔄 getAccessToken: $accessToken");
    return accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final String? refreshToken = await _storage.read(key: _refreshTokenKey);
    print("🔄 getRefreshToken: $refreshToken");
    return refreshToken;
  }

  @override
  Future<void> saveToken(TokenDto token) async {
    print("🔄 saveToken: ${token.accessToken} ${token.refreshToken}");
    await _storage.write(key: _accessTokenKey, value: token.accessToken);
    await _storage.write(key: _refreshTokenKey, value: token.refreshToken);
    if (token.authority != null || token.authority != '') {
      await _storage.write(key: _authority, value: token.authority);
    }
  }
}
