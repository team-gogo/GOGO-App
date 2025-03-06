class GoogleOAuthLoginRequest {
  final String oauthToken;
  final String? deviceToken;

  GoogleOAuthLoginRequest({
    required this.oauthToken,
    this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'oauthToken': oauthToken,
      'deviceToken': deviceToken,
    };
  }
}
