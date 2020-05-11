import 'package:dio/dio.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/settings.dart';
import 'package:saca/view-models/signin.viewmodel.dart';

class UserRepository {

  Future<User> authenticateAsync(SignInViewModel model) async {
    var url = '$API_URL/auth/authenticate';
    model.remember = false;
    
    Response response = await Dio().post(url, data: model.toJson());

    token = response.data['token'];
    return User.fromJson(response.data['user']);
  }

}