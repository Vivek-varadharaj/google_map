import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_skies_map/configs/constants.dart';

import 'package:info_skies_map/services/map_and_location_services.dart';
import 'package:info_skies_map/views/screens/maps_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapAndLocationServices? _mapAndLocationServices;
  String? location;
  TextEditingController? _locationTextController;
  bool showLocation = false;

  @override
  void initState() {
    super.initState();
    _mapAndLocationServices = MapAndLocationServices();
    _locationTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !showLocation
          ? Center(child: getLocationButton())
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Your Location is"),
                  Text(
                    location ?? "Unable to process location",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  getLocationButton(),
                ],
              ),
            ),
    );
  }

  Widget getLocationButton() {
    return TextButton.icon(
        onPressed: () async {
          ErrorObject isSuccess =
              await _mapAndLocationServices!.getPermission();
          if (isSuccess.value) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MapsScreen()));
          } else {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Location Service disabled!, Enter your location",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextField(
                              controller: _locationTextController,
                              decoration:
                                  inputDecoration(labelText: "location"),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  location = _locationTextController!.text;
                                  if (location != null &&
                                      location!.isNotEmpty) {
                                    setState(() {
                                      showLocation = true;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Done"))
                          ],
                        ),
                      ),
                    ));
          }
        },
        icon: const Icon(Icons.location_city_sharp),
        label: const Text("Get your location"));
  }
}
