import 'package:gogo_app/data/data_sources/login/auth_data_source.dart';
import 'package:gogo_app/data/models/login/googleOAuth/google_oauth_login_request.dart';
import 'package:gogo_app/data/models/login/googleOAuth/google_oauth_login_response.dart';
import 'auth_repository_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<GoogleOAuthLoginResponse> googleOAuthLogin(
      GoogleOAuthLoginRequest body) async {
    return await _authDatasource.googleOAuthLogin(body);
  }
}
