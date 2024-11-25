import 'dart:async';
import 'dart:math';

import 'package:blog/core/location/location_helper.dart';
import 'package:blog/core/services/state/state_handler_bloc.dart';
import 'package:blog/feature/map/domain/entities/map_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:location/location.dart';

class MapUsecase {
  static final Completer<GoogleMapController> controller = Completer();
  static Location location = Location();
  static StreamSubscription<LocationData>? locationSubscription;
  static StateHandlerBloc mainMapBloc = StateHandlerBloc();
  static StateHandlerBloc distanceBloc = StateHandlerBloc();
  static Set<Marker> markers = {};
  static List<LatLng> polylineCoordinates = [];
  static double distanceThreshold = 10.0;
  static double totalDistance = 0.0;
  static latlong2.LatLng? lastLatLng;
  static Set<Circle> circles = {};

  static void getCurrentLocation() async {
    LocationData? data = await LocationHelper.getCurrentLocation();
    if (data != null) {
      LatLng latLng = LatLng(data.latitude!, data.longitude!);
      circles.add(
        Circle(
          circleId: const CircleId("current_location"),
          center: latLng,
          radius: 10,
          fillColor: Colors.blue.withOpacity(0.5),
          strokeColor: Colors.blue,
          strokeWidth: 1,
        ),
      );
      markers.clear();
      animateMap(latLng: latLng);
      mainMapBloc.storeData(
        data: MapModel(
          state: Mapstate.MapSuccess,
          latLng: latLng,
        ),
      );
    } else {
      mainMapBloc.storeData(data: MapModel(state: Mapstate.MapError));
    }
  }

  static void listenLocationChange() {
    locationSubscription =
        location.onLocationChanged.listen((LocationData locationData) async {
      LatLng newLatLng =
          LatLng(locationData.latitude!, locationData.longitude!);
      addCirclesOnMove(latLng: newLatLng);
      addPolygonOnMove(latLng: newLatLng);

      LatLng currentLatLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      if (lastLatLng == null) {
        lastLatLng =
            latlong2.LatLng(locationData.latitude!, locationData.longitude!);
        return;
      }

      // Calculate the distance from the last position
      double distance = calculateDistance(
        LatLng(lastLatLng!.latitude, lastLatLng!.longitude),
        currentLatLng,
      );

      // If the camera has moved more than the threshold, add a marker
      if (distance >= distanceThreshold) {
        final String markerId = 'marker_${markers.length + 1}';
        markers.add(
          Marker(
            markerId: MarkerId(markerId),
            position: currentLatLng,
          ),
        );
        lastLatLng =
            latlong2.LatLng(locationData.latitude!, locationData.longitude!);
        totalDistance += distance;
        distanceBloc.storeData(data: totalDistance.round().toString());
      }
      animateMap(latLng: newLatLng);
      mainMapBloc.storeData(
        data: MapModel(
          state: Mapstate.MapSuccess,
          latLng: newLatLng,
        ),
      );
    });
  }

  static void stopListeningLocationChange() {
    locationSubscription!.cancel();
  }

  static animateMap({required LatLng latLng}) async {
    GoogleMapController googleMapController = await controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  static void addCirclesOnMove({required LatLng latLng}) {
    circles.clear();
    circles.add(
      Circle(
        circleId: const CircleId("current_location"),
        center: latLng,
        radius: 20,
        fillColor: Colors.blue.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    );
  }

  static void addPolygonOnMove({required LatLng latLng}) {
    polylineCoordinates.add(latLng);

    // polygons.add(
    //   Polygon(
    //     polygonId: const PolygonId("current_location_polygon"),
    //     points: [latLng],
    //     fillColor: Colors.blue.withOpacity(0.3),
    //     strokeColor: Colors.blue,
    //     strokeWidth: 2,
    //   ),
    // );
  }

  // Function to calculate the distance between two LatLng points
  static double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371000; // meters
    double dLat = _degreesToRadians(point2.latitude - point1.latitude);
    double dLon = _degreesToRadians(point2.longitude - point1.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(point1.latitude)) *
            cos(_degreesToRadians(point2.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c; // Distance in meters
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static void onCameraMove(CameraPosition position) async {
    LatLng currentLatLng = LatLng(
      position.target.latitude,
      position.target.longitude,
    );
    if (lastLatLng == null) {
      lastLatLng =
          latlong2.LatLng(position.target.latitude, position.target.longitude);
      return;
    }

    // Calculate the distance from the last position
    double distance = calculateDistance(
      LatLng(lastLatLng!.latitude, lastLatLng!.longitude),
      position.target,
    );

    // If the camera has moved more than the threshold, add a marker
    if (distance >= distanceThreshold) {
      final String markerId = 'marker_${markers.length + 1}';
      markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position.target,
        ),
      );
      lastLatLng =
          latlong2.LatLng(position.target.latitude, position.target.longitude);
      totalDistance += distance;
      distanceBloc.storeData(data: totalDistance.toString());
    }

    // if (lastLatLng != null) {
    //   var distance = const latlong2.Distance().as(
    //     latlong2.LengthUnit.Meter,
    //     lastLatLng!,
    //     latlong2.LatLng(
    //       currentLatLng.latitude,
    //       currentLatLng.longitude,
    //     ),
    //   );
    //   // If the distance exceeds the threshold, add a marker and update polyline
    //   if (distance >= distanceThreshold) {
    //     markers.add(
    //       Marker(
    //         markerId: const MarkerId('1'),
    //         position: currentLatLng,
    //       ),
    //     );
    //   }
    // Update the last position to the current position
    // lastLatLng = latlong2.LatLng(
    //   currentLatLng.latitude,
    //   currentLatLng.longitude,
    // );
    // totalDistance += distance;
    // distanceBloc.storeData(data: totalDistance.toString());
    // } else {
    // lastLatLng = latlong2.LatLng(
    //   currentLatLng.latitude,
    //   currentLatLng.longitude,
    // );
    // }
    addCirclesOnMove(latLng: currentLatLng);
    addPolygonOnMove(latLng: currentLatLng);
    mainMapBloc.storeData(
      data: MapModel(
        state: Mapstate.MapSuccess,
        latLng: currentLatLng,
      ),
    );
  }
}
