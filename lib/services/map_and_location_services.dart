import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAndLocationServices {
  bool? serviceEnabled;
  LocationPermission? permission;
  static final MapAndLocationServices _mapAndLocationServices =
      MapAndLocationServices.singleton();
  MapAndLocationServices.singleton();
  GoogleMapController? mapController;

  double bearing = 0;

  double tilt = 0;

  factory MapAndLocationServices() {
    return _mapAndLocationServices;
  }

  Future<ErrorObject> getPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return ErrorObject(key: 'Location services are disabled.', value: false);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return ErrorObject(
            key: 'Location permissions are denied', value: false);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return ErrorObject(
          key:
              'Location permissions are permanently denied, we cannot request permissions.',
          value: false);
    }
    return ErrorObject(key: "Success", value: true);
  }

  Future<LatLng> getCoordinates() async {
    await getPermission();
    Position position = await Geolocator.getCurrentPosition();
  
    return LatLng(position.latitude, position.longitude);
  }

  getMarker(LatLng latLng) {
    Marker marker = Marker(
      onTap: () => animateCamer(latLng),
      markerId: const MarkerId("1"),
      position: latLng,
    );
    return marker;
  }

  void onMapCreated(
    GoogleMapController controller,
  ) {
    mapController = controller;
  }

  animateCamer(LatLng latLng) async {
    bearing = bearing + 180;

    await mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: latLng, zoom: 15, tilt: tilt + 45, bearing: bearing)));
  }
}

class ErrorObject {
  String key;
  bool value;
  ErrorObject({required this.key, required this.value});
}
