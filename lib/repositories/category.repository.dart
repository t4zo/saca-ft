import 'package:dio/dio.dart';
import 'package:saca/constants/http.constants.dart';
import 'package:saca/constants/validation.constants.dart';
import 'package:saca/models/category.model.dart';
import 'package:saca/models/http_response.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';

class CategoryRepository {
  HttpService _httpService;

  CategoryRepository() {
    _httpService = HttpService();
    _httpService.dio.options.baseUrl += '/categories';
  }

  Future<HttpResponse<List<Category>>> getAllHomeAsync() async {
    try {
      Response response = await _httpService.dio.get('');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();

        return HttpResponse(response: categories);
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } on DioError catch (error) {
      return HttpResponse(error: error, errorMessage: FieldConstants.INVALID);
    }
  }

  Future<HttpResponse<List<Category>>> getAllAsync(User user) async {
    try {
      _httpService.addToken(user.token);

      Response response = await _httpService.dio.get('/${user.id}');

      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((category) => Category.fromJson(category))
            .toList();

        return HttpResponse(response: categories);
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } catch (error) {
      return HttpResponse(error: error, errorMessage: FieldConstants.INVALID);
    }
  }
}
