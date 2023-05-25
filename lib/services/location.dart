import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location{
  double? longitude;
  double? latitude;
   Position position;

  CameraPosition? _kGooglePlex;
  Future<void> getCurrentPosition() async {
    try{
      position = await Geolocator.getCurrentPosition().then((value) => value);
      _kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      latitude = position.latitude;
      longitude = position.longitude;

    }
    catch(e){
      print(e);
    }
  }
}
