class ImageModel {
  String largeImageUrl;

  ImageModel({required this.largeImageUrl});
  factory ImageModel.fromJson(Map<String, dynamic> data) {
    return ImageModel(largeImageUrl: data["urls"]["full"]);
  }
}
