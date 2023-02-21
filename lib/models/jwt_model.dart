import 'package:flutter/cupertino.dart';

class JwtToken {
  String? accessToken;
  String? refreshToken;

  JwtToken toMap(Map<String, dynamic> mapData) {
    JwtToken jwtToken = JwtToken();
    print(mapData);

    jwtToken.accessToken = mapData["token"]["access"];

    jwtToken.refreshToken = mapData["token"]["refersh"];
    print(jwtToken.accessToken);

    return jwtToken;
  }
}
