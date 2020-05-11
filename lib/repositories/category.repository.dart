import 'package:dio/dio.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/settings.dart';

class CategoryRepository {
  Dio dio;
  String baseUrl;

  CategoryRepository() {
    this.baseUrl = '$API_URL/categories';
    this.dio = Dio(
      BaseOptions(
        baseUrl: this.baseUrl,
      ),
    );
  }

  Future<List<Category>> getAllHome() async {
    try {
      Response response = await this.dio.get('');

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
      Response response = await Dio(
        BaseOptions(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      ).get(
        '${this.baseUrl}/${user.id}',
      );

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
