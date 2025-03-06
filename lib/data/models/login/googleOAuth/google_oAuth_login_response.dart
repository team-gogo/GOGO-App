class GoogleOAuthLoginResponse {
  final String accessToken;
  final String refreshToken;

  GoogleOAuthLoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory GoogleOAuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return GoogleOAuthLoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
