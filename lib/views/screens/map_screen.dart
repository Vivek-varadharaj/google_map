import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_skies_map/services/map_and_location_services.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapAndLocationServices? _mapAndLocationServices;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    _mapAndLocationServices = MapAndLocationServices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _mapAndLocationServices!.determinePosition(),
        builder: (context, AsyncSnapshot<LatLng> snapShot) {
          if (snapShot.hasData) {
            markers[const MarkerId("1")] =
                _mapAndLocationServices!.getMarker(snapShot.data!);
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (controller) =>
                  _mapAndLocationServices!.onMapCreated(controller),
              initialCameraPosition: CameraPosition(
                target: snapShot.data!,
                zoom: 8,
              ),

              markers: Set<Marker>.of(markers.values), // YOUR MARKS IN MAP
            );
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapShot.connectionState == ConnectionState.done) {
            return const SizedBox();
          } else {
            return const Text("error occured");
          }
        });
  }
}
