import 'package:dio/dio.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_request.dart';
import 'package:gogo_app/data/models/auth/user_info/user_info_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:gogo_app/data/models/auth/additional_sign_up/additional_sign_up_response.dart';
import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart';

import '../../models/auth/google_oauth/token_dto.dart';
import '../../models/auth/sign_in/login_response.dart';
import '../../models/auth/student/student_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  // 로그인 ✅
  @POST('/user/auth/login')
  Future<LoginResponse> googleOAuthLogin(
    @Body() GoogleOAuthLoginRequest body,
  );

  // 회원가입 ✅
  @POST('/user/auth/signup')
  Future<void> additionalSignUp(
    @Body() AdditionalSignUpRequest body,
  );

  // 토큰 리프레쉬 ✅
  @POST('/user/auth/refresh')
  Future<TokenDto> tokenRefresh(
    @Header('Refresh-Token') String refreshToken,
  );

  // 유저 검색 ✅
  @GET('/user/student/search')
  Future<List<Student>> searchStudent(
    @Query('name') String name,
  );

  // 본인 정보 수정 ✅
  @PATCH('/user/student/me')
  Future<void> updateUserInfo(
    @Body() UserInfoRequest body,
  );

  // 본인 정보 확인 ✅
  @GET('/user/student/me')
  Future<UserInfoResponse> getUserInfo();
}
