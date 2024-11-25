import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Mapstate { MapLoading, MapSuccess, MapError }

class MapModel {
  LatLng? latLng;
  Mapstate state;

  MapModel({this.latLng, required this.state});
}
