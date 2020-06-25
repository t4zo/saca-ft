import 'package:dio/dio.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';
import 'package:saca/settings.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';

class UserRepository {
  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
    // _httpService.dio.options.baseUrl += '/auth';
  }

  Future<User> authenticateAsync(SignInViewModel model) async {
    model.remember = false;

    Response response =
        await _httpService.dio.post('/auth/authenticate', data: model);

    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['user']);
      userToken = user.token;
      return user;
    }

    return null;
  }

  Future<bool> signUp(SignUpViewModel model) async {
    model.roles = ['usuario'];

    Response response = await _httpService.dio.post('/auth', data: {
      'username': model.email,
      'email': model.email,
      'password': model.password,
      'confirmPassword': model.confirmPassword,
      'roles': model.roles,
    });

    if (response.statusCode == 200) {
      return Future.value(true);
    }

    return null;
  }
}
