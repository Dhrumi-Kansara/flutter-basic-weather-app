import 'package:geolocator/geolocator.dart';

class Location {

  double longitude=0;
  double latitude=0;

  Future<void> getCurrentLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();

      //print('enabled: $enabled'); // true

      LocationPermission permission = await Geolocator.checkPermission();

      //print('permission: $permission'); // whileInUse

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ); // throw exception here

      //print(position);
      longitude=position.longitude;
      latitude=position.latitude;
    } catch (error) {
      // i got `LocationServiceDisabledException` here
      print('error: $error');
    }
  }

}