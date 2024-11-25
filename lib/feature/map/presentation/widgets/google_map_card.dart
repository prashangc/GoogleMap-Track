import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCard extends StatelessWidget {
  const GoogleMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition:
          const CameraPosition(zoom: 16, target: LatLng(27.12, 27.2123)),
      onCameraMoveStarted: () => {},
      onCameraMove: (position) => {},
      onCameraIdle: () => {},
      onMapCreated: (GoogleMapController controller) async {
        // mapController.googleMapController.complete(controller);
      },
    );
  }
}
