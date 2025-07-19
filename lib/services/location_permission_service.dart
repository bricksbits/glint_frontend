import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionService {
  Future<bool> requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<Position?> getCurrentLocation() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
    ));
  }
}
