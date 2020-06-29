import 'package:injectable/injectable.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';

@lazySingleton
abstract class IUserRepository {
  Future<User> authenticateAsync(SignInViewModel model);
  Future<bool> signUp(SignUpViewModel model);
}
