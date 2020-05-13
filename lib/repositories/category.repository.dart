import 'package:dio/dio.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';

class CategoryRepository {
  HttpService _httpService;

  CategoryRepository() {
    _httpService = HttpService();
    _httpService.dio.options.baseUrl += '/categories';
  }

  Future<List<Category>> getAllHome() async {
    try {
      Response response = await _httpService.dio.get('');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();

        return categories;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Category>> getAll(User user) async {
    try {  
      _httpService.addToken(user.token);
      
      Response response = await _httpService.dio.get('/${user.id}');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((category) => Category.fromJson(category))
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
