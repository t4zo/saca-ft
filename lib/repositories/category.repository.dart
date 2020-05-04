import 'package:dio/dio.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/settings.dart';

class CategoryRepository {
  static Future<List<Category>> getAll() async {
    var url = '$API_URL/categories';

    try {
      Response response = await Dio().get(url);

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
}
