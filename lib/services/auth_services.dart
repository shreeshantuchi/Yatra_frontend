import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String loginUrl = "http://10.0.2.2:8000/api/user/login/";
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(Uri.parse(loginUrl),
          body: {"email": email, "password": password});
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("in");
        await storage.write(key: "jwt", value: response.body);
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return null;
  }
}


//"sam@example.com, "password": "12345678"