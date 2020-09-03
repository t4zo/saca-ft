// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SessionStore on _SessionStore, Store {
  Computed<dynamic> _$tokenComputed;

  @override
  dynamic get token => (_$tokenComputed ??=
          Computed<dynamic>(() => super.token, name: '_SessionStore.token'))
      .value;
  Computed<dynamic> _$expiryDateComputed;

  @override
  dynamic get expiryDate =>
      (_$expiryDateComputed ??= Computed<dynamic>(() => super.expiryDate,
              name: '_SessionStore.expiryDate'))
          .value;
  Computed<dynamic> _$authTimerComputed;

  @override
  dynamic get authTimer =>
      (_$authTimerComputed ??= Computed<dynamic>(() => super.authTimer,
              name: '_SessionStore.authTimer'))
          .value;

  final _$_tokenAtom = Atom(name: '_SessionStore._token');

  @override
  String get _token {
    _$_tokenAtom.reportRead();
    return super._token;
  }

  @override
  set _token(String value) {
    _$_tokenAtom.reportWrite(value, super._token, () {
      super._token = value;
    });
  }

  final _$_expiryDateAtom = Atom(name: '_SessionStore._expiryDate');

  @override
  DateTime get _expiryDate {
    _$_expiryDateAtom.reportRead();
    return super._expiryDate;
  }

  @override
  set _expiryDate(DateTime value) {
    _$_expiryDateAtom.reportWrite(value, super._expiryDate, () {
      super._expiryDate = value;
    });
  }

  final _$_authTimerAtom = Atom(name: '_SessionStore._authTimer');

  @override
  Timer get _authTimer {
    _$_authTimerAtom.reportRead();
    return super._authTimer;
  }

  @override
  set _authTimer(Timer value) {
    _$_authTimerAtom.reportWrite(value, super._authTimer, () {
      super._authTimer = value;
    });
  }

  final _$authenticateAsyncAsyncAction =
      AsyncAction('_SessionStore.authenticateAsync');

  @override
  Future<String> authenticateAsync(SignInViewModel signInViewModel) {
    return _$authenticateAsyncAsyncAction
        .run(() => super.authenticateAsync(signInViewModel));
  }

  final _$signUpAsyncAsyncAction = AsyncAction('_SessionStore.signUpAsync');

  @override
  Future<String> signUpAsync(SignUpViewModel model) {
    return _$signUpAsyncAsyncAction.run(() => super.signUpAsync(model));
  }

  final _$signOutAsyncAsyncAction = AsyncAction('_SessionStore.signOutAsync');

  @override
  Future<dynamic> signOutAsync() {
    return _$signOutAsyncAsyncAction.run(() => super.signOutAsync());
  }

  final _$setSessionAsyncAsyncAction =
      AsyncAction('_SessionStore.setSessionAsync');

  @override
  Future<dynamic> setSessionAsync() {
    return _$setSessionAsyncAsyncAction.run(() => super.setSessionAsync());
  }

  final _$logoutAsyncAsyncAction = AsyncAction('_SessionStore.logoutAsync');

  @override
  Future<dynamic> logoutAsync() {
    return _$logoutAsyncAsyncAction.run(() => super.logoutAsync());
  }

  final _$tryAutoLoginAsyncAsyncAction =
      AsyncAction('_SessionStore.tryAutoLoginAsync');

  @override
  Future<User> tryAutoLoginAsync() {
    return _$tryAutoLoginAsyncAsyncAction.run(() => super.tryAutoLoginAsync());
  }

  final _$_SessionStoreActionController =
      ActionController(name: '_SessionStore');

  @override
  void _autoLogout() {
    final _$actionInfo = _$_SessionStoreActionController.startAction(
        name: '_SessionStore._autoLogout');
    try {
      return super._autoLogout();
    } finally {
      _$_SessionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
expiryDate: ${expiryDate},
authTimer: ${authTimer}
    ''';
  }
}
