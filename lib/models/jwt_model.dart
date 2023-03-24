class JwtToken {
  String? accessToken;
  String? refreshToken;

  JwtToken toMap(Map<String, dynamic> mapData) {
    JwtToken jwtToken = JwtToken();

    jwtToken.accessToken = mapData["token"]["access"];

    jwtToken.refreshToken = mapData["token"]["refersh"];

    return jwtToken;
  }
}
