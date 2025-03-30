import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../models/auth/additional_sign_up/additional_sign_up_response.dart';
import '../../models/auth/google_oauth/token_dto.dart';
import '../../models/auth/sign_in/login_response.dart';
import '../../models/auth/student/student_response.dart';
import '../../models/auth/user_info/user_info_request.dart';
import '../../models/auth/user_info/user_info_response.dart';

abstract class AuthDatasource {
  Future<LoginResponse> googleOAuthLogin(GoogleOAuthLoginRequest body);

  Future<TokenDto> additionalSignUp(AdditionalSignUpRequest body);

  Future<TokenDto> tokenRefresh(String token);

  Future<List<Student>> searchStudent(String name);

  Future<void> updateUserInfo(UserInfoRequest body);

  Future<UserInfoResponse> getUserInfo();
}
