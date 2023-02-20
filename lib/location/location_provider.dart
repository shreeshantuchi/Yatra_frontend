import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatra/repository/api.dart';
import 'package:flutter_map/flutter_map.dart';

import 'dart:math' show cos, sqrt, asin;

class ProviderMaps with ChangeNotifier {
  LatLng? _initialposition;
  late LatLng _finalposition;
  late MapController _mapController;
  LatLng? get initialPos => _initialposition;
  LatLng get finalPos => _finalposition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyline => _polylines;
  String distance = "";
  MapController get mapController => _mapController;

  void onCreated(MapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void determinePosition() async {
    Position position;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    _initialposition = LatLng(position.latitude, position.longitude);

    notifyListeners();
  }

  String calculatedistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    double res = 12742 * asin(sqrt(a));
    if (res.toString().substring(0, 1) == "0") {
      res = (12742 * asin(sqrt(a))) * 1000;
      return "${res.toStringAsFixed(2)} m";
    } else {
      res = res;
      return "${res.toStringAsFixed(2)} Km";
    }
  }

  void addMarker(LatLng location) {
    if (markers.length < 2) {
      _markers.add(Marker(
        builder: (context) => const Icon(Icons.location_pin),
        point: location,
      ));
    }
    notifyListeners();
  }

  void routermap() async {
    polyline.clear();
    for (int i = 0; i < markers.length; i++) {
      if (i == 0) {
        _initialposition = markers.elementAt(i).point;
      }
      if (i == 1) {
        _finalposition = markers.elementAt(i).point;
      }
    }
    List<LatLng>? polylines = await Api().getpoints(
        _initialposition!.longitude.toString(),
        _initialposition!.latitude.toString(),
        _finalposition.longitude.toString(),
        _finalposition.latitude.toString());
    createpolyline(polylines!);
    distance = calculatedistance(
        _initialposition!.latitude,
        _initialposition!.longitude,
        _finalposition.latitude,
        _finalposition.longitude);
    notifyListeners();
  }

  void createpolyline(List<LatLng> polylines) {
    _polylines.add(
        Polyline(strokeWidth: 5, points: polylines, color: Colors.redAccent));
    notifyListeners();
  }

  void cleanpoint(int index) {
    polyline.clear();
    distance = '';
    markers.remove(markers.elementAt(index));
  }
}
