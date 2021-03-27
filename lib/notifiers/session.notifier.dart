import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/repositories/user.repository.dart';
import 'package:saca/notifiers/user.notifier.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionState {
  String token;
  DateTime expiryDate;
  Timer authTimer;

  SessionState({this.token, this.expiryDate, this.authTimer});

  SessionState.empty() {
    this.token = "";
    this.expiryDate = DateTime.now();
    this.authTimer = null;
  }
}

class SessionStore extends StateNotifier<SessionState> {
  final UserStateNotifier _userStateNotifier;
  final UserRepository _userRepository;

  SessionStore(this._userStateNotifier, this._userRepository) : super(SessionState.empty());

  void _autoLogout() {
    final _timeToExpiry = state.expiryDate.difference(DateTime.now()).inSeconds;
    if (state.authTimer != null) {
      state.authTimer.cancel();
      // _authTimer.cancel();
    }
    state = SessionState(token: state.token, expiryDate: state.expiryDate, authTimer: Timer(Duration(hours: _timeToExpiry), logoutAsync));
  }

  Future<String> signInAsync(SignInViewModel signInViewModel) async {
    final http = await _userRepository.signInAsync(signInViewModel);
    if (http.error != null) return http.errorMessage;

    _userStateNotifier.setUser(http.response);
    setSessionAsync();
    return "";
  }

  Future<String> signUpAsync(SignUpViewModel model) async {
    final http = await _userRepository.signUpAsync(model);
    if (http.error != null) return http.errorMessage;

    _userStateNotifier.setUser(http.response);
    setSessionAsync();
    return "";
  }

  Future signOutAsync() async {
    _userStateNotifier.setUser(null);
    await logoutAsync();
  }

  Future setSessionAsync() async {
    final user = _userStateNotifier.state.user;
    final token = user.token;
    final expiryDate = DateTime.now().add(Duration(hours: 24));
    _autoLogout();

    final preferences = await SharedPreferences.getInstance();
    preferences.setString(
        '@session',
        json.encode(
          {'user': user, 'expiryDate': expiryDate.toIso8601String()},
        ));

    state = SessionState(token: token, expiryDate: expiryDate);
  }

  Future logoutAsync() async {
    if (state.authTimer != null) {
      state.authTimer.cancel();
      final preferences = await SharedPreferences.getInstance();
      preferences.clear();

      state = SessionState.empty();
    }
  }

  Future<User> tryAutoLoginAsync() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('@session')) return null;

    final session = json.decode(preferences.getString('@session')) as Map<String, Object>;
    final _expiryDate = DateTime.parse(session['expiryDate']);

    if (_expiryDate.isBefore(DateTime.now())) return null;

    User user = User.fromJson(session['user']);
    final token = user.token;
    final expiryDate = DateTime.parse(session['expiryDate']);

    _userStateNotifier.setUser(user);

    _autoLogout();
    state = SessionState(token: token, expiryDate: expiryDate);
    return user;
  }
}
