import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:info_skies_map/configs/configs.dart';

class SplashImageServices {
  // function for getting data from the back end
  Future<dynamic> getImages(String baseUrl) async {
    try {
      Response response = await http.get(Uri.parse(baseUrl),
          headers: {"authorization": "Client-ID ${Configs.appApiKey}"});

      List<dynamic> result = json.decode(response.body);

      return result;
    } catch (e) {
      return false;
    }
  }
}
