import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class Api {
  Future<List<LatLng>?> getpoints(
      String longini, String latini, String longend, String latend) async {
    List<LatLng> routepoints = [];
    var url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/$longini,$latini;$longend,$latend?geometries=geojson');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var rutar =
          jsonDecode(response.body)["routes"][0]["geometry"]["coordinates"];
      for (int i = 0; i < rutar.length; i++) {
        var reep = rutar[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(',');
        routepoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }
      return routepoints;
    } else {
      return null;
    }
  }

  void getProfile(String? jwtToken) async {
    String apiUrl = "http://10.0.2.2:8000/api/user/yatri/";

    var response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else
      print("error");
  }
}
