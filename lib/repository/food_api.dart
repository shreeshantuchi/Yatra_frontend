import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:yatra/models/food_model.dart';

import 'package:http/http.dart' as http;

class DataApi extends ChangeNotifier {
  DataApi();

  DataModel _foodModel = DataModel();
  DataModel _destinationModel = DataModel();

  Future<List<DataModel>> getFoodList() async {
    List<DataModel> foodList = [];
    String interestUrl = "http://10.0.2.2:8000/api/food/list/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < 5; i++) {
        _foodModel = _foodModel.toMap(data[i], "FOD");

        foodList.add(_foodModel);
      }
    }

    print(foodList);
    return foodList;
  }

  Future<List<DataModel>> getDestinationList() async {
    List<DataModel> destinationList = [];
    String interestUrl = "http://10.0.2.2:8000/api/destination/list/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < 5; i++) {
        _destinationModel = _destinationModel.toMap(data[i], "DES");

        destinationList.add(_destinationModel);
      }
    }

    print(destinationList);
    return destinationList;
  }
}
