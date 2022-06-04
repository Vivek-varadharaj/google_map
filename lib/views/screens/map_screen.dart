

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
   MapScreen({Key? key}) : super(key: key);
   GoogleMapController? mapController;
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
   void _onMapCreated(
   GoogleMapController controller,
 ) {
   mapController = controller;
 }
 
 final List<LatLng> _markerLocations = [
   LatLng(13.0665092, 80.280932),
   LatLng(-41.7933525, 172.7457814),
   LatLng(-41.7933525, 172.7457814),
   LatLng(-41.2901075, 174.2075762),
   LatLng(51.7548164, -1.2565555),
   LatLng(12.9723303, 79.1574463)
 ];
 double bearing = 0;
 double tilt = 0;
 double zoom = 10;
 
 animateCamer() async {
   bearing = bearing + 180;
   print("onTap worked");
   await mapController!.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(target: LatLng(-33.852, 151), zoom: 10, tilt: tilt)
   
       ));
 
   await mapController!.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(
           target: LatLng(-33.852, 151.211),
           zoom: zoom + 10,
           tilt: tilt + 45,
           bearing: bearing)
  
       ));
   
 }
 
 getMarker() {
   Marker marker = Marker(
     onTap: () => animateCamer(),
     markerId: MarkerId("1"),
     position: LatLng(-33.852, 151.211),
   );
   return marker;
 }

  @override
  Widget build(BuildContext context) {
     return GoogleMap(
     mapType: MapType.satellite,
     onMapCreated: (controller) => _onMapCreated(controller),
     initialCameraPosition: CameraPosition(
       target: LatLng(-33.852, 151.211),
       zoom: zoom,
     ),
 
     markers: Set<Marker>.of(markers.values), // YOUR MARKS IN MAP
   );
  }
}