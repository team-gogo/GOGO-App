import 'package:json_annotation/json_annotation.dart';

part 'token_refresh_response.g.dart';

@JsonSerializable()
class TokenRefreshResponse {
  final String accessToken;
  final String refreshToken;

  TokenRefreshResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenRefreshResponseToJson(this);
}
