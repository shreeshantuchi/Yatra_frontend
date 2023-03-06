import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yatra/models/interest_model.dart';
import 'package:http/http.dart' as http;

class InterestAPi extends ChangeNotifier {
  InterestAPi();

  InterestModel _interestModel = InterestModel();
  Future<List<InterestModel>> getDestinationInterestList() async {
    List<InterestModel> destinationList = [];
    String interestUrl = "http://10.0.2.2:8000/api/interests/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        _interestModel = _interestModel.toMap(data[i]);

        if (_interestModel.type == "DES") {
          destinationList.add(_interestModel);
        }
      }
    }
    return destinationList;
  }

  Future<List<InterestModel>> getFoodInterestList() async {
    List<InterestModel> foodList = [];
    String interestUrl = "http://10.0.2.2:8000/api/interests/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        _interestModel = _interestModel.toMap(data[i]);

        if (_interestModel.type == "FOD") {
          foodList.add(_interestModel);
        }
      }
    }
    return foodList;
  }

  Future<List<InterestModel>> getActivitiesInterestList() async {
    List<InterestModel> activitiesList = [];
    String interestUrl = "http://10.0.2.2:8000/api/interests/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        _interestModel = _interestModel.toMap(data[i]);

        if (_interestModel.type == "ACT") {
          activitiesList.add(_interestModel);
        }
      }
    }
    return activitiesList;
  }

  String? _getUserId(String? jwtToken) {
    if (jwtToken != null) {
      String uid = JwtDecoder.decode(jwtToken)["user_id"].toString();
      return uid;
    }
    return null;
  }

  Future<void> updateInterest({required List<int> interestList}) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    String? uid;
    uid = _getUserId(await storage.read(key: "jwt"));
    final url = Uri.parse("http://10.0.2.2:8000/api/user/yatri/$uid/interest/");

    var response = await http.patch(url,
        body: jsonEncode(
          {
            "interests": interestList,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  Future<List<int>> getYatriInterestList() async {
    List<int> interestList = [];
    const FlutterSecureStorage storage = FlutterSecureStorage();

    String? uid;
    uid = _getUserId(await storage.read(key: "jwt"));
    final url =
        Uri.parse("http://10.0.2.2:8000/api/user/yatri/$uid/interest/list/");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        _interestModel = _interestModel.toMap(data[i]);

        interestList.add(_interestModel.id!);
      }
    }

    notifyListeners();
    return interestList;
  }
}
