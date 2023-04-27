class AuthenticationParameters {
  String accessToken;
  String tokenType;
  String refreshToken;

  AuthenticationParameters({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
  });
}
