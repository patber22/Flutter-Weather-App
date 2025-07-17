import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationFinder {
  Future<Position?> getLocation() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } else {
      return null;
    }
  }
}