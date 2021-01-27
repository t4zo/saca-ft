import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saca/constants/http.constants.dart';
import 'package:saca/constants/validation.constants.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/models/http_response.dart';
import 'package:saca/services/http.service.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';

class UserRepository {
  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
    _httpService.dio.options.baseUrl += '/auth';
  }

  Future<HttpResponse<User>> signInAsync(SignInViewModel model) async {
    model.remember = false;

    try {
      Response response = await _httpService.dio.post('/signin', data: model);

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['user']);
        return HttpResponse(response: user);
      }

      return HttpResponse(error: DioError(error: HttpConstants.CODE_NOT_200));
    } on DioError catch (error) {
      // final errorResponse = json.decode(error.response.data)['errors'] as Map<String, dynamic>;
      // final errorField = errorResponse.entries.first;
      final errorMessage = json.decode(error.response.data)['detail'];
      return HttpResponse(error: error, errorMessage: errorMessage);
    }
  }

  Future<HttpResponse<User>> signUp(SignUpViewModel model) async {
    model.roles = ['User'];

    try {
      Response response = await _httpService.dio.post('', data: {
        'username': model.email,
        'email': model.email,
        'password': model.password,
        'confirmPassword': model.confirmPassword,
        'roles': model.roles,
      });

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data['user']);
        return HttpResponse(response: user);
      }

      return HttpResponse(
        error: DioError(error: HttpConstants.CODE_NOT_200),
        errorMessage: FieldConstants.INVALID,
      );
    } on DioError catch (error) {
      // final errorResponse = json.decode(error.response.data)['detail'] as Map<String, dynamic>;
      // final errorField = errorResponse.entries.first;
      final errorMessage = json.decode(error.response.data)['detail'];
      return HttpResponse(error: error, errorMessage: errorMessage);
    }
  }
}
