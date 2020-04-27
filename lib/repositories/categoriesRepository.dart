import 'package:dio/dio.dart';
import 'package:saca/models/Category.dart';
import 'package:saca/settings.dart';

class CategoryRepository {
  static Future<List<Category>> getAll() async {
    var url = '$API_URL/categories';

    try {
      Response response = await Dio().get(url);
      var categories = (response.data as List)
          .map((categories) => Category.fromJson(categories))
          .toList();

      return categories;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
