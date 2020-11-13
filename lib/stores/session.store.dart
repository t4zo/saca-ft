import 'dart:async';
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:saca/models/user.model.dart';
import 'package:saca/repositories/user.repository.dart';
import 'package:saca/stores/user.store.dart';
import 'package:saca/view-models/signin.viewmodel.dart';
import 'package:saca/view-models/signup.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session.store.g.dart';

class SessionStore extends _SessionStore with _$SessionStore {
  SessionStore(UserStore userStore, UserRepository userRepository)
      : super(userStore, userRepository);
}

abstract class _SessionStore with Store {
  final UserStore _userStore;
  final UserRepository _userRepository;

  @observable
  String _token;

  @observable
  DateTime _expiryDate;

  @observable
  Timer _authTimer;

  _SessionStore(this._userStore, this._userRepository);

  @computed
  get token => _token;

  @computed
  get expiryDate => _expiryDate;

  @computed
  get authTimer => _authTimer;

  @action
  void _autoLogout() {
    final _timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    _authTimer = Timer(Duration(hours: _timeToExpiry), logoutAsync);
  }

  @action
  Future<String> signInAsync(SignInViewModel signInViewModel) async {
    final http = await _userRepository.signInAsync(signInViewModel);
    if(http.error != null) return http.errorMessage;
    
    _userStore.setUser(http.response);
    setSessionAsync();
    return "";
  }

  @action
  Future<String> signUpAsync(SignUpViewModel model) async {
    final http = await _userRepository.signUp(model);
    if(http.error != null) return http.errorMessage;

    _userStore.setUser(http.response);
    setSessionAsync();
    return "";
  }

  @action
  Future signOutAsync() async {
    _userStore.setUser(null);
    await logoutAsync();
  }

  @action
  Future setSessionAsync() async {
    final user = _userStore.user;
    _token = user.token;
    _expiryDate = DateTime.now().add(Duration(hours: 24));
    _autoLogout();

    final preferences = await SharedPreferences.getInstance();
    preferences.setString(
        '@session',
        json.encode(
            {'user': user, 'expiryDate': _expiryDate.toIso8601String()}));
  }

  @action
  Future logoutAsync() async {
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
      final preferences = await SharedPreferences.getInstance();
      preferences.clear();
    }
  }

  @action
  Future<User> tryAutoLoginAsync() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('@session')) return null;

    final session =
        json.decode(preferences.getString('@session')) as Map<String, Object>;
    final expiryDate = DateTime.parse(session['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return null;

    User user = User.fromJson(session['user']);
    _token = user.token;
    _expiryDate = DateTime.parse(session['expiryDate']);

    _userStore.setUser(user);

    _autoLogout();
    return user;
  }
}
