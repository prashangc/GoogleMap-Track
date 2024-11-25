import 'dart:developer';

import 'package:blog/config/theme/colors.dart';
import 'package:blog/core/extension/sizebox.dart';
import 'package:blog/core/widgets/appbar/custom_appbar.dart';
import 'package:blog/core/widgets/button/custom_button.dart';
import 'package:blog/core/widgets/text/custom_text.dart';
import 'package:blog/feature/map/domain/entities/map_model.dart';
import 'package:blog/feature/map/domain/usecase/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapScreen extends StatefulWidget {
  const CustomMapScreen({super.key});

  @override
  State<CustomMapScreen> createState() => _CustomMapScreenState();
}

class _CustomMapScreenState extends State<CustomMapScreen> {
  @override
  void initState() {
    super.initState();
    MapUsecase.getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    MapUsecase.controller.complete(controller);
  }

  @override
  void dispose() {
    MapUsecase.markers.clear();
    MapUsecase.circles.clear();
    MapUsecase.polylineCoordinates.clear();
    MapUsecase.locationSubscription?.cancel();
    MapUsecase.totalDistance = 0.0;
    // MapUsecase.polygons.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Google Maps"),
      body: StreamBuilder<dynamic>(
          initialData: MapModel(latLng: null, state: Mapstate.MapLoading),
          stream: MapUsecase.mainMapBloc.stateStream,
          builder: (mapCtx, mapData) {
            MapModel mapModel = mapData.data;
            return mapModel.state == Mapstate.MapLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : mapModel.state == Mapstate.MapError
                    ? const Center(
                        child: CustomText(text: "Unable to fetch location"),
                      )
                    : Stack(
                        children: [
                          GoogleMap(
                            circles: MapUsecase.circles,

                            polylines: {
                              Polyline(
                                polylineId: const PolylineId("route"),
                                points: MapUsecase.polylineCoordinates,
                                color: Colors.red,
                                width: 6,
                              ),
                            }, // polygons: MapUsecase.polygons,
                            markers: MapUsecase.markers,
                            onMapCreated: _onMapCreated,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: false,
                            zoomControlsEnabled: false,
                            onCameraMoveStarted: () {
                              log("message");
                            },
                            // onCameraMove: (CameraPosition position) =>
                            //     MapUsecase.onCameraMove(position),
                            onCameraIdle: () {
                              log("idle");
                            },
                            initialCameraPosition: CameraPosition(
                              target: mapModel.latLng!,
                              zoom: 18.0,
                            ),
                            mapType: MapType.normal,
                            zoomGesturesEnabled: true,
                            compassEnabled: true,
                            scrollGesturesEnabled: true,
                            rotateGesturesEnabled: true,
                            tiltGesturesEnabled: true,
                          ),
                          Positioned(
                            bottom: 12.0,
                            right: 12.0,
                            left: 12.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                color: AppColors.kWhite,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        text: "Distance travalled: ",
                                        fontSize: 12.0,
                                        isBold: true,
                                      ),
                                      StreamBuilder<dynamic>(
                                          initialData: 0,
                                          stream: MapUsecase
                                              .distanceBloc.stateStream,
                                          builder: (distanceCtx, distance) {
                                            return CustomText(
                                              text: "${distance.data} m",
                                              fontSize: 12.0,
                                              isBold: true,
                                            );
                                          }),
                                    ],
                                  ),
                                  12.hGap,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomButton(
                                        callback: () {
                                          MapUsecase.listenLocationChange();
                                        },
                                        title: "Start",
                                      ),
                                      12.wGap,
                                      CustomButton(
                                        callback: () {
                                          MapUsecase
                                              .stopListeningLocationChange();
                                        },
                                        title: "End",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
          }),
    );
  }
}
