import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';

import 'package:yatra/models/food_model.dart';

import 'package:http/http.dart' as http;

class DataApi extends ChangeNotifier {
  List<DataModel> foodList = [];
  List<DataModel> destinationList = [];
  List<DataModel> foodListPopular = [];
  List<DataModel> destinationListPopular = [];
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

  void getDestinationListPopular(BuildContext context) async {
    destinationListPopular = [];

    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));

    String interestUrl = "http://10.0.2.2:8000/api/destination/popular/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _destinationModel = _destinationModel.toMap(data[i], "DES");
        destinationListPopular.add(_destinationModel);

        // context.read<ProviderMaps>().addMarker2(
        //     LatLng(double.parse(_foodModel.latitude!),
        //         double.parse(_foodModel.longitude!)),
        //     _foodModel.imageUrls!.isEmpty
        //         ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
        //         : _foodModel.imageUrls![0]["image"]);
      }
    }

    notifyListeners();
  }

  void getFoodListPopular(BuildContext context) async {
    foodListPopular = [];

    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));

    String interestUrl = "http://10.0.2.2:8000/api/food/popular/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _foodModel = _foodModel.toMap(data[i], "FOD");
        foodListPopular.add(_foodModel);

        // context.read<ProviderMaps>().addMarker2(
        //     LatLng(double.parse(_foodModel.latitude!),
        //         double.parse(_foodModel.longitude!)),
        //     _foodModel.imageUrls!.isEmpty
        //         ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
        //         : _foodModel.imageUrls![0]["image"]);
      }
    }

    notifyListeners();
  }

  void getFoodList(BuildContext context) async {
    foodList = [];
    getFoodListPopular(context);

    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));

    String interestUrl = "http://10.0.2.2:8000/api/food/list/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _foodModel = _foodModel.toMap(data[i], "FOD");
        foodList.add(_foodModel);

        // context.read<ProviderMaps>().addMarker2(
        //     LatLng(double.parse(_foodModel.latitude!),
        //         double.parse(_foodModel.longitude!)),
        //     _foodModel.imageUrls!.isEmpty
        //         ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
        //         : _foodModel.imageUrls![0]["image"]);
      }
    }

    notifyListeners();
  }

  void getDestinationList(BuildContext context) async {
    destinationList = [];
    getDestinationListPopular(context);
    final storage = const FlutterSecureStorage();
    String? uid = _getUserId(await storage.read(key: "jwt"));
    String interestUrl = "http://10.0.2.2:8000/api/destination/list/$uid/";
    var response = await http.get(Uri.parse(interestUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (int i = 0; i < 5; i++) {
        _destinationModel = _destinationModel.toMap(data[i], "DES");

        destinationList.add(_destinationModel);
        // context.read<ProviderMaps>().addMarker2(
        //     LatLng(double.parse(_destinationModel.latitude!),
        //         double.parse(_destinationModel.longitude!)),
        //     _destinationModel.imageUrls!.isEmpty
        //         ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
        //         : _destinationModel.imageUrls![0]["image"]);
      }
    }

    notifyListeners();
  }
}
