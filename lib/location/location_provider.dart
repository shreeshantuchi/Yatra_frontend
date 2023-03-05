import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatra/repository/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:yatra/utils/colors.dart';

class ProviderMaps with ChangeNotifier {
  LatLng? initialposition;
  LatLng? _finalposition;
  late MapController _mapController;
  LatLng? get initialPos => initialposition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyline => _polylines;
  String distance = "";
  MapController get mapController => _mapController;
  Position? position;
  List<Placemark> placemarks = [];

  StreamSubscription<Position>? positionStream;

  void onCreated(MapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  Future<Position?> listenToLocationChange() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        timeLimit: Duration(hours: 1),
        distanceFilter: 10);

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((event) async {
      position = event;
      try {
        placemarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        initialposition = LatLng(position!.latitude, position!.longitude);
      } catch (e) {
        print(e);
      }

      notifyListeners();
    });
    return position;
  }

  Future<Position> determinePosition() async {
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
    initialposition = LatLng(position.latitude, position.longitude);
    notifyListeners();
    return position;
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

  void addMarker(LatLng location, String imgUrl) {
    if (markers.length < 2) {
      _markers.add(Marker(
        height: 50.h,
        width: 50.h,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MyColor.redColor,
            ),
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 60.sp,
                backgroundImage: NetworkImage(imgUrl),
              ),
            ),
          );
        },
        point: location,
      ));
    }
  }

  void routermap() async {
    polyline.clear();
    for (int i = 0; i < markers.length; i++) {
      if (i == 0) {
        initialposition = markers.elementAt(i).point;
      }
      if (i == 1) {
        _finalposition = markers.elementAt(i).point;
      }
    }
    List<LatLng>? polylines = await Api().getpoints(
        initialposition!.longitude.toString(),
        initialposition!.latitude.toString(),
        _finalposition!.longitude.toString(),
        _finalposition!.latitude.toString());
    createpolyline(polylines!);
    distance = calculatedistance(
        initialposition!.latitude,
        initialposition!.longitude,
        _finalposition!.latitude,
        _finalposition!.longitude);
    notifyListeners();
  }

  void createpolyline(List<LatLng> polylines) {
    _polylines.add(
        Polyline(strokeWidth: 5, points: polylines, color: Colors.redAccent));
    notifyListeners();
  }

  void cleanpoint() {
    polyline.clear();
    distance = '';
    markers.clear();
  }

  @override
  void dispose() {
    super.dispose();
    positionStream?.cancel();
  }
}
