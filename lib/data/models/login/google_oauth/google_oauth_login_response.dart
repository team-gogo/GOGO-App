import 'package:json_annotation/json_annotation.dart';

part 'google_oauth_login_response.g.dart'; // 중요!

@JsonSerializable()
class GoogleOAuthLoginResponse {
  final String accessToken;
  final String refreshToken;

  GoogleOAuthLoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory GoogleOAuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOAuthLoginResponseToJson(this);
}
