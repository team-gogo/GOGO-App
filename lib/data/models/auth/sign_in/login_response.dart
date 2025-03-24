import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

enum Authority {
  UNAUTHENTICATED, // 인증되지 않은 사용자
  USER, // 일반 사용자
  STAFF, // 구매자, admin
  DEVELOPER, // 개발자
}

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final Authority authority;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.authority,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
