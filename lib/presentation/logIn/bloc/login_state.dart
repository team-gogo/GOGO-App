import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class Init extends LoginState {}

class GoogleLoginFail extends LoginState {
  final String message;

  GoogleLoginFail({required this.message});
}

class GogoLoginFail extends LoginState {}

class GoogleLoginSuccess extends LoginState {
  final User user;

  GoogleLoginSuccess({required this.user});
}

class GogoLoginSuccess extends LoginState {}
