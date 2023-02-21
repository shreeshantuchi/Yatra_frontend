import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yatra/models/jwt_model.dart';

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String loginUrl = "http://10.0.2.2:8000/api/user/login/";
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    var data;
    JwtToken jwtToken = JwtToken();
    try {
      var response = await http.post(Uri.parse(loginUrl),
          body: {"email": email, "password": password});
      print(response.statusCode);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        jwtToken = jwtToken.toMap(data);
        print(jwtToken.accessToken);
        await storage.write(key: "jwt", value: jwtToken.accessToken);
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return null;
  }

  String getUserId(String? jwtToken) {
    String uid = JwtDecoder.decode(jwtToken!)["user_id"].toString();
    return uid;
  }
}


//"sam@example.com, "password": "12345678"