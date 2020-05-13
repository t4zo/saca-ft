import 'package:dio/dio.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';

class ImageRepository {
  HttpService _httpService;

  ImageRepository() {
    _httpService = HttpService();
    _httpService.dio.options.baseUrl += '/images';
  }

  Future<List<Image>> getAllHome() async {
    try {
      Response response = await _httpService.dio.get('');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((image) => Image.fromJson(image))
            .toList();

        return categories;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Image>> getAll(User user) async {
    try {  
      _httpService.addToken(user.token);
      
      Response response = await _httpService.dio.get('/${user.id}');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((image) => Image.fromJson(image))
            .toList();

        return categories;
      }

      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
