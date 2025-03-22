abstract class LoginState {}

class Init extends LoginState {}

class GoogleLoginFail extends LoginState {
  final String message;

  GoogleLoginFail({required this.message});
}

class GogoLoginFail extends LoginState {}

class GoogleLoginSuccess extends LoginState {}

class GogoLoginSuccess extends LoginState {}
