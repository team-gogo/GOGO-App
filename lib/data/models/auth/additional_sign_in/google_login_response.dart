import 'package:json_annotation/json_annotation.dart';

part 'google_login_response.g.dart';

enum Authority {
  UNAUTHENTICATED, // 인증되지 않은 사용자
  USER, // 일반 사용자
  STAFF, // 구매자, admin
  DEVELOPER, // 개발자
}

@JsonSerializable()
class GoogleLoginResponse {
  final String accessToken;
  final String refreshToken;
  final Authority authority;

  GoogleLoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.authority,
  });

  factory GoogleLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginResponseToJson(this);
}
