class ImageModel {
  final String webfromatURL;
  final String largeimageURL;

  ImageModel({required this.webfromatURL, required this.largeimageURL});

  factory ImageModel.fromjson({required Map data}) {
    return ImageModel(
      webfromatURL: data['webformatURL'],
      largeimageURL: data['largeImageURL'],
    );
  }
}
