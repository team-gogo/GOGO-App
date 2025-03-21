import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:gogo_app/data/repositories/auth/auth_repository.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_event.dart';
import 'package:gogo_app/presentation/logIn/bloc/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gogo_app/data/models/auth/google_oauth/google_oauth_login_request.dart'
    show GoogleOAuthLoginRequest;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = GetIt.instance.get<AuthRepository>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(Init()) {
    on<GoogleLogInEvent>(_googleSignInHandler);
  }

  void _googleSignInHandler(LoginEvent event, Emitter<LoginState> emit) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(GoogleLoginFail(message: "구글 로그인을 취소 했습니다."));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      String? deviceToken = await getDeviceToken();
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        emit(GoogleLoginFail(message: "유저 정보를 가져오지 못했습니다."));
        return;
      }
      try {
            oauthToken: googleAuth.idToken ?? "",
        print('로그인 성공: ${token.accessToken}');
        emit(GogoLoginSuccess());
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          print('401: OAuth 계정이 존재하지 않음');
        } else if (e.response?.statusCode == 404) {
          print('404: 유저가 존재하지 않음');
        } else {
          print('기타 오류 발생: ${e.message}');
        }
        emit(GogoLoginFail());
      }
      await authRepository.googleOAuthLogin(
        GoogleOAuthLoginRequest(
          deviceToken: deviceToken,
        ),
      );

      emit(GoogleLoginSuccess(user: userCredential.user!));
    } catch (e) {
      emit(GoogleLoginFail(message: "구글 로그인에 실패 했습니다: $e"));
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print("사용자가 알림 권한을 거부했습니다.");
        return null;
      }

      String? token = await messaging.getToken();
      if (token == null) {
        print("FCM 토큰을 가져오지 못했습니다.");
      } else {
        print("FCM Token: $token");
      }

      return token;
    } catch (e) {
      print("FCM 토큰을 가져오는 중 오류 발생: $e");
      return null;
    }
  }
}
