import 'package:json_annotation/json_annotation.dart';

part 'google_oauth_login_request.g.dart'; // 중요!

@JsonSerializable()
class GoogleOAuthLoginRequest {
  final String oauthToken;
  final String? deviceToken;

  GoogleOAuthLoginRequest({
    required this.oauthToken,
    this.deviceToken,
  });

  factory GoogleOAuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleOAuthLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleOAuthLoginRequestToJson(this);
}
