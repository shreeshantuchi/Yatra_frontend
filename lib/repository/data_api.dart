import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:yatra/models/food_model.dart';

import 'package:http/http.dart' as http;

class DataApi extends ChangeNotifier {
  List<DataModel> foodList = [];
  List<DataModel> destinationList = [];
  DataApi();

  DataModel _foodModel = DataModel();
  DataModel _destinationModel = DataModel();
  String? _getUserId(String? jwtToken) {
    if (jwtToken != null) {
      String uid = JwtDecoder.decode(jwtToken)["user_id"].toString();
      return uid;
    }
    return null;
  }

  void getFoodList() async {
    foodList = [];

    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));

    String interestUrl = "http://10.0.2.2:8000/api/food/list/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      for (int i = 0; i < 5; i++) {
        _foodModel = _foodModel.toMap(data[i], "FOD");

        foodList.add(_foodModel);
      }
    }

    print("food model");
    print(foodList[0].name);
    notifyListeners();
  }

  void getDestinationList() async {
    destinationList = [];

    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));
    String interestUrl = "http://10.0.2.2:8000/api/destination/list/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < 5; i++) {
        _destinationModel = _destinationModel.toMap(data[i], "DES");

        destinationList.add(_destinationModel);
      }
    }

    print(destinationList);
    notifyListeners();
  }
}
