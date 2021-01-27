import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saca/constants/http.constants.dart';
import 'package:saca/constants/validation.constants.dart';
import 'package:saca/models/image.model.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';
import 'package:saca/view-models/image.viewmodel.dart';
import 'package:saca/models/http_response.dart';

class ImageRepository {
  HttpService _httpService;

  ImageRepository() {
    _httpService = HttpService();
    _httpService.dio.options.baseUrl += '/images';
  }

  Future<HttpResponse<Image>> createAsync(User user, ImageViewModel imageViewModel) async {
    try {
      imageViewModel.id = 0;

      final response = await _httpService.dio.post('',
          data: {
            'name': imageViewModel.name,
            'categoryId': imageViewModel.categoryId,
            'base64': imageViewModel.base64,
          },
          options: Options(
            contentType: ContentType.json.mimeType,
            headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
          ));

      if (response.statusCode == 200) {
        return HttpResponse(response: Image.fromJson(response.data));
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } on DioError catch (error) {
      return HttpResponse(error: error, errorMessage: FieldConstants.INVALID);
    }
  }

  Future<HttpResponse<Image>> updateAsync(User user, ImageViewModel imageViewModel) async {
    try {
      final response = await _httpService.dio.put('/${imageViewModel.id}',
          data: imageViewModel,
          options: Options(
            contentType: ContentType.json.mimeType,
            headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
          ));

      if (response.statusCode == 200) {
        return HttpResponse(response: Image.fromJson(response.data));
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } on DioError catch (error) {
      return HttpResponse(error: error, errorMessage: FieldConstants.INVALID);
    }
  }

  Future<HttpResponse<Image>> removeAsync(User user, Image image) async {
    try {
      final response = await _httpService.dio.delete('/${image.id}',
          options: Options(
            contentType: ContentType.json.mimeType,
            headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
          ));

      if (response.statusCode == 200) {
        return HttpResponse(response: Image.fromJson(response.data));
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } catch (error) {
      return HttpResponse(error: error, errorMessage: FieldConstants.INVALID);
    }
  }
}
