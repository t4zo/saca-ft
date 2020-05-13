import 'package:dio/dio.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/services/http.service.dart';
import 'package:saca/settings.dart';
import 'package:saca/view-models/signin.viewmodel.dart';

class UserRepository {
  HttpService _httpService;

  UserRepository() {
    _httpService = HttpService();
  }

  Future<User> authenticateAsync(SignInViewModel model) async {
    var url = '$API_URL/auth/authenticate';
    model.remember = false;
    
    Response response = await _httpService.dio.post(url, data: model);

    userToken = response.data['token'];
    return User.fromJson(response.data['user']);
  }

}