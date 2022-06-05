import 'dart:developer';

import 'package:info_skies_map/configs/configs.dart';
import 'package:info_skies_map/models/image_model.dart';
import 'package:info_skies_map/services/splash_image_services.dart';

class ImageController {
  List<ImageModel>? images;

  final SplashImageServices _getImagesServices = SplashImageServices();

  Future<List<ImageModel>?> fetchImages({ required int page, required int limit}) async {
    String baseUrl = "${Configs.baseUrl}&page=$page&per_page=$limit";
    dynamic result = await _getImagesServices.getImages(baseUrl);
    if (result.runtimeType != bool) {
      result as List;
      images = result.map((json) => ImageModel.fromJson(json)).toList();
      log("images");
      log(images![0].largeImageUrl);
      return images;
    } else {
      return null;
    }
  }
}
