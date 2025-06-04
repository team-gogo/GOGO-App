abstract class LoginState {}

class Init extends LoginState {}

class AuthLoginFailure extends LoginState {
  final String message;

  AuthLoginFailure({required this.message});
}

class GogoLoginFail extends LoginState {}

class UserGogoLoginSuccess extends LoginState {}

class UnauthorizedGogoLoginSuccess extends LoginState {}

class AuthLoginSuccess extends LoginState {}
