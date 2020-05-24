import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';
import 'package:saca/view-models/image.viewmodel.dart';

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

  Future<bool> create(User user, ImageViewModel imageViewModel) async {
    try {
      imageViewModel.id = 0;
      final response = await _httpService.dio.post('/${user.id}',
          data: imageViewModel,
          options: Options(contentType: ContentType.json.mimeType, headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${user.token}'
          }));
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (error) {
      if (error.response.statusCode == 302) {
        return true;
      }

      return false;
    }
  }

  Future<bool> update(User user, ImageViewModel imageViewModel) async {
    try {
      final response = await _httpService.dio.put('/${user.id}/${imageViewModel.id}',
          data: imageViewModel,
          options: Options(contentType: ContentType.json.mimeType, headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${user.token}'
          }));

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> remove(User user, Image image) async {
    try {
      final response = await _httpService.dio.delete('/${user.id}/${image.id}',
          options: Options(contentType: ContentType.json.mimeType, headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${user.token}'
          }));

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
