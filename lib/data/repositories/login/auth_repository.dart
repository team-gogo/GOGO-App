import 'package:gogo_app/data/data_sources/login/auth_data_source.dart';
import '../../models/login/google_oauth/google_oauth_login_request.dart';
import '../../models/login/google_oauth/google_oauth_login_response.dart';
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
