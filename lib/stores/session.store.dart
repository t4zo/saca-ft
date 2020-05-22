import 'dart:async';
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:saca/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session.store.g.dart';

class SessionStore = _SessionStore with _$SessionStore;

abstract class _SessionStore with Store {
  @observable
  String _token;

  @observable
  DateTime _expiryDate;

  @observable
  Timer _authTimer;

  get token => _token;

  get expiryDate => _expiryDate;

  get authTimer => _authTimer;

  void _autoLogout() {
    final _timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    _authTimer = Timer(Duration(hours: _timeToExpiry), logout);
  }

  Future setSession(User user) async {
    _token = user.token;
    _expiryDate = DateTime.now().add(Duration(hours: 24));
    _autoLogout();

    final preferences = await SharedPreferences.getInstance();
    preferences.setString(
        '@session',
        json.encode(
            {'user': user, 'expiryDate': _expiryDate.toIso8601String()}));
  }

  Future logout() async {
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
      final preferences = await SharedPreferences.getInstance();
      preferences.clear();
    }
  }

  Future<User> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('@session')) return null;

    final session =
        json.decode(preferences.getString('@session')) as Map<String, Object>;   
    final expiryDate = DateTime.parse(session['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return null;

    User user = User.fromJson(session['user']);
    _token = user.token;
    _expiryDate = DateTime.parse(session['expiryDate']);

    _autoLogout();
    return user;
  }
}
