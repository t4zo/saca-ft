import 'package:dio/dio.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/settings.dart';

class UserRepository {

  Future authenticate(User model) async {
    var url = '$API_URL/auth/authenticate';

    Response response = await Dio().post(url, data: model);

    token = response.data['token'];
    return User.fromJson(response.data['user']);
  }

}