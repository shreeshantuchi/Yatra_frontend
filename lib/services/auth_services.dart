import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yatra/models/jwt_model.dart';
import 'package:yatra/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  var userProfile = UserProfile();
  JwtToken jwtToken = JwtToken();
  String loginUrl = "http://10.0.2.2:8000/api/user/login/";
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    var data;

    try {
      var response = await http.post(Uri.parse(loginUrl),
          body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        jwtToken = jwtToken.toMap(data);

        await storage.write(key: "jwt", value: jwtToken.accessToken);
        return response.body;
      }
      return null;
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return null;
  }

  String _getUserId(String? jwtToken) {
    String uid = JwtDecoder.decode(jwtToken!)["user_id"].toString();
    return uid;
  }

  Future<UserProfile> getProfile() async {
    String uid;
    uid = _getUserId(await storage.read(key: "jwt"));
    UserProfile userProfile = UserProfile();
    String apiUrl = "http://10.0.2.2:8000/api/user/yatri/$uid/";

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      userProfile = userProfile.toMap(data);
      return userProfile;
    } else {
      print("error");
    }
    return userProfile;
  }

  Future<String?> registerUser(
      {String? email, String? password, String? repassword}) async {
    JwtToken jwtToken = JwtToken();
    // ignore: prefer_typing_uninitialized_variables
    var data;

    String apiUrl = "http://10.0.2.2:8000/api/user/register/";

    var response = await http.post(Uri.parse(apiUrl), body: {
      "email": email,
      "tc": "True",
      "name": "shreeshant",
      "password": password,
      "password2": repassword
    });

    if (response.statusCode == 201) {
      data = jsonDecode(response.body);

      jwtToken = jwtToken.toMap(data);
      await storage.write(key: "jwt", value: jwtToken.accessToken);
      return response.body;
    } else
      print("error");
    return null;
  }
}


//"sam@example.com, "password": "12345678"