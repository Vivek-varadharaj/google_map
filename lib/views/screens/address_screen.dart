import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_skies_map/configs/constants.dart';

import 'package:info_skies_map/services/map_and_location_services.dart';
import 'package:info_skies_map/views/screens/maps_screen.dart';

class AdressScreen extends StatefulWidget {
  const AdressScreen({Key? key}) : super(key: key);

  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
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
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                location != null && location!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child:
                            Center(child: Text("Your Location is $location")),
                      )
                    : const SizedBox(),
                Center(child: getLocationButton()),
              ],
            )
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapsScreen(
                      setTheLocationInPreviousScreen: getLocationName,
                    )));
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

  void getLocationName(LatLng latLng) async {
    location =
        await _mapAndLocationServices!.getPlaceNameFromCordinates(latLng);
    setState(() {});
  }
}
