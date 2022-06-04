import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAndLocationServices {
  static final MapAndLocationServices _mapAndLocationServices =
      MapAndLocationServices.singleton();
  MapAndLocationServices.singleton();
  GoogleMapController? mapController;

  double bearing = 0;

  double tilt = 0;

  factory MapAndLocationServices() {
    return _mapAndLocationServices;
  }

  Future<LatLng> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

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
