import 'package:flutter/material.dart';
import 'package:info_skies_map/services/map_and_location_services.dart';
import 'package:info_skies_map/views/screens/carousel_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapAndLocationServices mapAndLocationServices = MapAndLocationServices();
  final ErrorObject isSuccess =
      await mapAndLocationServices.getPermission(askForTurningOnLocation: false);

  runApp(MyApp(isSuccess: isSuccess));
}

class MyApp extends StatelessWidget {
  final ErrorObject isSuccess;
  const MyApp({Key? key, required this.isSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: CarouseScreen()),
    );
  }
}
