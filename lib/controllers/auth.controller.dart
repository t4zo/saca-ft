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
    final user =
        await Provider.of<SessionStore>(context, listen: false).tryAutoLogin();
    if (user == null) return Future.value(false);

    Provider.of<UserStore>(context, listen: false).setUser(user);
    return Future.value(true);
  }

  void authenticate(SignInViewModel signInViewModel, UserStore userStore,
      SessionStore sessionStore) async {
    final user = await _userRepository.authenticateAsync(signInViewModel);
    sessionStore.setSession(user);
    userStore.setUser(user);
  }

  Future<bool> signUp(SignUpViewModel model) async {
    return await _userRepository.signUp(model);
  }

  void signOut(UserStore userStore, SessionStore sessionStore) async {
    userStore.setUser(null);
    await sessionStore.logout();
  }
}
