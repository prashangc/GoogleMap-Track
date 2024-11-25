import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

enum CurrentView { permissionView, homeView, unableToDetermineView }

class LocationHelper {
  static final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  static loc.Location location = loc.Location();
  static Future<loc.LocationData?> getCurrentLocation() async {
    try {
      bool alreadyOn = await isLocationEnabled();
      if (!alreadyOn) {
        bool isLocationEnabled = await location.requestService();
        if (isLocationEnabled) {
          LocationPermission? permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever) {
            return null;
          } else {
            return await loc.Location.instance.getLocation();
          }
        } else {
          return null;
        }
      } else {
        LocationPermission? permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        } else {
          try {
            loc.LocationData r = await loc.Location.instance.getLocation();
            return r;
          } catch (e) {
            log(e.toString());
          }
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Future<LocationPermission> getLocationStatus() async {
  //   LocationPermission permission;

  //   permission = await _geolocator.checkPermission();
  //   if (Platform.isAndroid && permission == LocationPermission.denied) {
  //     permission = await _geolocator.requestPermission();
  //     return permission;
  //   }
  //   return permission;
  // }

  openSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.settings);
    // openAppSettings();
    // _geolocator.openLocationSettings();
  }

  Future<bool?> isLocationPermissionGranted() async {
    // LocationPermission permission;
    // permission = await _geolocator.checkPermission();
    // switch (permission) {
    //   case LocationPermission.always:
    //     return CurrentView.homeView;
    //   case LocationPermission.denied:
    //     return CurrentView.permissionView;
    //   case LocationPermission.deniedForever:
    //     return CurrentView.permissionView;
    //   case LocationPermission.unableToDetermine:
    //     return CurrentView.permissionView;
    //   case LocationPermission.whileInUse:
    //     return CurrentView.homeView;
    //   default:
    //     return CurrentView.unableToDetermineView;
    // }
    // LocationPermission permission;
    // permission = await
    // PermissionStatus status = await Permission.location.status;
    // return status == PermissionStatus.granted;
    LocationPermission status;
    status = await _geolocator.checkPermission();
    if (status == LocationPermission.always ||
        status == LocationPermission.whileInUse) {
      return true;
    } else if (status == LocationPermission.deniedForever) {
      // await LocationHelper().openSettings();
      return null;
    }
    return false;
    // switch (permission) {
    //   case LocationPermission.denied:
    //     break;
    //   case LocationPermission.deniedForever:
    //     await LocationHelper().openSettings();
    //     break;
    //   case LocationPermission.whileInUse:
    //     break;
    //   case LocationPermission.always:
    //     break;
    //   case LocationPermission.unableToDetermine:
    //     break;
    //   default:
    //     break;
    // }
  }

  Future<bool> requestToOpenLocation() async {
    bool serviceEnabled = await isLocationEnabled();
    if (serviceEnabled) {
      return serviceEnabled;
    } else {
      return await location.requestService();
    }
  }

  static Future<bool> isLocationEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }
}
