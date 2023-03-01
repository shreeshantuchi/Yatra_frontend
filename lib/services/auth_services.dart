import 'dart:convert';
import 'dart:io';

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

  String? _getUserId(String? jwtToken) {
    if (jwtToken != null) {
      String uid = JwtDecoder.decode(jwtToken)["user_id"].toString();
      return uid;
    }
    return null;
  }

  Future<UserProfile> getProfile() async {
    String? uid;
    uid = _getUserId(await storage.read(key: "jwt"));
    if (uid != null) {
      UserProfile userProfile = UserProfile();
      String apiUrl = "http://10.0.2.2:8000/api/user/yatri/$uid/";

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userProfile = userProfile.toMap(data);
      } else {
        print("error");
      }

      return userProfile;
    }
    notifyListeners();
    return userProfile;
  }

  Future<void> updateUserProfile(
      {File? imageFile,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? country}) async {
    print(country);
    String? uid;
    uid = _getUserId(await storage.read(key: "jwt"));
    final url = Uri.parse("http://10.0.2.2:8000/api/user/yatri/$uid/");
    final request = http.MultipartRequest('PATCH', url);

    if (firstName != null) {
      request.fields['first_name'] = firstName;
    }
    if (lastName != null) {
      request.fields['last_name'] = lastName;
    }
    // // You
    if (phoneNumber != null) {
      request.fields['phone_no'] = phoneNumber;
    }
    // // You
    // if (country != null) {
    //   request.fields['country'] = country.toString();
    // }

    if (imageFile != null) {
      print("hello" + imageFile.toString());
      request.files.add(
          await http.MultipartFile.fromPath('profile_image', imageFile.path));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print(response);
    }
    notifyListeners();
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