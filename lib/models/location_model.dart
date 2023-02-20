import 'package:geolocator/geolocator.dart';

class LocationModel {
  final String _country;
  final String _locality;
  final Position _position;

  LocationModel(this._country, this._locality, this._position);

  String get locality => _locality;
  String get country => _country;
}
