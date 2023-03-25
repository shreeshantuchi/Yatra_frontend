import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:yatra/repository/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:yatra/repository/data_api.dart';
import 'package:yatra/services/auth_services.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:yatra/utils/colors.dart';

class ProviderMaps with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  LatLng? initialposition;
  LatLng? _finalposition;
  late MapController _mapController;
  LatLng? get initialPos => initialposition;
  final Set<Marker> _markers = {};
  final Set<Marker> _markers2 = {};
  final Set<Polyline> _polylines = {};
  Set<Marker> get markers => _markers;
  Set<Marker> get markers2 => _markers2;
  Set<Polyline> get polyline => _polylines;
  String distance = "";
  MapController get mapController => _mapController;
  Position? position;
  List<Placemark> placemarks = [];
  StreamController<List<Placemark>> controller =
      StreamController<List<Placemark>>.broadcast();
  StreamSubscription<Position>? positionStream;

  void onCreated(MapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      } else {
        position = await determinePosition();
      }
    }
  }

  Stream<Position> listenToLocationChange() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      timeLimit: Duration(seconds: 1),
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Stream<List<Placemark>> listenToPlacemarkChange(BuildContext context) {
    Stream<List<Placemark>> stream = controller.stream;
    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        timeLimit: Duration(hours: 1),
        distanceFilter: 1);

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((event) async {
      print(event);
      position = event;
      await context.read<AuthProvider>().updateUserLocation(
          latitude: position!.latitude.toString(),
          longitude: position!.longitude.toString());
      await storage.write(key: "lastLocation", value: position!.toString());
      // ignore: use_build_context_synchronously
      context.read<DataApi>().getFoodList(context);
      context.read<DataApi>().getDestinationList(context);
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      controller.add(placemarks);
    });

    return stream;
  }

  Future<Position?> determinePosition() async {
    position = await Geolocator.getCurrentPosition();
    initialposition = LatLng(position!.latitude, position!.longitude);
    notifyListeners();
    return position;
  }

  Future<List<Placemark>> determinePlacemark() async {
    position = await Geolocator.getCurrentPosition();

    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    return placemarks;
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
        builder: (contexts) {
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

  void addMarker2(LatLng location, String imgUrl) {
    _markers2.add(Marker(
      height: 75.h,
      width: 75.h,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColor.blackColor,
          ),
          height: 150,
          width: 150,
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
        Polyline(strokeWidth: 5, points: polylines, color: MyColor.blueColor));
    notifyListeners();
  }

  void cleanpoint() {
    polyline.clear();
    distance = '';
    markers.clear();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    controller.close();
    super.dispose();
  }
}
