import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery_app/model/images_model.dart';
import 'package:http/http.dart' as http;

class ImagesControler extends ChangeNotifier {
  late Future<List<ImageModel>?> h;

  Future<List<ImageModel>?> getApi({String name = "rose"}) async {
    String myApi =
        "https://pixabay.com/api/?key=17241914-90da7b93c0ccceb734849dcd1&q=$name&image_type=photo";

    print(myApi);

    http.Response response = await http.get(
      Uri.parse(myApi),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> k = json.decode(response.body);
      print(k['hits']);
      List data = k['hits'];
      print(data);
      List<ImageModel> image = data
          .map(
            (e) => ImageModel.fromjson(data: e),
          )
          .toList();
      print(image);
      return image;
    }
    notifyListeners();
  }

  Updata({required String name}) {
    h = getApi(name: name);
    notifyListeners();
  }
}
