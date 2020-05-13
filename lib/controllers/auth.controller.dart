import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saca/repositories/user.repository.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/stores/user.store.dart';

class AuthController {
  UserRepository _userRepository;

  AuthController() {
    _userRepository = UserRepository();
  }

  Future authenticate(SignInViewModel model, BuildContext context) async {
    final _userStore = Provider.of<UserStore>(context, listen: false);
    final user = await _userRepository.authenticateAsync(model);
    _userStore.setUser(user);
  }

  void signOut(BuildContext context) {
    Provider.of<UserStore>(context, listen: false).setUser(null);
  }
}
