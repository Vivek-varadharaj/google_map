import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_skies_map/services/map_and_location_services.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MapAndLocationServices? _mapAndLocationServices;
  @override
  void initState() {
    super.initState();
    _mapAndLocationServices = MapAndLocationServices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _mapAndLocationServices!.getCoordinates(),
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
          } else if (snapShot.hasError) {
            return Scaffold(
              body: FutureBuilder(builder: (context, snapShot) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    snapShot.error.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            );
          } else if (snapShot.connectionState == ConnectionState.done) {
            return const SizedBox();
          } else
            return Text("jaslkjdflj");
        });
  }
}
