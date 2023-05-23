// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

/// here [MyLocationService] is the service class for getting my co-ordinates of  a person globe using Geolocator package
class MyLocationService {
  double? currentLatitude;
  double? currentLongitude;

  /// here [getlocationservice ] is that gets the location of the device and returns it
  ///  its null type because inittially no data is here when object created

  Future<void> getCurrentLocationService() async {
    try {
      //  !first check permisiion and wait

      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

      //! here awit refers that  wait this proccess to complete then continue other
      Position myCurrentGpsPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      currentLatitude = myCurrentGpsPos.latitude;
      currentLongitude = myCurrentGpsPos.longitude;
    } catch (e) {
      print(e);
    }
  }
}
