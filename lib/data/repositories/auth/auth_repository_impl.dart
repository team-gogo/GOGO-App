import 'package:firebase_auth/firebase_auth.dart';
import 'package:gogo_app/data/data_sources/token_data_source/token_data_source.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../data_sources/auth/auth_data_source.dart';
import '../../models/auth/google_oauth/token_dto.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  final TokenDataSource _tokenRepository;

  AuthRepositoryImpl(this._authDatasource, this._tokenRepository);

  @override
  Future<TokenDto> googleOAuthLogin(
      GoogleOAuthLoginRequest body) async {
    final TokenDto response = await _authDatasource.googleOAuthLogin(body);
    _tokenRepository.saveToken(response);
    return response;
  }

  @override
  Future<void> additionalSignUp(AdditionalSignUpRequest body) async {
    return await _authDatasource.additionalSignUp(body);
  }

  @override
  Future<TokenDto> tokenRefresh() async {
    final String? refreshToken = await _tokenRepository.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    } else {
      final TokenDto response = await _authDatasource.tokenRefresh(refreshToken);
      _tokenRepository.saveToken(response);
      return response;
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await _tokenRepository.deleteToken();
  }
}
