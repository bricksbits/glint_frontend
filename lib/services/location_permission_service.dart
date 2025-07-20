import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionService {
  Future<bool> requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    print('permission_handler status: $status');

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    final geoStatus = await Geolocator.checkPermission();
    print('geolocator status: $geoStatus');

    if (geoStatus == LocationPermission.denied || geoStatus == LocationPermission.deniedForever) {
      final geoRequest = await Geolocator.requestPermission();
      return geoRequest == LocationPermission.whileInUse || geoRequest == LocationPermission.always;
    }

    return status.isGranted;
  }

  Future<Position?> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 200,
    ));
  }
}
