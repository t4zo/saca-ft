import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saca/repositories/user.repository.dart';
import 'package:saca/stores/session.store.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/signup.viewmodel.dart';

class AuthController {
  UserRepository _userRepository;

  AuthController() {
    _userRepository = UserRepository();
  }

  Future<bool> tryAutoLogin(BuildContext context) async {
    final user = await Provider.of<SessionStore>(context, listen: false).tryAutoLogin();
    if (user != null) {
      Provider.of<UserStore>(context, listen: false).setUser(user);
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future authenticate(SignInViewModel model, BuildContext context) async {
    final _userStore = Provider.of<UserStore>(context, listen: false);
    final _sessionStore = Provider.of<SessionStore>(context, listen: false);
    final user = await _userRepository.authenticateAsync(model);
    _sessionStore.setSession(user);
    _userStore.setUser(user);
  }

  Future signUp(SignUpViewModel model, BuildContext context) async {
    return _userRepository.signUp(model);
  }

  Future signOut(BuildContext context) async {
    Provider.of<UserStore>(context, listen: false).setUser(null);
    await Provider.of<SessionStore>(context, listen: false).logout();
  }
}
