import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';

class LocationScreen extends StatefulWidget {
  final LatLng initialPosition;
  const LocationScreen({Key? key, required this.initialPosition})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final MapController mapController = MapController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0.sp),
              topRight: Radius.circular(20.0.sp),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                child: FlutterMap(
                  options: MapOptions(
                    center: widget.initialPosition,
                    zoom: 16,
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: 'OpenStreetMap contributors',
                      onSourceTapped: null,
                    ),
                  ],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: context.watch<ProviderMaps>().markers.toList() +
                          context.watch<ProviderMaps>().markers2.toList(),
                    ),
                    PolylineLayer(
                      polylines:
                          context.watch<ProviderMaps>().polyline.toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
